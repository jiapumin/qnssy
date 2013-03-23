//
//  Container.h
//  BSNetWork
//
//  Created by  on 11-11-28.
//  Copyright (c) 2011年 BaoSight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"

@class BSServiceAgent;
@interface BSContainer : NSObject <UIAlertViewDelegate>
{
//    BSServiceAgent * serviceAgent;
//    NSString *serviceHttpURLString;
//    UserInfo *userInfo;
}

@property (nonatomic,retain) BSServiceAgent * serviceAgent;
@property (nonatomic,retain) NSString *serviceHttpURLString;
@property (nonatomic,retain) UserInfo *userInfo;
//@property (nonatomic, retain) NSString *noticeNum;

+(BSContainer * ) instance;

@end
