//
//  ZSKSearchResponseVo.m
//  BSMobileSale
//
//  Created by jpm on 12-11-2.
//
//

#import "LoginResponseVo.h"

@implementation LoginResponseVo

- (id)initWithDic:(NSDictionary *)result{
    self = [super init];
    if (self) {
        
        int status = [[result objectForKey:@"status"] intValue];
        //网络数据获取成功
        if (status == 0) {
            NSDictionary *data = [result objectForKey:@"data"];
            int resCode = [[data objectForKey:@"resCode"] intValue];
            //服务器返回数据正确
            if (resCode == 0) {
                
                NSDictionary *ResData = [data objectForKey:@"ResData"];
                self.message = [ResData objectForKey:@"Message"];
                self.userId = [ResData objectForKey:@"UserId"];
                self.loginStatus = [[ResData objectForKey:@"loginStatus"] intValue];
            }else{
                NSLog(@"%@",[data objectForKey:@"ResMessage"]);
            }
            
        }
        
        
    }
    return self;
}

- (void)dealloc{
    [_message release];
    [_userId release];
    [super dealloc];
}
@end
