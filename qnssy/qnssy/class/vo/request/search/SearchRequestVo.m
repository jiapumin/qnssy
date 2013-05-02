//
//  SearchRequestVo.m
//  qnssy
//
//  Created by juchen on 13-5-1.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "SearchRequestVo.h"

@implementation SearchRequestVo

-(id) initWithParams:(NSDictionary *) params {
    self = [super init];
    if (self) {
        NSMutableDictionary *method = [[NSMutableDictionary alloc] init];
        //设置请求服务器的方法名
        [method setObject:@"search" forKey:@"c"];
        [method setObject:@"search" forKey:@"a"];
        [self.mReqDic setObject:method forKey:@"method"];
        
        //设置参数及参数所需要的key-value
        
        [self.mReqDic setObject:params forKey:@"data"];
        
        [method release];
        
    }
    return self;
}

@end
