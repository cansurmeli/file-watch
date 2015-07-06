//
//  HashFileWithMD5.h
//  Security Project
//
//  Created by Can Surmeli on 19/04/15.
//  Copyright (c) 2015 Can Sürmeli. All rights reserved.
//

#ifndef __Security_Project__HashFileWithMD5__
#define __Security_Project__HashFileWithMD5__

#include <stdint.h>
#include <stdio.h>
#include <CoreFoundation/CoreFoundation.h>
#include <CommonCrypto/CommonDigest.h>

#endif /* defined(__Security_Project__HashFileWithMD5__) */

CFStringRef FileMD5HashCreateWithPath(CFStringRef filePath, size_t chunkSizeForReadingData);
