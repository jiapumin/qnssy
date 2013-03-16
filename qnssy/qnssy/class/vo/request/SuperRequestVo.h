//
//  SuperRequestVo.h
//  BSNews
//
//  Created by Sophie Sun on 12-5-10.
//  Copyright (c) 2012年 Baosight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SuperRequestVo : NSObject

@property (retain,nonatomic) NSMutableDictionary *mReqDic;
- (NSMutableDictionary *)getReqDic;
@end
