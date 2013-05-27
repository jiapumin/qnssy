//
//  RecommendInfoResponseVo.m
//  qnssy
//
//  Created by jpm on 13-4-24.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "SendMailResponseVo.h"

@implementation SendMailResponseVo
- (void)analysisData:(NSDictionary *)ResData{
    
    NSLog(@"要解析的数据：%@",ResData);
    self.infoDic = ResData;
    
}

- (void)dealloc{
    [_infoDic release];
    [super dealloc];
}

@end
