//
//  ValidatePhoneRequestVo.m
//  qnssy
//
//  Created by juchen on 13-3-28.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "ValidatePhoneRequestVo.h"

@implementation ValidatePhoneRequestVo

- (id) initWithPhoneNumAndPassword:(NSString *) phoneNum password:(NSString *) password {
    self = [super init];
    if (self) {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        //设置请求服务器的方法名
        [data setObject:@"userRegister" forKey:@"c"];
        
        //此处设置参数及参数所需要的key-value
        
        [data setObject:phoneNum forKey:@"phoneNum"];
        [data setObject:password forKey:@"password"];
        
        [self.mReqDic setObject:data forKey:@"data"];
        
        [data release];

    }
    return self;
}

@end
