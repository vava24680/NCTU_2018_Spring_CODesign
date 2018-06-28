/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include <stdlib.h>
#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"
/* Custom includes. */
#include "image.h"
#include "xparameters.h"  /* SDK generated parameters */
#include "xsdps.h"        /* for SD device driver     */
#include "ff.h"
#include "xil_cache.h"
#include "xplatform_info.h"
#include "xtime_l.h"

#define FACE_HEIGHT 32
#define FACE_WIDTH 32
#define GROUP_HEIGHT 1080
#define GROUP_WIDTH 1920
#define COUNTS_PER_USECOND  (XPAR_CPU_CORTEXA9_CORE_CLOCK_FREQ_HZ / 2000000)
#define FREQ_MHZ ((XPAR_CPU_CORTEXA9_CORE_CLOCK_FREQ_HZ+500000)/1000000)

volatile unsigned int* hw_active = (unsigned int*)(XPAR_TRANSFER_0_S00_AXI_BASEADDR + 0);
volatile unsigned int* face_src_addr = (unsigned int*)(XPAR_TRANSFER_0_S00_AXI_BASEADDR + 8);
volatile unsigned int* group_src_addr = (unsigned int*)(XPAR_TRANSFER_0_S00_AXI_BASEADDR + 12);
volatile unsigned int* element1 = (unsigned int*)(XPAR_TRANSFER_0_S00_AXI_BASEADDR + 16);
volatile unsigned int* element2 = (unsigned int*)(XPAR_TRANSFER_0_S00_AXI_BASEADDR + 20);
volatile unsigned int* element3 = (unsigned int*)(XPAR_TRANSFER_0_S00_AXI_BASEADDR + 24);
volatile unsigned int* miniSAD = (unsigned int*)(XPAR_TRANSFER_0_S00_AXI_BASEADDR + 28);
volatile unsigned int* xIndexAns = (unsigned int*)(XPAR_TRANSFER_0_S00_AXI_BASEADDR + 32);
volatile unsigned int* yIndexAns = (unsigned int*)(XPAR_TRANSFER_0_S00_AXI_BASEADDR + 36);

long get_usec_time()
{
	XTime time_tick;

	XTime_GetTime(&time_tick);
	return (long) (time_tick / COUNTS_PER_USECOND);
}

/* function prototypes. */
void matrix_to_array(uint8 *pix_array, uint8 *ptr, int width);
void insertion_sort(uint8 *pix_array, int size);
void median3x3(uint8 *image, int width, int height);
int compute_one_face( CImage *group, CImage *face, unsigned int* groupBuffer, unsigned int* faceBuffer, char* faceFileName);

/* SD card I/O variables */
static FATFS fatfs;


int main(int argc, char **argv)
{
	CImage group, face;
	unsigned int* groupBuffer;
	unsigned int* faceBuffer;
	int  width, height;
	long tick;

	/* Initialize the SD card driver. */
	if (f_mount(&fatfs, "0:/", 0))
	{
		return XST_FAILURE;
	}
	printf("1-1. Reading group image ... ");
	tick = get_usec_time();

	/* Read the group image file into the DDR main memory */
	if (read_pnm_image("group.pgm", &group))
	{
		printf("\nError: cannot read the group.pgm image.\n");
		return 1;
	}
	width = group.width, height = group.height;

	tick = get_usec_time() - tick;
	printf("done in %ld msec.\n", tick/1000);

	/* Perform median filter for noise removal */
	printf("1-2. Median filtering ... ");
	tick = get_usec_time();
	median3x3(group.pix, width, height);
	tick = get_usec_time() - tick;
	printf("done in %ld msec.\n", tick/1000);
	Xil_DCacheDisable();

	groupBuffer = malloc(sizeof(unsigned int) * GROUP_HEIGHT * GROUP_WIDTH);
	faceBuffer = malloc(sizeof(unsigned int) * FACE_HEIGHT * FACE_WIDTH);

	for(int i = 0; i < GROUP_HEIGHT; ++i)
	{
		for(int j = 0; j < GROUP_WIDTH; ++j)
		{
			groupBuffer[i * GROUP_WIDTH + j] = (unsigned int)group.pix[i * GROUP_WIDTH + j];
		}
	}

	/*printf("\n-----\n");
	printf("First Face:\n");
	compute_one_face(&group, &face, groupBuffer, faceBuffer, "face.pgm");*/

	printf("\n-----\n");
	printf("1.Face:\n");
	compute_one_face(&group, &face, groupBuffer, faceBuffer, "face1.pgm");

	printf("\n-----\n");
	printf("2.Face:\n");
	compute_one_face(&group, &face, groupBuffer, faceBuffer, "face2.pgm");

	printf("\n-----\n");
	printf("3.Face:\n");
	compute_one_face(&group, &face, groupBuffer, faceBuffer, "face3.pgm");

	printf("\n-----\n");
	printf("4.Face:\n");
	compute_one_face(&group, &face, groupBuffer, faceBuffer, "face4.pgm");

	printf("\n-----\n");
	printf("5.Face:\n");
	compute_one_face(&group, &face, groupBuffer, faceBuffer, "face5.pgm");

	printf("\n-----\n");
	printf("6.Face:\n");
	compute_one_face(&group, &face, groupBuffer, faceBuffer, "face6.pgm");

	printf("\n-----\n");
	printf("7.Face:\n");
	compute_one_face(&group, &face, groupBuffer, faceBuffer, "face7.pgm");

	printf("\n-----\n");
	printf("8.Face:\n");
	compute_one_face(&group, &face, groupBuffer, faceBuffer, "face8.pgm");

	/* free allocated memory */
	free(face.pix);
	free(group.pix);
	free(groupBuffer);
	free(faceBuffer);

	return 0;
}

int compute_one_face( CImage *group, CImage *face, unsigned int* groupBuffer, unsigned int* faceBuffer, char* faceFileName)
{
	long tick;
	printf("1-3. Reading face image ... ");
	tick = get_usec_time();

	/* Reading the 32x32 target face image into main memory */
	if (read_pnm_image(faceFileName, face))
	{
		printf("\nError: cannot read the face.pgm image.\n");
		return 1;
	}
	tick = get_usec_time() - tick;
	printf("done in %ld msec.\n", tick/1000);

	for(int i = 0; i < FACE_HEIGHT; ++i)
	{
		for(int j = 0; j < FACE_WIDTH; ++j)
		{
			faceBuffer[i * FACE_WIDTH + j] = (unsigned int)face->pix[i * FACE_WIDTH + j];
		}
	}

	*face_src_addr = (unsigned int)faceBuffer;
	*group_src_addr = (unsigned int)groupBuffer;
	/* Perform face-matching */
	printf("3. Face-matching ... ");
	tick = get_usec_time();
	*hw_active = 1;
	while((*hw_active));
	tick = get_usec_time() - tick;
	printf("\nminiSAD, %d\n",*miniSAD);
	printf("xIndexAns, %d\n",*xIndexAns);
	printf("yIndexAns, %d\n",*yIndexAns);
	printf("done in %ld msec.\n\n", tick/1000);
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

/*
int main()
{
	Xil_DCacheDisable();
    //unsigned char* face = malloc(sizeof(unsigned char) * FACE_HEIGHT * FACE_WIDTH);
    //unsigned char* group = malloc(sizeof(unsigned char) * GROUP_HEIGHT * GROUP_WIDTH);
    unsigned int* face = malloc(sizeof(unsigned int) * FACE_HEIGHT * FACE_WIDTH);
    unsigned int* group = malloc(sizeof(unsigned int) * GROUP_HEIGHT * GROUP_WIDTH);

    for(unsigned int i = 0; i < FACE_HEIGHT; ++i)
    {
        for(unsigned int j = 0; j < FACE_WIDTH; ++j)
            face[i * FACE_WIDTH + j] = 0;
    }
    for(unsigned int i = 0; i < GROUP_HEIGHT; ++i)
    {
        for(unsigned int j = 0; j < GROUP_WIDTH; ++j)
            group[i * GROUP_WIDTH + j] = (i * GROUP_WIDTH + j) % 254;
    }
    Xil_DCacheFlush();
    unsigned int sad = 0;
    unsigned int minisad = 256*1024;
    unsigned int minx = 0;
    unsigned int miny = 0;
    for(int i = 0; i < GROUP_HEIGHT - FACE_HEIGHT + 1; ++i)
	{
		for(int j = 0; j < FACE_HEIGHT; ++j)
		{
			for(int k = 0; k < FACE_WIDTH; ++k)
			{
				sad += abs(face[j * FACE_WIDTH + k] - group[(j + i) * GROUP_WIDTH + k]);
			}
		}
		if(sad < minisad)
		{
			minisad = sad;
			miny = i;
		}
		printf("(0, %d), %u\n",i, sad);
		sad = 0;
	}
    printf("minisad by software : %d\n", minisad);
    printf("(%d, %d)\n",minx,miny);
    *face_src_addr = (unsigned int)face;
    *group_src_addr = (unsigned int)group;
    printf("face, %p\n", face);
    printf("group, %p\n", group);
    for(unsigned int i = 0; i < 5; i++)
        printf("group[%d], %d\n",i,group[i]);
    *hw_active = 1;
    while(*hw_active){};
    printf("%d\n",*miniSAD);
    printf("%d\n",*xIndexAns);
    printf("%d\n",*yIndexAns);
}
*/
