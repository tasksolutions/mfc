// Naive implementation.
// Uses `ldrb' instruction to read 1 bytes from memory in one time.
void naiveMfc(unsigned char * bytes, unsigned int bytesCount, unsigned int * freqs) {
    for (int i=0; i<bytesCount; ++i) {
        ++freqs[bytes[i]];
    }
}
