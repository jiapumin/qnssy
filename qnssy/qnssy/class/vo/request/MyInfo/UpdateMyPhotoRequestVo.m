//
//  UpdateMyPhotoRequestVo.m
//  qnssy
//
//  Created by jpm on 13-4-18.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "UpdateMyPhotoRequestVo.h"

@implementation UpdateMyPhotoRequestVo

- (id)initWithPhotoImage:(UIImage *)image delegate:(UIViewController *)vc{
    
    self=[super init];
    if(self){

        NSString *url = @"http://demo2.qnssy.com/app/app.php?c=user&a=addphoto";
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL: [NSURL URLWithString:url]];
        [request setPostValue: @"true" forKey: @"is_phone"];
        [request setPostValue:@"true" forKey:@"do_upload_file"];
        //    [request setFile:filePath forKey: @"uploadedfile"];
        NSData *imageData = UIImagePNGRepresentation(image);
        [request setData:imageData forKey:@"uploadedfile"];
        [request buildRequestHeaders];
        [request setPostValue:[BSContainer instance].userInfo.userId forKey:@"userid"];
        [request setDefaultResponseEncoding:NSUTF8StringEncoding];
        [request setTimeOutSeconds:60];
        [request setDidFinishSelector:@selector(asySuccess:)];
        [request setDidFailSelector:@selector(asyFail:)];
        request.delegate = vc;
        [request startAsynchronous];
    
    }
    return self;
//    NSString *filePath = [[[KBBreakpointTransmission instance] getTargetFloderPath:@"image"] stringByAppendingPathComponent:@"index2.jpg"];
//    
//    NSString *url = @"http://demo2.qnssy.com/app/app.php?c=user&a=addphoto";
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL: [NSURL URLWithString: url]];
//    [request setPostValue: @"true" forKey: @"is_phone"];
//    [request setPostValue:@"true" forKey:@"do_upload_file"];
//    [request setFile: filePath forKey: @"uploadedfile"];
//    [request buildRequestHeaders];
//    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
//    NSLog(@"header: %@", request.requestHeaders);
//    [request startSynchronous];
//    NSLog(@"responseString = %@", request.responseString);
//    

}


@end
