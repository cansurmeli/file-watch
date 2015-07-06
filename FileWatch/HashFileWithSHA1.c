//
//  HashFileWithSHA1.c
//  Security Project
//
//  Created by Can Surmeli on 19/04/15.
//  Copyright (c) 2015 Can Sürmeli. All rights reserved.
//

#include "HashFileWithSHA1.h"

#define FileHashDefaultChunksSizeForReadingData 4096



CFStringRef FileSHA1HashCreateWithPath(CFStringRef filePath, size_t chunkSizeForReadingData)
{
    CFStringRef result = NULL;
    CFReadStreamRef readStream = NULL;
    
    CFURLRef fileURL = CFURLCreateWithFileSystemPath(kCFAllocatorDefault,
                                                     (CFStringRef)filePath,
                                                     kCFURLPOSIXPathStyle,
                                                     (Boolean) false);
    
    if (!fileURL) {
        goto done;
    }
    
    readStream = CFReadStreamCreateWithFile(kCFAllocatorDefault,
                                            (CFURLRef)fileURL);
    
    if (!readStream) {
        goto done;
    }
    
    bool didSucceed = (bool)CFReadStreamOpen(readStream);
    
    if (!didSucceed) {
        goto done;
    }
    
    // Initialize the hash object
    CC_SHA1_CTX hashObject;
    CC_SHA1_Init(&hashObject);
    
    // Make sure the chunkSizeForReadindData is valid
    if (!chunkSizeForReadingData) {
        chunkSizeForReadingData = FileHashDefaultChunksSizeForReadingData;
    }
    
    // Feed the data to the hash object
    bool hasMoreData = true;
    while (hasMoreData) {
        uint8_t buffer[chunkSizeForReadingData];
        CFIndex readBytesCount = CFReadStreamRead(readStream,
                                                  (UInt8 *)buffer,
                                                  (CFIndex)sizeof(buffer));
        
        if (readBytesCount == -1) {
            break;
        }
        
        if (readBytesCount == 0) {
            hasMoreData = false;
            continue;
        }
        
        CC_SHA1_Update(&hashObject, (const void *)buffer, (CC_LONG)readBytesCount);
    }
    
    // Check if the read operation has succeded
    didSucceed = !hasMoreData;
    
    // Compute the hash digest
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1_Final(digest, &hashObject);
    
    // Abort if the read operation fails
    if (!didSucceed) {
        goto done;
    }
    
    // Compute the string result
    char hash[2 * sizeof(digest) + 1];
    for (size_t i = 0; i < sizeof(digest); ++i) {
        snprintf(hash + (2 * i), 3, "%02x", (int)(digest[i]));
    }
    
    result = CFStringCreateWithCString(kCFAllocatorDefault, (const char *)hash, kCFStringEncodingUTF8);
    
    
    
done:
    if (readStream) {
        CFReadStreamClose(readStream);
        CFRelease(readStream);
    }
    
    if (fileURL) {
        CFRelease(fileURL);
    }
    
    return result;
}