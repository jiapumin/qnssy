//
//  MyPhotoRequestVo.h
//  qnssy
//
//  Created by jpm on 13-4-13.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "SuperRequestVo.h"

@interface MyPhotoRequestVo : SuperRequestVo
- (id)initWithPageNum:(NSString *)pageNum pageCount:(NSString *)pageCount;
@end
