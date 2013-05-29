//
//  BSRecommendImageListRequestVo.m
//  qnssy
//
//  Created by jpm on 13-5-29.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSRecommendUserInfoImageListRequestVo.h"

@implementation BSRecommendUserInfoImageListRequestVo
- (id)initWithUserId:(NSString *)userid
             pagenum:(NSString *)pagenum
           pagecount:(NSString *)pagecount
{
    self=[super init];
    if(self){
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        //此处设置参数及参数所需要的key-value
        [data setObject:[BSContainer instance].userInfo.userId forKey:@"userid"];
        [data setObject:pagenum forKey:@"pagenum"];
        [data setObject:pagecount forKey:@"pagecount"];
        [data setObject:userid forKey:@"commenduserid"];
        
        [self.mReqDic setObject:data forKey:@"data"];
        
        NSMutableDictionary *method = [[NSMutableDictionary alloc] init];
        //设置请求服务器的方法名
        [method setObject:@"commend" forKey:@"c"];
        [method setObject:@"commenduserimagelist" forKey:@"a"];
        [self.mReqDic setObject:method forKey:@"method"];
        [data release];
        [method release];
        
    }
    return self;
}

@end
