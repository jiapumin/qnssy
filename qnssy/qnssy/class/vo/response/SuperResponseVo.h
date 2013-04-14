//
//  SuperResponseVo.h
//  qnssy
//
//  Created by jpm on 13-4-14.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SuperResponseVo : NSObject

@property (retain, nonatomic) NSString *message;
@property (nonatomic) int status;

- (id)initWithDic:(NSDictionary *)result;
//子类必须实现此方法
- (void)analysisData:(NSDictionary *)ResData;
@end
