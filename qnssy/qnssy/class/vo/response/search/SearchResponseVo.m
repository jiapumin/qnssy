//
//  MessageUnreadResponseVo.m
//  qnssy
//
//  Created by jpm on 13-4-26.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "SearchResponseVo.h"

@implementation SearchResponseVo
//子类必须实现的方法
- (void)analysisData:(NSDictionary *)ResData{
    
    NSLog(@"要解析的数据：%@",ResData);
    
    self.searchList = [ResData objectForKey:@"userinfo"];
    
}

- (void)dealloc{
    [_searchList release];
    [super dealloc];
}
@end
