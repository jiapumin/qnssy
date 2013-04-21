//
//  AboutRequestVo.m
//  qnssy
//
//  Created by jpm on 13-4-21.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "AboutRequestVo.h"

@implementation AboutRequestVo
- (id)init
{
    self=[super init];
    if(self){
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        //此处设置参数及参数所需要的key-value
        [data setObject:[BSContainer instance].userInfo.userId forKey:@"userid"];
//        [data setObject:id forKey:@"imageid"];
        [self.mReqDic setObject:data forKey:@"data"];
        
        
        NSMutableDictionary *method = [[NSMutableDictionary alloc] init];
        //设置请求服务器的方法名
        [method setObject:@"about" forKey:@"c"];
        [method setObject:@"about" forKey:@"a"];
        [self.mReqDic setObject:method forKey:@"method"];
        [data release];
        [method release];
        
    }
    return self;
}
@end
