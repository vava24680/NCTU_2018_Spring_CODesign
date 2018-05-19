#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <xparameters.h>
#include "xil_cache.h"

volatile int *hw_active = (int *) (XPAR_MY_DMA_0_S00_AXI_BASEADDR +  0);
volatile int *dst_addr  = (int *) (XPAR_MY_DMA_0_S00_AXI_BASEADDR +  4);
volatile int *src_addr  = (int *) (XPAR_MY_DMA_0_S00_AXI_BASEADDR +  8);
volatile int *len_copy  = (int *) (XPAR_MY_DMA_0_S00_AXI_BASEADDR +  12);

//char test_text[] = "This is a 64-byte string used to test the burst copy operation and hell";

/* ========================================================================== */
/*  Note: This HW IP always copies 16 words of data from *src to *dst.        */
/* ========================================================================== */
void hw_memcpy_16w(void *dst, void *src)
{
    *dst_addr = (int) dst;   // destination word address
    *src_addr = (int) src;   // source word address

    *hw_active = 1;         // trigger the HW IP
    while (*hw_active);     // wait for the transfer to finish
}

void test(unsigned int numberOfWords, char* src)
{
    *len_copy = numberOfWords;
    char* dst = NULL;
    dst = malloc(sizeof(char) * (numberOfWords * 4 + 1));
    for(int i = 0; i < numberOfWords * 4; i++)
    {
        dst[i] = (i % 10) + '0';
    }
    dst[numberOfWords * 4] = '\0';
    printf("\n");
    printf("(1) The source data @ addr [%08X] are:\n\n    \"%s\"\n\n",
    		(unsigned int) src, src);
    printf("(2) The destination data @ addr [%08X] are:\n\n    \"%s\"\n\n",
    		(unsigned int) dst, dst);
    printf("(3) Copying 16 words of data from [%08X] to [%08X] ...\n\n",
    		(unsigned int) src, (unsigned int) dst);
    hw_memcpy_16w((void *) dst, (void *) src);
    printf("(4) The new data at the destination is:\n\n    \"%s\"\n", dst);
    printf("\n");
    free(dst);
    for(int i = 0; i < numberOfWords * 4 - 1; i++)
    {
        if(dst[i] != src[i])
        {
        	printf("dst[i] %c\n", dst[i]);
        	printf("src[i] %c\n", src[i]);
        	printf("i : %d\n", i);
            printf("Copy failed.\n");
            return;
        }
    }
    printf("Copy success.\n");
}

int main(int argc, char **argv)
{
    char *src;
    /* Disable CPU cache for coherent data sharing between HW & SW */
    Xil_DCacheDisable();

    src = (char *) malloc(sizeof(char) * 300);
    for(int i = 0; i < 299; i++)
    {
        if(i < 50)
            src[i] = 'H';
        else if(i < 150)
            src[i] = 'W';
        else
            src[i] = 'G';
    }
    src[299] = '\0';
    test(18, src);
    //test(6, src);
    //test(9, src);
    //test(2, src);


    free(src);
    return 0;
}
