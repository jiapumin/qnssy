//
//  ChangeBaseInfoRequestVo.m
//  qnssy
//
//  Created by jpm on 13-6-3.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "ChangeBaseInfoRequestVo.h"

@implementation ChangeBaseInfoRequestVo
- (id)initWithData:(NSMutableDictionary *)dataDic
{
    self=[super init];
    if(self){
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        //此处设置参数及参数所需要的key-value

        for (NSString *key in [[dataDic allKeys] objectEnumerator]) {
            [data setObject:[dataDic objectForKey:key] forKey:key];
        }
        [data setObject:[BSContainer instance].userInfo.userId forKey:@"userid"];
        [self.mReqDic setObject:data forKey:@"data"];
        
        
        NSMutableDictionary *method = [[NSMutableDictionary alloc] init];
        //设置请求服务器的方法名
        [method setObject:@"user" forKey:@"c"];
        [method setObject:@"changebaseinfo" forKey:@"a"];
        [self.mReqDic setObject:method forKey:@"method"];
        [data release];
        [method release];
        
    }
    return self;
}
@end
