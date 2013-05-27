//
//  RecommendInfoResponseVo.m
//  qnssy
//
//  Created by jpm on 13-4-24.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "AddAttentionResponseVo.h"

@implementation AddAttentionResponseVo
- (void)analysisData:(NSDictionary *)ResData{
    
    NSLog(@"要解析的数据：%@",ResData);
    self.infoDic = ResData;
    
}

- (void)dealloc{
    [_infoDic release];
    [super dealloc];
}

@end
