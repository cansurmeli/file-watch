//
//  HashFileWithSHA256.h
//  Security Project
//
//  Created by Can Surmeli on 19/04/15.
//  Copyright (c) 2015 Can Sürmeli. All rights reserved.
//

#ifndef __Security_Project__HashFileWithSHA256__
#define __Security_Project__HashFileWithSHA256__

#include <stdio.h>
#include <stdint.h>
#include <CoreFoundation/CoreFoundation.h>
#include <CommonCrypto/CommonDigest.h>

#endif /* defined(__Security_Project__HashFileWithSHA256__) */

CFStringRef FileSHA256HashCreateWithPath(CFStringRef filePath, size_t chunkSizeForReadingData);
