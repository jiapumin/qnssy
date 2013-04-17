//
//  ZSKSearchResponseVo.h
//  BSMobileSale
//
//  Created by jpm on 12-11-2.
//
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
#import "SuperResponseVo.h"

@interface LoginResponseVo : SuperResponseVo
//@property (nonatomic, retain) NSString *message;
//@property (nonatomic) int loginStatus;

@property (retain, nonatomic)  UserInfo *userInfo;



@end
