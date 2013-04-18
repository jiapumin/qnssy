//
//  MyTableViewCell.m
//  ContactDocFilesManage
//
//  Created by Sophie Sun on 12-4-26.
//  Copyright (c) 2012年 baosight. All rights reserved.
//

#import "BSMyAttentionTableViewCell_iPhone.h"

@implementation BSMyAttentionTableViewCell_iPhone

- (void)dealloc {
    [_leftImageView release];
    [_nickname release];
    [_myInfo release];
    [_income release];
    [super dealloc];
}
@end
