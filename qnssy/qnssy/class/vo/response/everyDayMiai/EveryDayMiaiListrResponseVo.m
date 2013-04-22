//
//  EveryDayMiaiListrResponseVo.m
//  qnssy
//
//  Created by jpm on 13-4-22.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "EveryDayMiaiListrResponseVo.h"

@implementation EveryDayMiaiListrResponseVo

//子类必须实现的方法
- (void)analysisData:(NSDictionary *)ResData{
    
    NSLog(@"要解析的数据：%@",ResData);
    
    self.userList = [ResData objectForKey:@"miailist"];
    
}

- (void)dealloc{
    [_userList release];
    [super dealloc];
}

@end
