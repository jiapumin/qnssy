//
//  RecommendInfoRequestVo.m
//  qnssy
//
//  Created by jpm on 13-4-24.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "RecommendInfoRequestVo.h"

@implementation RecommendInfoRequestVo
- (id)initWithForId:(NSString *)id
{
    self=[super init];
    if(self){
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        //此处设置参数及参数所需要的key-value
        [data setObject:[BSContainer instance].userInfo.userId forKey:@"userid"];
        [data setObject:id forKey:@"commenduserid"];
        [self.mReqDic setObject:data forKey:@"data"];
        
        
        NSMutableDictionary *method = [[NSMutableDictionary alloc] init];
        //设置请求服务器的方法名
        [method setObject:@"commend" forKey:@"c"];
        [method setObject:@"commenduserinfo" forKey:@"a"];
        [self.mReqDic setObject:method forKey:@"method"];
        [data release];
        [method release];
        
    }
    return self;
}

//{
//    age = 24;
//    baseinfo =     {
//        car = 0;
//        education = 4;
//        house = 6;
//        marriageState = 1;
//        userid = 162440;
//        wages = 1;
//    };
//    height = 165;
//    imageurl = "http://demo2.qnssy.com/data/attachment/avatar/201211/01/162440/avatar_big.jpg";
//    infelt = "Someone is nice to you because you treat them well while others are nice to you because they know your kindness and appreciate it.";
//    sex = 2;
//    spouse =     {
//        education = 0;
//        endage = 28;
//        endheight = 180;
//        startage = 22;
//        startheight = 170;
//        tacity = "\U5357\U4eac";
//        taprovice = "\U6c5f\U82cf";
//    };
//    usercity = "\U5357\U4eac";
//    userid = 162440;
//    userprovice = "\U6c5f\U82cf";
//}

@end
