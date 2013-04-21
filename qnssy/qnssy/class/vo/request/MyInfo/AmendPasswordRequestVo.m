//
//  AmendPasswordRequestVo.m
//  qnssy
//
//  Created by jpm on 13-4-21.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "AmendPasswordRequestVo.h"

@implementation AmendPasswordRequestVo

- (id)initWithNewPassord:(NSString *)newPassword oldPassword:(NSString *)oldPassword
{
    self=[super init];
    if(self){
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        //此处设置参数及参数所需要的key-value
        [data setObject:[BSContainer instance].userInfo.userId forKey:@"userid"];
        [data setObject:oldPassword forKey:@"oldpassword"];
        [data setObject:newPassword forKey:@"newpassword"];
        [self.mReqDic setObject:data forKey:@"data"];
        
        
        NSMutableDictionary *method = [[NSMutableDictionary alloc] init];
        //设置请求服务器的方法名
        [method setObject:@"user" forKey:@"c"];
        [method setObject:@"changepassword" forKey:@"a"];
        [self.mReqDic setObject:method forKey:@"method"];
        [data release];
        [method release];
        
    }
    return self;
}
@end
