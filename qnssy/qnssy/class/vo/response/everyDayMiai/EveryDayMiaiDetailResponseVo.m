//
//  EveryDayMiaiDetailResponseVo.m
//  qnssy
//
//  Created by jpm on 13-4-23.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "EveryDayMiaiDetailResponseVo.h"

@implementation EveryDayMiaiDetailResponseVo


//子类必须实现的方法
- (void)analysisData:(NSDictionary *)ResData{
    
    NSLog(@"要解析的数据：%@",ResData);
    
    self.dataDic = ResData;
    
}

- (void)dealloc{
    [_dataDic release];
    [super dealloc];
}

@end
