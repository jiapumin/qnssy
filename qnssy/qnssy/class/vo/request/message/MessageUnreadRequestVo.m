//
//  MessageUnreadRequestVo.m
//  qnssy
//  我的邮件
//  Created by jpm on 13-4-26.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "MessageUnreadRequestVo.h"

@implementation MessageUnreadRequestVo
- (id)init
{
    self=[super init];
    if(self){
//        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
//        //此处设置参数及参数所需要的key-value
//        [data setObject:[BSContainer instance].userInfo.userId forKey:@"userid"];
//        [data setObject:[NSNumber numberWithInt:0] forKey:@"mailType"];
//        [data setObject:[NSNumber numberWithInt:DEFAULT_PAGE_NUMBER] forKey:@"pageNum"];
//        [data setObject:[NSNumber numberWithInt:PAGE_COUNT] forKey:@"pageCount"];
//        [self.mReqDic setObject:data forKey:@"data"];
//        
//        
//        NSMutableDictionary *method = [[NSMutableDictionary alloc] init];
//        //设置请求服务器的方法名
//        [method setObject:@"myemaillist" forKey:@"c"];
//        [method setObject:@"email" forKey:@"a"];
//        [self.mReqDic setObject:method forKey:@"method"];
//        [data release];
//        [method release];
        
    }
    return self;
}

-(id) initWithMailType:(NSString *) mailType {
    self=[super init];
    if(self){
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        //此处设置参数及参数所需要的key-value
        [data setObject:[BSContainer instance].userInfo.userId forKey:@"userid"];
        [data setObject:[NSNumber numberWithInt:mailType] forKey:@"mailType"];
        [data setObject:[NSNumber numberWithInt:DEFAULT_PAGE_NUMBER] forKey:@"pageNum"];
        [data setObject:[NSNumber numberWithInt:PAGE_COUNT] forKey:@"pageCount"];
        [self.mReqDic setObject:data forKey:@"data"];
        
        
        NSMutableDictionary *method = [[NSMutableDictionary alloc] init];
        //设置请求服务器的方法名
        [method setObject:@"myemaillist" forKey:@"c"];
        [method setObject:@"email" forKey:@"a"];
        [self.mReqDic setObject:method forKey:@"method"];
        [data release];
        [method release];
        
    }
    return self;
}

@end
