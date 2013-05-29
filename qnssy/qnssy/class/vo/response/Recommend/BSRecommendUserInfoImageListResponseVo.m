//
//  BSRecommendUserInfoImageListResponseVo.m
//  qnssy
//
//  Created by jpm on 13-5-29.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSRecommendUserInfoImageListResponseVo.h"

@implementation BSRecommendUserInfoImageListResponseVo

- (void)analysisData:(NSDictionary *)ResData{
    
    NSLog(@"要解析的数据：%@",ResData);
    self.imageList = [ResData objectForKey:@"imageUrlList"];
    
}
- (void)dealloc{
    [_imageList release];
    [super dealloc];
}
@end
