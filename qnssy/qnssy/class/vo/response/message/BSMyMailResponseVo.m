//
//  BSMyMailResponseVo.m
//  qnssy
//
//  Created by jpm on 13-5-28.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSMyMailResponseVo.h"

@implementation BSMyMailResponseVo

//子类必须实现的方法
- (void)analysisData:(NSDictionary *)ResData{
    
    NSLog(@"要解析的数据：%@",ResData);
    self.readedMailList = [NSMutableArray array];
    self.unReadMailList = [NSMutableArray array];
    self.myMailList = [NSMutableArray array];
    
    NSArray *mailList = [ResData objectForKey:@"maillist"];
    
    for (NSDictionary *dict in [mailList objectEnumerator]) {
        
        if ([[dict objectForKey:@"readstatus"] isEqualToString:@"1"]) {
            [self.readedMailList addObject:dict];
        } else {
            [self.unReadMailList addObject:dict];
        }
        [self.myMailList addObject:dict];
    }
    
}

- (void)dealloc{
    [_myMailList release];
    [_readedMailList release];
    [_unReadMailList release];
    [super dealloc];
}
@end
