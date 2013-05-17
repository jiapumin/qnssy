//
//  AreaInfo.h
//  qnssy
//
//  Created by juchen on 13-4-29.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaInfo : NSObject {
    int _areaId;
    NSString *_areaName;
}

@property (nonatomic, assign) int areaId;
@property (nonatomic, copy) NSString *areaName;

-(id) initWithAreaId:(int) areaId areaName:(NSString *) areaName;

@end
