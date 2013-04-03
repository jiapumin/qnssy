//
//  ValidatePhoneRequestVo.h
//  qnssy
//
//  Created by juchen on 13-3-28.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SuperRequestVo.h"

@interface ValidatePhoneRequestVo : SuperRequestVo

- (id) initWithPhoneNumAndPassword:(NSString *) phoneNum password:(NSString *) password;

@end
