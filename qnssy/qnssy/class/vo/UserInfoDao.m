//
//  UserInfoDao.m
//  BSMobileSale
//
//  Created by jpm on 12-6-27.
//  Copyright (c) 2012年 Baosight. All rights reserved.
//

#import "UserInfoDao.h"

@implementation UserInfoDao

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
+ (NSString *)loginDataFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                                         NSUserDomainMask,
                                                         YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:USERINFO];
}
+ (void)saveLoginInfoUsername:(NSString *)username 
                     password:(NSString *)passward 
                   isRemember:(BOOL)isRemember
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSString *tempIsRemember = isRemember ? @"true" : @"false";
    NSMutableDictionary *loginInfo = [[NSMutableDictionary alloc] init];
    [loginInfo setValue:username forKey:USERNAME_USERINFO];
    [loginInfo setValue:passward forKey:USERPARD_USERINFO];
    [loginInfo setValue:tempIsRemember forKey:ISREMEMBER_USERINFO];
    [loginInfo writeToFile:self.loginDataFilePath atomically:YES];
    [loginInfo release];
    
    [pool release];
}

+ (NSDictionary *)loginInfoForFile
{
    NSDictionary *loginInfo = nil;
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.loginDataFilePath]) {
        loginInfo = [[[NSDictionary alloc] initWithContentsOfFile:self.loginDataFilePath] autorelease];
    }else{
        loginInfo = nil;
    }
    return loginInfo;
}
@end