//
//  BSMyMailResponseVo.h
//  qnssy
//
//  Created by jpm on 13-5-28.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "SuperResponseVo.h"

@interface BSMyMailResponseVo : SuperResponseVo
@property (nonatomic, retain) NSMutableArray *myMailList;
@property (nonatomic, retain) NSMutableArray *unReadMailList;
@property (nonatomic, retain) NSMutableArray *readedMailList;

@end
