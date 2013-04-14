//
//  BaseInfoResponseVo.m
//  qnssy
//
//  Created by jpm on 13-4-14.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "RecommendImageListResponseVo.h"

@implementation RecommendImageListResponseVo

- (void)analysisData:(NSDictionary *)ResData{
    
    NSLog(@"要解析的数据：%@",ResData);
    self.imageUrlList = [ResData objectForKey:@"imageUrlList"];
}

- (void)dealloc{
    [_imageUrlList release];
    [super dealloc];
}
@end
