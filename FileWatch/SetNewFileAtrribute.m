//
//  SetNewFileAtrribute.m
//  Securtiy Project
//
//  Created by Can on 22/04/15.
//  Copyright (c) 2015 Can Sürmeli. All rights reserved.
//

#import "SetNewFileAtrribute.h"
#import <sys/xattr.h>   // Extended File Attributes



@implementation SetNewFileAtrribute

- (void)setFileAttributeWithName:(const char *)attributeName
			  withAttributeValue:(const char *)attributeValue
						  atPath:(NSString *)filePath
{
	setxattr([filePath cStringUsingEncoding:NSASCIIStringEncoding],
			 attributeName,
			 attributeValue,
			 strlen(attributeValue),
			 0,
			 0);
}

@end
