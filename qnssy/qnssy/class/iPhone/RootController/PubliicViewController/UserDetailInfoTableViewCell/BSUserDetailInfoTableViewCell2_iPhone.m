//
//  BSUserDetailInfoTableViewCell1_iPhone.m
//  qnssy
//
//  Created by jpm on 13-4-19.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSUserDetailInfoTableViewCell2_iPhone.h"

@implementation BSUserDetailInfoTableViewCell2_iPhone

- (void)reloadData:(NSDictionary *)dic{
    
    self.userVo = dic;
    
 }

- (void)dealloc {
    [_userVo release];
    [super dealloc];
}
@end
