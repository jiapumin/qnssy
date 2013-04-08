//
//  ZSKSearchResponseVo.h
//  BSMobileSale
//
//  Created by jpm on 12-11-2.
//
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

@interface LoginResponseVo : NSObject
@property (nonatomic, retain) NSString *message;
@property (nonatomic) int loginStatus;

@property (retain, nonatomic)  UserInfo *userInfo;


- (id)initWithDic:(NSDictionary *)result;

@end
