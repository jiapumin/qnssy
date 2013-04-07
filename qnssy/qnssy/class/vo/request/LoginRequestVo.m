//
//  ZSKMainMenuRequestVo.m
//  BSMobileSale
//
//  Created by 巨臣 on 12-10-25.
//
//

#import "LoginRequestVo.h"

@implementation LoginRequestVo
- (id)initWithUsername:(NSString *)username password:(NSString *)password
{
    self=[super init];
    if(self){
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        //此处设置参数及参数所需要的key-value
        [data setObject:username forKey:@"username"];
        [data setObject:password forKey:@"password"];
        [self.mReqDic setObject:data forKey:@"data"];
        
        
        NSMutableDictionary *method = [[NSMutableDictionary alloc] init];
        //设置请求服务器的方法名
        [method setObject:@"login" forKey:@"c"];
        [self.mReqDic setObject:method forKey:@"method"];
        [data release];
        [method release];

    }
    return self;
}
@end
