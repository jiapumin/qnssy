//
//  ValidatePhoneVo.m
//  qnssy
//
//  Created by juchen on 13-3-28.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "ValidatePhoneResponseVo.h"

@implementation ValidatePhoneResponseVo

- (id)initWithDic:(NSDictionary *)result {
    self = [super init];
    if (self) {
        int recCode = [result objectForKey:@"ResCode"];
        if (recCode == 0) {
            
        }
        
    }
    return self;
}

@end
