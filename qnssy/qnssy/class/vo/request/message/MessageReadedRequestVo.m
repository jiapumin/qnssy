//
//  MessageReadedRequestVo.m
//  qnssy
//
//  Created by juchen on 13-5-8.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "MessageReadedRequestVo.h"

@implementation MessageReadedRequestVo

-(id) initWithMessageId:(NSString *) messageId {
    self = [super init];
    if (self) {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        [data setObject:[NSNumber numberWithInt:messageId] forKey:@"msgid"];
        [self.mReqDic setObject:data forKey:@"data"];
        
        
        NSMutableDictionary *method = [[NSMutableDictionary alloc] init];
        //设置请求服务器的方法名
        [method setObject:@"myemaillist" forKey:@"c"];
        [method setObject:@"settoread" forKey:@"a"];
        [self.mReqDic setObject:method forKey:@"method"];
        [data release];
        [method release];
    }
    return self;
}

@end
