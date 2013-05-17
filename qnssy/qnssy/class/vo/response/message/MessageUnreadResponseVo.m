//
//  MessageUnreadResponseVo.m
//  qnssy
//
//  Created by jpm on 13-4-26.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "MessageUnreadResponseVo.h"

@implementation MessageUnreadResponseVo
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
