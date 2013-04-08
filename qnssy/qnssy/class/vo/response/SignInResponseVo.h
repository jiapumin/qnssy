//
//  SignInResponseVo.h
//  qnssy
//
//  Created by jpm on 13-4-8.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignInResponseVo : NSObject
@property (nonatomic, retain) NSString *message;
@property (nonatomic) int status;

- (id)initWithDic:(NSDictionary *)result;
@end
