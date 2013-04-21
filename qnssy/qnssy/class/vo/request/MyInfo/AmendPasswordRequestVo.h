//
//  AmendPasswordRequestVo.h
//  qnssy
//
//  Created by jpm on 13-4-21.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "SuperRequestVo.h"

@interface AmendPasswordRequestVo : SuperRequestVo
- (id)initWithNewPassord:(NSString *)newPassword oldPassword:(NSString *)oldPassword;
@end
