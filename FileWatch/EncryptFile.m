//
//  EncryptFile.m
//  Security Project
//
//  Created by Can on 22/04/15.
//  Copyright (c) 2015 Can Sürmeli. All rights reserved.
//

#import "EncryptFile.h"
#import "RNEncryptor.h"   // AES Encryption
#import "SetNewFileAtrribute.h"

@implementation EncryptFile

- (void)encryptFileData:(NSData *)fileData
				 atPath:(NSString *)filePath
		   withPassword:(NSString *)filePassword
{
	NSError *error;   // just a generic error handler
	SetNewFileAtrribute *fileAttribute = [[SetNewFileAtrribute alloc] init];
	
	NSData *encryptedData = [RNEncryptor encryptData:fileData
										withSettings:kRNCryptorAES256Settings
											password:filePassword
											   error:&error];
	
	// Save the encrypted data
	[encryptedData writeToFile:filePath
					   options:NSDataWritingAtomic
						 error:&error];
	
	// set the file's attribute for encryption type
	[fileAttribute setFileAttributeWithName:"EncryptionType"
						 withAttributeValue:"AES"
									 atPath:filePath];
	
	NSLog(@"File at %@ successfully encrypted!", filePath);
}

@end
