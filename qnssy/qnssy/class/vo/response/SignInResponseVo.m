//
//  SignInResponseVo.m
//  qnssy
//
//  Created by jpm on 13-4-8.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "SignInResponseVo.h"

@implementation SignInResponseVo
- (id)initWithDic:(NSDictionary *)result{
    self = [super init];
    if (self) {
        
        int status = [[result objectForKey:@"status"] intValue];
        //网络数据获取成功
        if (status == 0) {
            NSDictionary *data = [result objectForKey:@"data"];
            int resCode = [[data objectForKey:@"ResCode"] intValue];
            //服务器返回数据正确
            if (resCode == 0) {
                NSDictionary *ResData = [data objectForKey:@"ResData"];
                self.message = [ResData objectForKey:@"ResMessage"];
                self.status = [[ResData objectForKey:@"ResCode"] intValue];
                
            }else{
                NSLog(@"%@",[data objectForKey:@"ResMessage"]);
                self.status = -1;
            }
            
        }
        
        
    }
    return self;
}

- (void)dealloc{
    [_message release];
    [super dealloc];
}
@end
