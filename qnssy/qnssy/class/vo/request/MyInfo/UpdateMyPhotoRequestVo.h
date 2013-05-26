//
//  UpdateMyPhotoRequestVo.h
//  qnssy
//
//  Created by jpm on 13-4-18.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "SuperRequestVo.h"

@interface UpdateMyPhotoRequestVo : SuperRequestVo
- (id)initWithPhotoFilePath:(NSString *)filePath delegate:(UIViewController *)vc;

@end
