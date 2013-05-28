//
//  BSSysMailRequestVo.m
//  qnssy
//
//  Created by jpm on 13-5-28.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSSysMailRequestVo.h"

@implementation BSSysMailRequestVo
- (id)init{
    
    self=[super init];
    
    if(self){
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        //此处设置参数及参数所需要的key-value
        [data setObject:[BSContainer instance].userInfo.userId forKey:@"userid"];
        [data setObject:@"2" forKey:@"mailType"];
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
