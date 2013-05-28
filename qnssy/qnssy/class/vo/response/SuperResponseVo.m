//
//  SuperResponseVo.m
//  qnssy
//
//  Created by jpm on 13-4-14.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "SuperResponseVo.h"

@implementation SuperResponseVo

- (id)initWithDic:(NSDictionary *)result{
    self = [super init];
    if (self) {
        
        int status = [[result objectForKey:@"status"] intValue];
        //网络数据获取成功
        if (status == 0) {
            NSDictionary *data = [result objectForKey:@"data"];
            int resCode = [[data objectForKey:@"ResCode"] intValue];
            //服务器返回数据成功
            if (resCode == 0) {
                NSDictionary *ResData = [data objectForKey:@"ResData"];
                int resCode2 = [[ResData objectForKey:@"ResCode"] intValue];
                if (resCode2 == 0) {
                    //用户操作成功（服务器执行命令成功）
                    NSDictionary *ResData2 = [ResData objectForKey:@"ResData"];
                    if (ResData2 != nil && ![ResData2 isEqual:@""]) {
                        [self analysisData:ResData2];
                    }
                    
                }
                self.message = [ResData objectForKey:@"Message"];
                self.status = resCode2;
            
            }else{
                self.message = [data objectForKey:@"ResMessage"];
                self.status = resCode;
            }
            
        }
        
        
    }
    return self;
}

- (void)analysisData:(NSDictionary *)ResData{
    [self doesNotRecognizeSelector:_cmd];
}
- (void)dealloc{
    [_message release];
    [super dealloc];
}

@end
