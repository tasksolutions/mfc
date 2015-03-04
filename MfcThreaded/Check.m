#import <Foundation/Foundation.h>
#import <time.h>


static const unsigned int possibleBytesNumber = 256;

typedef char (*MostFrequentCharacterFunc)(char * str, int size);
char mostFrequentCharacter(char * bytes, int size);

static void measure(char * str, int size, MostFrequentCharacterFunc mfcFunc) {
    clock_t start = clock();
    char mfc = mfcFunc(str, size);
    clock_t end = clock();
    
    int mfcCode = (unsigned char)mfc;
    int milliseconds = (float)(end - start) * 1000 / CLOCKS_PER_SEC;
    
    NSLog(@"found most frequent character: (\\%d). %d ms elapsed.\n", mfcCode, milliseconds);
}

static void fillRandomBytes(unsigned char * bytes, int bytesCount) {
    for (int i=0; i<bytesCount; ++i) {
        bytes[i] = rand() % possibleBytesNumber;
    }
}

void checkMostFrequentCharacterFunction() {
    int bytesCount = 0x20000000;
    unsigned char * bytes = malloc(bytesCount);
    
    srand((unsigned)time(NULL));
    NSLog(@"filling memory with random bytes...");
    fillRandomBytes(bytes, bytesCount);
    NSLog(@"memory randomized");
    
    measure((char *)bytes, (int)bytesCount, &mostFrequentCharacter);
    
    free(bytes);
}
