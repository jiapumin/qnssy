//
//  ZSKSearchResponseVo.m
//  BSMobileSale
//
//  Created by jpm on 12-11-2.
//
//

#import "LoginResponseVo.h"

@implementation LoginResponseVo



- (void)analysisData:(NSDictionary *)ResData{
    self.userInfo = [[[UserInfo alloc] init] autorelease];
    
    self.userInfo.userId = [ResData objectForKey:@"userid"];
    self.userInfo.vipLevel = [ResData objectForKey:@"viplevel"];
    self.userInfo.nickName = [ResData objectForKey:@"username"];
    self.userInfo.imageUrl = [ResData objectForKey:@"imageurl"];
    self.userInfo.vipLevel = [ResData objectForKey:@"viplevel"];
    self.userInfo.address = [ResData objectForKey:@"city"];
    self.userInfo.age = [ResData objectForKey:@"age"];
}

- (void)dealloc{
    [_userInfo release];
    [super dealloc];
}
@end
