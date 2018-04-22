/*
    FreeRTOS V8.2.1 - Copyright (C) 2015 Real Time Engineers Ltd.
    All rights reserved

    VISIT http://www.FreeRTOS.org TO ENSURE YOU ARE USING THE LATEST VERSION.

    This file is part of the FreeRTOS distribution.

    FreeRTOS is free software; you can redistribute it and/or modify it under
    the terms of the GNU General Public License (version 2) as published by the
    Free Software Foundation >>!AND MODIFIED BY!<< the FreeRTOS exception.

    >>!   NOTE: The modification to the GPL is included to allow you to     !<<
    >>!   distribute a combined work that includes FreeRTOS without being   !<<
    >>!   obliged to provide the source code for proprietary components     !<<
    >>!   outside of the FreeRTOS kernel.                                   !<<

    FreeRTOS is distributed in the hope that it will be useful, but WITHOUT ANY
    WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
    FOR A PARTICULAR PURPOSE.  Full license text is available on the following
    link: http://www.freertos.org/a00114.html

    1 tab == 4 spaces!

    ***************************************************************************
     *                                                                       *
     *    Having a problem?  Start by reading the FAQ "My application does   *
     *    not run, what could be wrong?".  Have you defined configASSERT()?  *
     *                                                                       *
     *    http://www.FreeRTOS.org/FAQHelp.html                               *
     *                                                                       *
    ***************************************************************************

    ***************************************************************************
     *                                                                       *
     *    FreeRTOS provides completely free yet professionally developed,    *
     *    robust, strictly quality controlled, supported, and cross          *
     *    platform software that is more than just the market leader, it     *
     *    is the industry's de facto standard.                               *
     *                                                                       *
     *    Help yourself get started quickly while simultaneously helping     *
     *    to support the FreeRTOS project by purchasing a FreeRTOS           *
     *    tutorial book, reference manual, or both:                          *
     *    http://www.FreeRTOS.org/Documentation                              *
     *                                                                       *
    ***************************************************************************

    ***************************************************************************
     *                                                                       *
     *   Investing in training allows your team to be as productive as       *
     *   possible as early as possible, lowering your overall development    *
     *   cost, and enabling you to bring a more robust product to market     *
     *   earlier than would otherwise be possible.  Richard Barry is both    *
     *   the architect and key author of FreeRTOS, and so also the world's   *
     *   leading authority on what is the world's most popular real time     *
     *   kernel for deeply embedded MCU designs.  Obtaining your training    *
     *   from Richard ensures your team will gain directly from his in-depth *
     *   product knowledge and years of usage experience.  Contact Real Time *
     *   Engineers Ltd to enquire about the FreeRTOS Masterclass, presented  *
     *   by Richard Barry:  http://www.FreeRTOS.org/contact
     *                                                                       *
    ***************************************************************************

    ***************************************************************************
     *                                                                       *
     *    You are receiving this top quality software for free.  Please play *
     *    fair and reciprocate by reporting any suspected issues and         *
     *    participating in the community forum:                              *
     *    http://www.FreeRTOS.org/support                                    *
     *                                                                       *
     *    Thank you!                                                         *
     *                                                                       *
    ***************************************************************************

    http://www.FreeRTOS.org - Documentation, books, training, latest versions,
    license and Real Time Engineers Ltd. contact details.

    http://www.FreeRTOS.org/plus - A selection of FreeRTOS ecosystem products,
    including FreeRTOS+Trace - an indispensable productivity tool, a DOS
    compatible FAT file system, and our tiny thread aware UDP/IP stack.

    http://www.FreeRTOS.org/labs - Where new FreeRTOS products go to incubate.
    Come and try FreeRTOS+TCP, our new open source TCP/IP stack for FreeRTOS.

    http://www.OpenRTOS.com - Real Time Engineers ltd license FreeRTOS to High
    Integrity Systems ltd. to sell under the OpenRTOS brand.  Low cost OpenRTOS
    licenses offer ticketed support, indemnification and commercial middleware.

    http://www.SafeRTOS.com - High Integrity Systems also provide a safety
    engineered and independently SIL3 certified version for use in safety and
    mission critical applications that require provable dependability.

    1 tab == 4 spaces!
*/

/* FreeRTOS includes. */
#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "timers.h"
/* Xilinx includes. */
#include "xil_printf.h"
#include "xparameters.h"
/* Custom includes. */
#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include "image.h"
#include "xparameters.h"  /* SDK generated parameters */
#include "xsdps.h"        /* for SD device driver     */
#include "ff.h"
#include "xil_cache.h"
#include "xplatform_info.h"
#include "xtime_l.h"

/* Defined the memory-mapped address For those registers in IP */
volatile int* interfaceRegisters = (int*) (XPAR_COMPUTE_SAD_IP_P3_0_S00_AXI_BASEADDR + 0); 	// 0 ~ 31, 32 bytes
volatile int* regBankRegister = (int*) (XPAR_COMPUTE_SAD_IP_P3_0_S00_AXI_BASEADDR + 32);	// 32 ~ 35, 1 byte
volatile int* hwSwControlRegister = (int*) (XPAR_COMPUTE_SAD_IP_P3_0_S00_AXI_BASEADDR + 36);	// 36 ~ 39, 1 byte
volatile int* hwResultRegister = (int*) (XPAR_COMPUTE_SAD_IP_P3_0_S00_AXI_BASEADDR + 40);	// 40 ~ 43, 1 byte

/* Global Timer is always clocked at half of the CPU frequency */
#define COUNTS_PER_USECOND  (XPAR_CPU_CORTEXA9_CORE_CLOCK_FREQ_HZ / 2000000)
#define FREQ_MHZ ((XPAR_CPU_CORTEXA9_CORE_CLOCK_FREQ_HZ+500000)/1000000)

/* User-defined parameters*/
#define FACE_HEIGHT 32
#define FACE_WIDTH 32
/* Declare a microsecond-resolution timer function */
long get_usec_time()
{
	XTime time_tick;

	XTime_GetTime(&time_tick);
	return (long) (time_tick / COUNTS_PER_USECOND);
}

/* function prototypes. */
void cpy_face_img(uint8 *face);
void median3x3(uint8 *image, int width, int height);
int32 compute_sad(uint8* group, int width, int row, int col);
int32 match(CImage *group, CImage *face, int *posx, int *posy);

/* SD card I/O variables */
static FATFS fatfs;

int main(int argc, char **argv)
{
	CImage group, face;
	int  width, height;
	int  posx, posy;
	int32 cost;
	long tick;

	/* Initialize the SD card driver. */
	if (f_mount(&fatfs, "0:/", 0))
	{
		return XST_FAILURE;
	}

	printf("1. Reading images ... ");
	tick = get_usec_time();

	/* Read the group image file into the DDR main memory */
	if (read_pnm_image("group.pgm", &group))
	{
		printf("\nError: cannot read the group.pgm image.\n");
		return 1;
	}
	width = group.width, height = group.height;

	/* Reading the 32x32 target face image into main memory */
	if (read_pnm_image("face.pgm", &face))
	{
		printf("\nError: cannot read the face.pgm image.\n");
		return 1;
	}
	tick = get_usec_time() - tick;
	printf("done in %ld msec.\n", tick/1000);

	/* Perform median filter for noise removal */
	printf("2. Median filtering ... ");
	tick = get_usec_time();
	median3x3(group.pix, width, height);
	tick = get_usec_time() - tick;
	printf("done in %ld msec.\n", tick/1000);

	/* Copy the face image to custom-IP */
	cpy_face_img(face.pix);

	/* Perform face-matching */
	printf("3. Face-matching ... ");
	tick = get_usec_time();
	cost = match(&group, &face, &posx, &posy);
	tick = get_usec_time() - tick;
	printf("done in %ld msec.\n\n", tick/1000);
	printf("** Found the face at (%d, %d) with cost %ld\n\n", posx, posy, cost);

	/* free allocated memory */
	free(face.pix);
	free(group.pix);

	return 0;
}

void matrix_to_array(uint8 *pix_array, uint8 *ptr, int width)
{
	int  idx, x, y;

	idx = 0;
	for (y = -1; y <= 1; y++)
	{
		for (x = -1; x <= 1; x++)
			{
				pix_array[idx++] = *(ptr+x+width*y);
			}
	}
}

void insertion_sort(uint8 *pix_array, int size)
{
	int idx, jdx;
	uint8 temp;

	for (idx = 1; idx < size; idx++)
	{
		for (jdx = idx; jdx > 0; jdx--)
		{
			if (pix_array[jdx] < pix_array[jdx-1])
			{
				/* swap */
				temp = pix_array[jdx];
				pix_array[jdx] = pix_array[jdx-1];
				pix_array[jdx-1] = temp;
			}
		}
	}
}

void cpy_face_img(uint8 * face)
{
	int loopIndex;
	for(loopIndex = FACE_HEIGHT; loopIndex < 2 * FACE_HEIGHT; loopIndex++)
	{
		*regBankRegister = loopIndex;
		memcpy((void *)interfaceRegisters, face + (loopIndex % FACE_HEIGHT) * FACE_WIDTH, 32);
	}
}

void median3x3(uint8 *image, int width, int height)
{
	int   row, col;
	uint8 pix_array[9], *ptr;

	for (row = 1; row < height-1; row++)
	{
		for (col = 1; col < width-1; col++)
		{
			ptr = image + row*width + col;
			matrix_to_array(pix_array, ptr, width);
			insertion_sort(pix_array, 9);
			*ptr = pix_array[4];
		}
	}
}

int32 compute_sad(uint8* group, int width, int row, int col)
{
	unsigned int loopIndex = 0;
    int zero_array[32]={0};
	if(row == 0)
	{
		for(loopIndex = 0; loopIndex < FACE_HEIGHT; loopIndex++)
		{
			*regBankRegister = loopIndex;
			memcpy((void *)interfaceRegisters, zero_array/*group + loopIndex * width + col*/, 32);
		}
	}
	else
	{
		*regBankRegister = (row - 1) % FACE_HEIGHT;
		memcpy( (void *)interfaceRegisters, group + (row + FACE_HEIGHT - 1) * width + col, 32);
	}

	*hwSwControlRegister = 1;
	while(*hwSwControlRegister);
	return *hwResultRegister;
}

int32 match(CImage *group, CImage *face, int *posx, int *posy)
{
	int  row, col;
	int32  sad, min_sad;

	min_sad = 256*face->width*face->height;
	for (col = 0; col < 1/*(group->width - face->width + 1)*/; col++)
	{
		for (row = 0; row < 1/*(group->height - face->height + 1)*/; row++)
		{
			sad = compute_sad(group->pix, group->width, row, col);
			if(sad < min_sad)
			{
				min_sad = sad;
				*posx = col;
				*posy = row;
			}
		}
	}
	return min_sad;
}

