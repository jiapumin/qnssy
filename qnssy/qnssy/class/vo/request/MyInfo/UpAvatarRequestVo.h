//
//  UpAvatarRequestVo.h
//  qnssy
//
//  Created by Hanrea on 13-6-3.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "SuperRequestVo.h"

@interface UpAvatarRequestVo : SuperRequestVo
- (id)initWithAvatarFilePath:(NSString *)filePath delegate:(UIViewController *)vc;
@end
