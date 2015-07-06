//
//  GetFileAttribute.m
//  Securtiy Project
//
//  Created by Can on 22/04/15.
//  Copyright (c) 2015 Can Sürmeli. All rights reserved.
//

#import "GetFileAttribute.h"
#import <sys/xattr.h>   // Extended File Attributes

@implementation GetFileAttribute

- (NSString *)getFileAttributeWithName:(const char *)attributeName atPath:(NSString *)filePath
{
	NSString *fileAttribute;
	ssize_t bufferLength = getxattr([filePath cStringUsingEncoding:NSASCIIStringEncoding],
								attributeName,
								NULL,
								0, 0, 0);

	// if the file isn't hashed or encrypted
	if (bufferLength != -1) {
		char *buffer = malloc(bufferLength);
		
		getxattr([filePath cStringUsingEncoding:NSASCIIStringEncoding], attributeName, buffer, 255, 0, 0);
		fileAttribute = [[NSString alloc] initWithBytes:buffer
														   length:bufferLength
														 encoding:NSUTF8StringEncoding];
		
		free(buffer);
	}
	
	return fileAttribute;
}

@end
