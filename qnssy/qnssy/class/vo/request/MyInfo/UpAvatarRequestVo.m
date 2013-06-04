//
//  UpAvatarRequestVo.m
//  qnssy
//
//  Created by Hanrea on 13-6-3.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "UpAvatarRequestVo.h"

@implementation UpAvatarRequestVo

- (id)initWithAvatarFilePath:(NSString *)filePath delegate:(UIViewController *)vc
{
    
    self=[super init];
    if(self){
        
        NSString *url = @"http://demo2.qnssy.com/app/app.php?c=user&a=setavatar";
//        NSString *url = @"http://hanrea.sinaapp.com/push.php?c=user&a=setavatar";
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL: [NSURL URLWithString:url]];
        NSLog(@"%@",filePath);
//        NSString *str =  [[NSBundle mainBundle] pathForResource:@"图片加载中" ofType:@"png"];
//        NSLog(@"%@",str);
//        [request setPostValue: @"true" forKey: @"is_phone"];
//        [request setPostValue:@"true" forKey:@"do_upload_file"];
        [request setFile:filePath forKey: @"avatar"];
        [request buildRequestHeaders];
        [request setPostValue:[BSContainer instance].userInfo.userId forKey:@"userid"];
        [request setDefaultResponseEncoding:NSUTF8StringEncoding];
        [request setTimeOutSeconds:60];
        [request setDidFinishSelector:@selector(UpAvatarSuccess:)];
        [request setDidFailSelector:@selector(UpAvatarFail:)];
//        NSLog(@"%@",request.postBodyFilePath);
        request.delegate = vc;
        [request startAsynchronous];
    }
    return self;
}

@end
