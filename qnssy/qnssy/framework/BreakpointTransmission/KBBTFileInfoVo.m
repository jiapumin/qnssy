//
//  KBFileInfoVo.m
//  BSMobileSale
//
//  Created by jpm on 12-10-24.
//
//

#import "KBBTFileInfoVo.h"

@implementation KBBTFileInfoVo


- (id)init
{
    self = [super init];
    if (self) {
        self.fileID = @"";
        self.fileName = @"";
        self.fileSize = @"";
        self.isFistReceived = YES;
        self.fileReceivedData = [[[NSMutableData alloc] init] autorelease];
        self.fileReceivedSize = @"";
        self.fileURL = @"";
        self.isDownloading = NO;
        self.isP2P = NO;
        self.sender = @"";
        self.filePath = @"";
        self.guid = @"";
    }
    return self;
}

- (void)dealloc{
    [_fileID release];
    [_fileName release];
    [_fileSize release];
    [_fileReceivedData release];
    [_fileReceivedSize release];
    [_fileURL release];
    [_sender release];
    [_filePath release];
    [_guid release];
    [super dealloc];
}

@end
