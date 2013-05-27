//
//  BSRecommendUserRequestVo.m
//  qnssy
//
//  Created by jpm on 13-5-27.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSRecommendUserRequestVo.h"

@implementation BSRecommendUserRequestVo
- (id)initWithUserId:(NSString *)userid
{
    self=[super init];
    if(self){
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        //此处设置参数及参数所需要的key-value
        [data setObject:[BSContainer instance].userInfo.userId forKey:@"userid"];
        [data setObject:userid forKey:@"commenduserid"];
        
        [self.mReqDic setObject:data forKey:@"data"];
        
        
        NSMutableDictionary *method = [[NSMutableDictionary alloc] init];
        //设置请求服务器的方法名
        [method setObject:@"commend" forKey:@"c"];
        [method setObject:@"commenduserid" forKey:@"a"];
        [self.mReqDic setObject:method forKey:@"method"];
        [data release];
        [method release];
        
    }
    return self;
}
@end
