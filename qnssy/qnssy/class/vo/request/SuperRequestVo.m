//
//  SuperRequestVo.m
//  BSNews
//
//  Created by Sophie Sun on 12-5-10.
//  Copyright (c) 2012年 Baosight. All rights reserved.
//

#import "SuperRequestVo.h"

@implementation SuperRequestVo

- (id)init
{
    self=[super init];
    if(self){
        
        self.mReqDic = [[[NSMutableDictionary alloc] init] autorelease];
      
    }
    return self;
}

- (NSMutableDictionary *)getReqDic{
    if (self.mReqDic == nil) {
        NSLog(@"返回数据错误!");
        return nil;
    }
    return self.mReqDic;
}

-(void)dealloc
{
    [_mReqDic release];
    [super dealloc];
}

@end
