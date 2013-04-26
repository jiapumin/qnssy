//
//  MessageUnreadResponseVo.h
//  qnssy
//
//  Created by jpm on 13-4-26.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "SuperResponseVo.h"

@interface MessageUnreadResponseVo : SuperResponseVo
@property (retain, nonatomic) NSMutableArray *mailList;
@end
