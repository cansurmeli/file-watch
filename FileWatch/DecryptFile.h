//
//  DecryptFile.h
//  Security Project
//
//  Created by Can on 22/04/15.
//  Copyright (c) 2015 Can Sürmeli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DecryptFile : NSObject

- (void)decryptFileData:(NSData *)fileData
				 atPath:(NSString *)filePath
		   withPassword:(NSString *)filePassword;

@end
