//
//  ValidatePhoneVo.h
//  qnssy
//
//  Created by juchen on 13-3-28.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValidatePhoneResponseVo : NSObject

@property (retain, nonatomic) NSString *md5code;
@property (retain, nonatomic) NSNumber *isSuccess;
@property (retain, nonatomic) NSString *message;

- (id)initWithDic:(NSDictionary *)result;

@end
