//
//  RegisterRequestVo.m
//  qnssy
//
//  Created by juchen on 13-4-25.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "RegisterRequestVo.h"

@implementation RegisterRequestVo

- (id) initWithParams:(NSDictionary *) params {
    
    self = [super init];
    if (self) {
//        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *method = [[NSMutableDictionary alloc] init];
        //设置请求服务器的方法名
        [method setObject:@"register" forKey:@"c"];
        [method setObject:@"index" forKey:@"a"];
        [self.mReqDic setObject:method forKey:@"method"];
        
        //设置参数及参数所需要的key-value
        
        [self.mReqDic setObject:params forKey:@"data"];
        
//        [data release];
        [method release];

    }
    return self;
}

@end
