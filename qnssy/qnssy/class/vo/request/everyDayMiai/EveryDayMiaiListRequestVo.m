//
//  EveryDayMiaiListRequestVo.m
//  qnssy
//
//  Created by jpm on 13-4-22.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "EveryDayMiaiListRequestVo.h"

@implementation EveryDayMiaiListRequestVo
- (id)init
{
    self=[super init];
    if(self){
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        //此处设置参数及参数所需要的key-value
        [data setObject:[BSContainer instance].userInfo.userId forKey:@"userid"];
        [self.mReqDic setObject:data forKey:@"data"];
        
        
        NSMutableDictionary *method = [[NSMutableDictionary alloc] init];
        //设置请求服务器的方法名
        [method setObject:@"everydaymiai" forKey:@"c"];
        [method setObject:@"everydaymiai" forKey:@"a"];
        [self.mReqDic setObject:method forKey:@"method"];
        [data release];
        [method release];
        
    }
    return self;
}
@end
