//
//  BSSysMailResponseVo.m
//  qnssy
//
//  Created by jpm on 13-5-28.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSSysMailResponseVo.h"

@implementation BSSysMailResponseVo
//子类必须实现的方法
- (void)analysisData:(NSDictionary *)ResData{
    
    NSLog(@"要解析的数据：%@",ResData);
    
    self.mailList = [ResData objectForKey:@"maillist"];
}

- (void)dealloc{
    [_mailList release];
    [super dealloc];
}
@end
