//
//  SetNewFileAtrribute.h
//  Securtiy Project
//
//  Created by Can on 22/04/15.
//  Copyright (c) 2015 Can Sürmeli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SetNewFileAtrribute : NSObject

- (void)setFileAttributeWithName:(const char *)attributeName
			  withAttributeValue:(const char *)attributeValue
						  atPath:(NSString *)filePath;

@end
