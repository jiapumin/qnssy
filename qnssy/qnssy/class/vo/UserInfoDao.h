//
//  UserInfoDao.h
//  BSMobileSale
//
//  Created by jpm on 12-6-27.
//  Copyright (c) 2012年 Baosight. All rights reserved.
//
#define USERINFO            @"userinfo"     //保存的文件名
#define USERNAME_USERINFO   @"username"       //用户名
#define USERPARD_USERINFO   @"passward"       //密码
#define ISREMEMBER_USERINFO @"isRemember"   //是否记住密码

#import <Foundation/Foundation.h>

@interface UserInfoDao : NSObject

/**
 *  获得登录文档数据的路径
 */
+ (NSString *)loginDataFilePath;
/**
 *  保存登录信息
 * username     用户名
 * passward     密码
 * isRemember   是否记住密码
 */
+ (void)saveLoginInfoUsername:(NSString *)username 
                     password:(NSString *)passward 
                   isRemember:(BOOL)isRemember;
/**
 *  获得登录信息字典
 */
+ (NSDictionary *)loginInfoForFile;
@end