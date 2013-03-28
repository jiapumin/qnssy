//
//  SignInRequestVo.m
//  qnssy
//
//  Created by jpm on 13-3-24.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "SignInRequestVo.h"

@implementation SignInRequestVo
- (id)init{
    self=[super init];
    if(self){
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        //设置请求服务器的方法名
        [data setObject:@"signIn" forKey:@"c"];
        
        //此处设置参数及参数所需要的key-value
        
        [data setObject:[BSContainer instance].userInfo.userId forKey:@"userid"];
        
        [self.mReqDic setObject:data forKey:@"data"];
        
        [data release];
        
    }
    return self;
}
@end
