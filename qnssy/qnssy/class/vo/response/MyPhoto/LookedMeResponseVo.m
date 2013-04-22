//
//  LookedMeResponseVo.m
//  qnssy
//
//  Created by jpm on 13-4-14.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "LookedMeResponseVo.h"

@implementation LookedMeResponseVo


//子类必须实现的方法
- (void)analysisData:(NSDictionary *)ResData{
    
    NSLog(@"要解析的数据：%@",ResData);
    
    self.userList = [ResData objectForKey:@"userList"];
    
}

- (void)dealloc{
    [_userList release];
    [super dealloc];
}
@end
