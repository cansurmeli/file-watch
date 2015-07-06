//
//  GetFileAttribute.h
//  Securtiy Project
//
//  Created by Can on 22/04/15.
//  Copyright (c) 2015 Can Sürmeli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetFileAttribute : NSObject

- (NSString *)getFileAttributeWithName:(const char *)attributeName
								atPath:(NSString *)filePath;

@end
