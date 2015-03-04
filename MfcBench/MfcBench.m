#import <Foundation/Foundation.h>
#import <stdlib.h>
#import <time.h>


static const unsigned int possibleBytesNumber = 256;

void naiveMfc(unsigned char * bytes, unsigned int n, unsigned int * freqs);
void dwordMfc(unsigned char * bytes, unsigned int n, unsigned int * freqs);
void qwordMfc(unsigned char * bytes, unsigned int n, unsigned int * freqs);

typedef void (*MostFrequentCharacterFunc)(unsigned char * bytes, unsigned int n, unsigned int * freqs);

static void measure(unsigned char * bytes, int bytesCount, const char * tag, MostFrequentCharacterFunc f) {
    unsigned int freqs[possibleBytesNumber];
    for (int i=0; i<possibleBytesNumber; ++i) { freqs[i] = 0; }
    
    clock_t start = clock();
    f(bytes, bytesCount, freqs);
    clock_t end = clock();
    
    int milliseconds = (float)(end - start) * 1000 / CLOCKS_PER_SEC;
    NSLog(@"%s: %d ms elapsed", tag, milliseconds);
}

static void fillRandomBytes(unsigned char * bytes, int bytesCount) {
    for (int i=0; i<bytesCount; ++i) {
        bytes[i] = rand() % possibleBytesNumber;
    }
}

void runBench() {
    int bytesCount = 0x10000000;
    unsigned char * bytes = malloc(bytesCount);
    
    srand((unsigned)time(NULL));
    NSLog(@"filling memory with random bytes...");
    fillRandomBytes(bytes, bytesCount);
    NSLog(@"memory randomized");
    
    measure(bytes, bytesCount, "naive", naiveMfc);
    measure(bytes, bytesCount, "dword", dwordMfc);
    measure(bytes, bytesCount, "qword", qwordMfc);
    
    free(bytes);
}
