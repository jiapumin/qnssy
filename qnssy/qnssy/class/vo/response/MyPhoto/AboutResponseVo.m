//
//  AboutResponseVo.m
//  qnssy
//
//  Created by jpm on 13-4-21.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "AboutResponseVo.h"

@implementation AboutResponseVo


//子类必须实现的方法
- (void)analysisData:(NSDictionary *)ResData{
    
    NSLog(@"要解析的数据：%@",ResData);
    
    self.aboutStr = (NSString *)ResData;
}

- (void)dealloc{
    [_aboutStr release];
    [super dealloc];
}

@end
