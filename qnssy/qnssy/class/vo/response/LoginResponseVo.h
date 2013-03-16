//
//  ZSKSearchResponseVo.h
//  BSMobileSale
//
//  Created by jpm on 12-11-2.
//
//

#import <Foundation/Foundation.h>

@interface LoginResponseVo : NSObject

@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *message;
@property (nonatomic) int loginStatus;


- (id)initWithDic:(NSDictionary *)result;

@end
