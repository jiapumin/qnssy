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
        //设置请求服务器的方法名
        [data setObject:@"login" forKey:@"c"];
        
        //此处设置参数及参数所需要的key-value

        [data setObject:username forKey:@"username"];
        [data setObject:password forKey:@"password"];
        
        [self.mReqDic setObject:data forKey:@"data"];
        
        [data release];
       
    }
    return self;
}
@end
