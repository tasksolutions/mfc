#include <assert.h>

// Most optimized implementation.
// Uses `ldrd' ARM instruction to read 8 bytes from memory at once.
void qwordMfcRaw(unsigned char * bytes, unsigned int bytesCount, unsigned int * freqs) {
    unsigned long long * qwords = (unsigned long long *)bytes;
    unsigned int qwordsCount = bytesCount/8;
    
    for (int i=0; i<qwordsCount; ++i) {
        unsigned long long qword = qwords[i];
        ++freqs[(qword >> 0 * 8) & 0xff];
        ++freqs[(qword >> 1 * 8) & 0xff];
        ++freqs[(qword >> 2 * 8) & 0xff];
        ++freqs[(qword >> 3 * 8) & 0xff];
        ++freqs[(qword >> 4 * 8) & 0xff];
        ++freqs[(qword >> 5 * 8) & 0xff];
        ++freqs[(qword >> 6 * 8) & 0xff];
        ++freqs[(qword >> 7 * 8) & 0xff];
    }
}

void qwordMfc(unsigned char * bytes, unsigned int bytesCount, unsigned int * freqs) {
    assert(bytesCount % 8 == 0);
    qwordMfcRaw(bytes, bytesCount, freqs);
}
