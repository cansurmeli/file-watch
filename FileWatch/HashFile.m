//
//  HashFile.m
//  Security Project
//
//  Created by Can on 22/04/15.
//  Copyright (c) 2015 Can Sürmeli. All rights reserved.
//

#import "HashFile.h"
#import "HashFileWithMD5.h"
#import "HashFileWithSHA1.h"
#import "HashFileWithSHA256.h"
#import "SetNewFileAtrribute.h"
#import "sys/xattr.h"   // Extended File Attributes

#define FileHashDefaultChunksSizeForReadingData 4096



@implementation HashFile

- (void)hashFileWithChoice:(NSInteger)menuChoice
					atPath:(NSString *)filePath
{
	
	SetNewFileAtrribute *fileAttribute = [[SetNewFileAtrribute alloc] init];
	
	if (menuChoice == 0) {
		// Generating the hash
		CFStringRef md5Hash = FileMD5HashCreateWithPath((CFStringRef)CFBridgingRetain(filePath),FileHashDefaultChunksSizeForReadingData);
		
		// Converting the hash to NSString
		NSString *fileHash = (NSString *)CFBridgingRelease(md5Hash);

		// set the file's attribute for hash type
		[fileAttribute setFileAttributeWithName:"HashType"
							 withAttributeValue:"MD5"
										 atPath:filePath];
		
		// set the file's attribute for hash value
		[fileAttribute setFileAttributeWithName:"HashValue"
							 withAttributeValue:[fileHash cStringUsingEncoding:NSASCIIStringEncoding]
										 atPath:filePath];
		
		// Result
		NSLog(@"MD5 hash of file at path \"%@\": %@", filePath, fileHash);
		
		// Freeing-up the hash
		// The following caused crashes
		// So I commented it out
//		CFRelease(md5Hash);
	} else if (menuChoice == 1) {
		// Generating the hash
		CFStringRef sha1Hash = FileSHA1HashCreateWithPath((CFStringRef)CFBridgingRetain(filePath),FileHashDefaultChunksSizeForReadingData);
		
		// Converting the hash to NSString
		NSString *fileHash = (NSString *)CFBridgingRelease(sha1Hash);
		
		// set the file's attribute for hash type
		[fileAttribute setFileAttributeWithName:"HashType"
							 withAttributeValue:"SHA-1"
										 atPath:filePath];
		
		// set the file's attribute for hash value
		[fileAttribute setFileAttributeWithName:"HashValue"
							 withAttributeValue:[fileHash cStringUsingEncoding:NSASCIIStringEncoding]
										 atPath:filePath];
		
		// Result
		NSLog(@"MD5 hash of file at path \"%@\": %@", filePath, fileHash);
		
		// Freeing-up the hash
		// The following caused crashes
		// So I commented it out
//		CFRelease(sha1Hash);
	} else if (menuChoice == 2) {
		// Generating the hash
		CFStringRef sha256Hash = FileSHA256HashCreateWithPath((CFStringRef)CFBridgingRetain(filePath),FileHashDefaultChunksSizeForReadingData);
		
		// Converting the hash to NSString
		NSString *fileHash = (NSString *)CFBridgingRelease(sha256Hash);
		
		// set the file's attribute for hash type
		[fileAttribute setFileAttributeWithName:"HashType"
							 withAttributeValue:"SHA-256"
										 atPath:filePath];
		
		// set the file's attribute for hash value
		[fileAttribute setFileAttributeWithName:"HashValue"
							 withAttributeValue:[fileHash cStringUsingEncoding:NSASCIIStringEncoding]
										 atPath:filePath];
		
		// Result
		NSLog(@"MD5 hash of file at path \"%@\": %@", filePath, fileHash);
		
		// Freeing-up the hash
		// The following caused crashes
		// So I commented it out
//		CFRelease(sha256Hash);
	}
}

@end
