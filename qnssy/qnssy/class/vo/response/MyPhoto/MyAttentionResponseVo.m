//
//  MyAttentionResponseVo.m
//  qnssy
//
//  Created by jpm on 13-4-14.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "MyAttentionResponseVo.h"

@implementation MyAttentionResponseVo

//子类必须实现的方法
- (void)analysisData:(NSDictionary *)ResData{
    
    NSLog(@"要解析的数据：%@",ResData);
    
    self.imageList = [ResData objectForKey:@"imageUrlList"];

}

- (void)dealloc{
    [_imageList release];
    [super dealloc];
}

@end
