#include <assert.h>

// Optimized implementation.
// Uses `ldr.w' ARM instruction to read 4 bytes from memory at once.
void dwordMfcRaw(unsigned char * bytes, unsigned int n, unsigned int * freqs) {
    unsigned int * dwords = (unsigned int *)bytes;
    unsigned int dwordsCount = n/4;
    
    for (int i=0; i<dwordsCount; ++i) {
        unsigned int dword = dwords[i];
        ++freqs[dword >> 0  & 0xff];
        ++freqs[dword >> 8  & 0xff];
        ++freqs[dword >> 16 & 0xff];
        ++freqs[dword >> 24 & 0xff];
    }
}


void dwordMfc(unsigned char * bytes, unsigned int bytesCount, unsigned int * freqs) {
    assert(bytesCount % 4 == 0);
    dwordMfcRaw(bytes, bytesCount, freqs);
}
