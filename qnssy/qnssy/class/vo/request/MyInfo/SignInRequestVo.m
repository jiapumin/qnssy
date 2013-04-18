//
//  SignInRequestVo.m
//  qnssy
//
//  Created by jpm on 13-3-24.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "SignInRequestVo.h"

@implementation SignInRequestVo

- (id)init
{
    self=[super init];
    if(self){
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        //此处设置参数及参数所需要的key-value
        //        [data setObject:username forKey:@"username"];
        //        [data setObject:password forKey:@"password"];
        [data setObject:[BSContainer instance].userInfo.userId forKey:@"userid"];
        [self.mReqDic setObject:data forKey:@"data"];
        
        
        NSMutableDictionary *method = [[NSMutableDictionary alloc] init];
        //设置请求服务器的方法名
        [method setObject:@"user" forKey:@"c"];
        [method setObject:@"signin" forKey:@"a"];
        [self.mReqDic setObject:method forKey:@"method"];
        [data release];
        [method release];
        
    }
    return self;
}
@end
