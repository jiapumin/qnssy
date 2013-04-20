//
//  MyTableViewCell.m
//  ContactDocFilesManage
//
//  Created by Sophie Sun on 12-4-26.
//  Copyright (c) 2012年 baosight. All rights reserved.
//

#import "BaseInfoTableViewCell_iPhone.h"

@implementation BaseInfoTableViewCell_iPhone


- (void)dealloc {

    [_leftLabel release];
    [_rightLabel release];
    [super dealloc];
}
@end
