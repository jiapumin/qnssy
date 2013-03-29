//
//  ValidatePhoneVo.h
//  qnssy
//
//  Created by juchen on 13-3-28.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValidatePhoneResponseVo : NSObject

@property (retain, nonatomic) NSString *phoneNum;
@property (retain, nonatomic) NSString *password;

- (id)initWithDic:(NSDictionary *)result;

@end
