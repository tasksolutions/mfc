#include <Foundation/Foundation.h>

#include <time.h>

void qwordMfc(unsigned char * bytes, unsigned int bytesCount, unsigned int * freqs);
void naiveMfc(unsigned char * bytes, unsigned int bytesCount, unsigned int * freqs);

static const unsigned int possibleBytesNumber = 256;
static const unsigned int threadsNumber = 2;

static void sumFrequencies(unsigned int * freqs1, unsigned int * freqs2, unsigned int * sumFreqs) {
    for (int i=0; i<possibleBytesNumber; ++i) {
        sumFreqs[i] = freqs1[i] + freqs2[i];
    }
}

static int indexOfMaxFrequentChar(unsigned int * freqs) {
    int indexOfMaxFreqFound = 0;
    unsigned int maxFreqFound = 0;
    for (int i=0; i<possibleBytesNumber; ++i) {
        if (freqs[i] > maxFreqFound) {
            maxFreqFound = freqs[i];
            indexOfMaxFreqFound = i;
        }
    }
    
    return indexOfMaxFreqFound;
}

// Function splits array by 3 parts: first and second parts contain multiple of 8 bytes, third part is rest:
// Example: if total bytes count is 79 then first and second parts contain
// Third part contain
// Most frequent characters for first two parts are calculated by qwordMfc.
// Most frequent character for third part is calculated by naiveMfc.
int mostFrequentCharacterEx(char * str, int size, char * resultChar) {
    unsigned char * bytes = (unsigned char *)str;
    
    unsigned int _freqs1[possibleBytesNumber] = {0};
    unsigned int _freqs2[possibleBytesNumber] = {0};
    unsigned int * freqs1 = _freqs1;
    unsigned int * freqs2 = _freqs2;
    unsigned int remainingFreqs[possibleBytesNumber] = {0};
    unsigned int sumFreqs[possibleBytesNumber] = {0};
    
    unsigned int bytesInQword = 8;
    unsigned int splitedSize = (size / (threadsNumber * bytesInQword)) * bytesInQword;
    unsigned int remainingSize = size - (threadsNumber * splitedSize);
    
    dispatch_group_t g = dispatch_group_create();
    dispatch_group_async(g, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        qwordMfc(bytes, splitedSize, freqs1);
    });
    dispatch_group_async(g, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        qwordMfc(bytes + splitedSize, splitedSize, freqs2);
    });
    dispatch_group_wait(g, DISPATCH_TIME_FOREVER);
    dispatch_release(g);
    
    naiveMfc(bytes + 2*splitedSize, remainingSize, remainingFreqs);
    
    sumFrequencies(freqs1, freqs2, sumFreqs);
    sumFrequencies(sumFreqs, remainingFreqs, sumFreqs);
    
    *resultChar = (char)indexOfMaxFrequentChar(sumFreqs);
    return 0;
}

char mostFrequentCharacter(char * str, int size) {
    char resultChar;
    if (mostFrequentCharacterEx(str, size, &resultChar) == 0) {
        return resultChar;
    } else {
        return (char)0;
    }
}
