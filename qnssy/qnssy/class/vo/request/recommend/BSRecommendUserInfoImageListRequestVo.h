//
//  BSRecommendImageListRequestVo.h
//  qnssy
//
//  Created by jpm on 13-5-29.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "SuperRequestVo.h"

@interface BSRecommendUserInfoImageListRequestVo : SuperRequestVo
- (id)initWithUserId:(NSString *)userid
             pagenum:(NSString *)pagenum
           pagecount:(NSString *)pagecount;
@end
