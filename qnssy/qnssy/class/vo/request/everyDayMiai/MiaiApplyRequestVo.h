//
//  MiaiApplyRequestVo.h
//  qnssy
//
//  Created by jpm on 13-4-23.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "SuperRequestVo.h"

@interface MiaiApplyRequestVo : SuperRequestVo
- (id)initWithId:(NSString *)id contact:(NSString *)contact message:(NSString *)message;

@end
