//
//  MyTableViewCell.m
//  ContactDocFilesManage
//
//  Created by Sophie Sun on 12-4-26.
//  Copyright (c) 2012年 baosight. All rights reserved.
//

#import "AboutTableCell_iPhone.h"

@implementation AboutTableCell_iPhone


- (void)dealloc {

    [_leftLabel release];
    [_rightLabel release];
    [super dealloc];
}
@end
