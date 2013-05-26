//
//  BaseInfoRequestVo.h
//  qnssy
//
//  Created by jpm on 13-4-14.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "SuperRequestVo.h"

@interface SendMailRequestVo : SuperRequestVo
- (id)initWithUserId:(NSString *)userid content:(NSString *)content;

@end
