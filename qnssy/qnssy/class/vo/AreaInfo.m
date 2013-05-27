//
//  AreaInfo.m
//  qnssy
//
//  Created by juchen on 13-4-29.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "AreaInfo.h"

@implementation AreaInfo

@synthesize areaId = _areaId;
@synthesize areaName = _areaName;

-(id) initWithAreaId:(int) areaId areaName:(NSString *) areaName {
    if ((self = [super init])) {
        self.areaId = areaId;
        self.areaName = areaName;
    }
    return self;
}

-(void) dealloc {
    self.areaName = nil;
    [super dealloc];
}

@end
