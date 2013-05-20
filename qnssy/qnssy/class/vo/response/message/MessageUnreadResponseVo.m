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
    self.readedMailList = [NSMutableArray array];
    self.unReadMailList = [NSMutableArray array];
    
    self.mailList = [ResData objectForKey:@"maillist"];
    
    for (NSDictionary *dict in self.mailList) {
        if ([[dict objectForKey:@"readstatus"] isEqualToString:@"1"]) {
            [self.readedMailList addObject:dict];
        } else {
            [self.unReadMailList addObject:dict];
        }
    }
    
}

- (void)dealloc{
    [_mailList release];
    [_readedMailList release];
    [_unReadMailList release];
    [super dealloc];
}
@end
