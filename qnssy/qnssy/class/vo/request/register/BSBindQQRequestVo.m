//
//  BSBindQQRequestVo.m
//  qnssy
//
//  Created by jpm on 13-5-30.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSBindQQRequestVo.h"

@implementation BSBindQQRequestVo
- (id)initWithId:(NSString *)id username:(NSString *)username password:(NSString *)password
{
    self=[super init];
    if(self){
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        //此处设置参数及参数所需要的key-value
        [data setObject:id forKey:@"openid"];
        [data setObject:username forKey:@"username"];
        [data setObject:password forKey:@"password"];
        [self.mReqDic setObject:data forKey:@"data"];
        
        
        NSMutableDictionary *method = [[NSMutableDictionary alloc] init];
        //设置请求服务器的方法名
        [method setObject:@"login" forKey:@"c"];
        [method setObject:@"binding" forKey:@"a"];
        [self.mReqDic setObject:method forKey:@"method"];
        [data release];
        [method release];
        
    }
    return self;
}

@end
