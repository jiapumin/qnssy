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
        NSArray *resultData = [result objectForKey:@"ResData"];
        int status = [resultData valueForKey:@"status"];
        if (status == 0) {
            self.md5code = [resultData valueForKey:@"code"];
            self.isSuccess = [NSNumber numberWithBool:YES];
        } else {
            self.message = [resultData valueForKey:@"Message"];
            self.isSuccess = [NSNumber numberWithBool:NO];
        }
    }
    return self;
}

- (void)dealloc {
    [_md5code release];
    [_isSuccess release];
    [_message release];
    [super dealloc];
}

@end
