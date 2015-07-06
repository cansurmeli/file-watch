//
//  DecryptFile.m
//  Security Project
//
//  Created by Can on 22/04/15.
//  Copyright (c) 2015 Can Sürmeli. All rights reserved.
//

#import "DecryptFile.h"

#import "RNDecryptor.h"

@implementation DecryptFile

- (void)decryptFileData:(NSData *)fileData
				 atPath:(NSString *)filePath
		   withPassword:(NSString *)filePassword
{
	NSError *error;   // just a generic error handler
	NSData *decryptedData;
	
	if ((decryptedData = [RNDecryptor decryptData:fileData
									 withPassword:filePassword
											error:&error]))
	{
		[decryptedData writeToFile:filePath
						   options:NSDataWritingAtomic
							 error:&error];
		
		NSLog(@"File at %@ successfully decrypted.", filePath);
	} else {
		NSLog(@"Wrong password. File at %@ could NOT be decrypted.", filePath);
	}
}

@end
