//
//  ValidateFile.m
//  Security Project
//
//  Created by Can on 22/04/15.
//  Copyright (c) 2015 Can Sürmeli. All rights reserved.
//

#import "ValidateFile.h"
#import "HashFileWithMD5.h"
#import "HashFileWithSHA1.h"
#import "HashFileWithSHA256.h"
#import "GetFileAttribute.h"

#define FileHashDefaultChunksSizeForReadingData 4096

@implementation ValidateFile

- (BOOL)validateFileAtPath:(NSString *)filePath
{
	GetFileAttribute *fileAttribute = [[GetFileAttribute alloc] init];
	
	// Get the hash type and value from the file header
	NSString *currentFileHashType = [fileAttribute getFileAttributeWithName:"HashType"
																	  atPath:filePath];
	NSString *currentFileHashValue = [fileAttribute getFileAttributeWithName:"HashValue"
																	  atPath:filePath];
	NSString *fileHash;
	BOOL isValid;
	
	
	
	// Consider the hash type
	if ([currentFileHashType isEqualToString:@"MD5"]) {
		// Re-hash the file data
		CFStringRef md5Hash = FileMD5HashCreateWithPath((CFStringRef)CFBridgingRetain(filePath),
														FileHashDefaultChunksSizeForReadingData);
		
		// Convert the hash to NSString
		fileHash = (NSString *)CFBridgingRelease(md5Hash);
	} else if ([currentFileHashType isEqualToString:@"SHA-1"]) {
		// Generating the hash
		CFStringRef sha1Hash = FileSHA1HashCreateWithPath((CFStringRef)CFBridgingRetain(filePath), FileHashDefaultChunksSizeForReadingData);
		
		// Converting the hash to NSString
		fileHash = (NSString *)CFBridgingRelease(sha1Hash);
	} else if ([currentFileHashType isEqualToString:@"SHA-256"]) {
		// Generating the hash
		CFStringRef sha256Hash = FileSHA256HashCreateWithPath((CFStringRef)CFBridgingRetain(filePath), FileHashDefaultChunksSizeForReadingData);
		
		// Converting the hash to NSString
		fileHash = (NSString *)CFBridgingRelease(sha256Hash);
	}
	
	if ([currentFileHashValue isEqualToString:fileHash]) {
		NSLog(@"File at %@ is valid!", filePath);
		isValid = YES;
	} else {
		NSLog(@"File at %@ is invalid!", filePath);
		isValid = NO;
	}
	
	return isValid;
}

@end
