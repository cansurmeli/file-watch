//
//  ViewController.m
//  FileWatch
//
//  Created by Can on 30/06/15.
//  Copyright (c) 2015 Can Sürmeli. All rights reserved.
//

#import "ViewController.h"
#import "GetFileAttribute.h"
#import "EncryptFile.h"
#import "DecryptFile.h"
#import "HashFile.h"
#import "ValidateFile.h"

@interface ViewController ()
@property (weak) IBOutlet NSMatrix *hashingOptions;
@property (weak) IBOutlet NSSecureTextField *filePassword;
@property (strong, nonatomic) NSURL *fileURL;
@property (strong, nonatomic) NSString *filePath;
@property (strong, nonatomic) NSString *fileName;
@property (strong, nonatomic) NSData *fileData;
@property (strong) IBOutlet NSTextField *fileHashStatus;
@property (strong) IBOutlet NSTextFieldCell *fileEncryptionStatus;
@property (strong, nonatomic) NSString *fileStatusReport;
@property (weak) IBOutlet NSSecureTextField *passwordField;
@property (strong, nonatomic) NSError *error;
@property (strong, nonatomic) GetFileAttribute *fileAttributes;
@property (strong, nonatomic) HashFile *fileHashing;
@property (strong, nonatomic) ValidateFile *fileValidation;
@property (strong, nonatomic) EncryptFile *fileEncrypting;
@property (strong, nonatomic) DecryptFile *fileDecrypting;
@property (weak) IBOutlet NSTextField *fileNameViewLabel;
@property BOOL isEncrypted;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	// Do any additional setup after loading the view.

	// Allocate the required objects
	_fileAttributes = [[GetFileAttribute alloc] init];
	_fileHashing = [[HashFile alloc] init];
	_fileValidation = [[ValidateFile alloc] init];
	_fileEncrypting = [[EncryptFile alloc] init];
	_fileDecrypting = [[DecryptFile alloc] init];
}

- (void)setRepresentedObject:(id)representedObject {
	[super setRepresentedObject:representedObject];

	// Update the view, if already loaded.
}

// Things happen when a file is choosen
- (IBAction)chooseAFile:(NSButton *)sender
{
	// 'Choose file' dialog and it's properties
	NSOpenPanel *fileChoosingDialog = [NSOpenPanel openPanel];
	[fileChoosingDialog setCanChooseDirectories:NO];
	[fileChoosingDialog setCanChooseFiles:YES];
	[fileChoosingDialog setAllowsMultipleSelection:NO];

	// Reset the view
	// if there was a file before
	[_hashingOptions setEnabled:YES];
	[_fileHashStatus setStringValue:@""];
	[_fileEncryptionStatus setStringValue:@""];

	// If something choosen, process it
	if ([fileChoosingDialog runModal] == NSModalResponseOK) {
		_fileURL = [fileChoosingDialog URL];   // get the file path along with the file name
		_fileName = [[_fileURL absoluteString] lastPathComponent];   // parse the file name
		[_fileNameViewLabel setStringValue:_fileName];   // show the file name on the UI
	}

	// Check if the file is already hashed
	if ([_fileAttributes getFileAttributeWithName:"HashType" atPath:[_fileURL path]]) {
		NSLog(@"This file is already hashed");
		[_hashingOptions setEnabled:NO];
		BOOL isValid = [_fileValidation validateFileAtPath:[_fileURL path]];

		// Check if the hash is valid
		if (isValid) {
			[_fileHashStatus setStringValue:@"This file is already hashed and valid."];
		} else if (!isValid) {
			[_fileHashStatus setStringValue:@"This file is already hashed BUT invalid."];
		}
	}

	// Check if the file is encrypted
	if ([_fileAttributes getFileAttributeWithName:"EncryptionType" atPath:[_fileURL path]]) {
		NSLog(@"This file is already encrypted.");
		[_fileEncryptionStatus setStringValue:@"This file is already encrypted."];
	} else {
		[_fileEncryptionStatus setStringValue:@"This file is not encrypted."];
	}
}

// Things happen on a file choosen when the 'Process' button is pressed
- (IBAction)processFile:(NSButton *)sender
{
	NSError *error;
	_fileData = [NSData dataWithContentsOfFile:[_fileURL absoluteString]
									   options:0
										 error:&error];

	// Determine which hash option was selected
	NSInteger selectedHashOption = [_hashingOptions selectedRow];

	_filePath = [_fileURL path];   // convert the file URL into file path

	// If encrypted, make decryption available
	if ([_fileAttributes getFileAttributeWithName:"EncryptionType" atPath:[_fileURL path]]) {
		// Decrypt the file
		[_fileDecrypting decryptFileData:_fileData
								  atPath:[_fileURL path]
							withPassword:[_passwordField stringValue]];

		_passwordField.stringValue = @"";   // clear the password field
		[_fileEncryptionStatus setStringValue:@"File decrypted."];
	} else if ([[_passwordField stringValue] length] > 0) {
		// Encrypt the file
		[_fileEncrypting encryptFileData:_fileData
								  atPath:[_fileURL path]
							withPassword:[_passwordField stringValue]];

		_passwordField.stringValue = @"";   // clear the password field
		[_fileEncryptionStatus setStringValue:@"File encrypted."];
	}

	// Hash the file
	if (selectedHashOption != -1) {
		[_fileHashing hashFileWithChoice:selectedHashOption
								  atPath:_filePath];

		// Give the user some feedback
		if (selectedHashOption == 0) {
			[_fileHashStatus setStringValue:@"File hashed with MD5."];
		} else if (selectedHashOption == 1) {
			[_fileHashStatus setStringValue:@"File hashed with SHA-1."];
		} else if (selectedHashOption == 2) {
			[_fileHashStatus setStringValue:@"File hashed with SHA-256."];
		}
	}
}

@end
