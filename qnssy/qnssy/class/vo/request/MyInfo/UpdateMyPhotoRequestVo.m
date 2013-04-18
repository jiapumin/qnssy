//
//  UpdateMyPhotoRequestVo.m
//  qnssy
//
//  Created by jpm on 13-4-18.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "UpdateMyPhotoRequestVo.h"

@implementation UpdateMyPhotoRequestVo

- (id)initWithPhotoPath:(NSString *)path{
    
    NSString *filePath = [[[KBBreakpointTransmission instance] getTargetFloderPath:@"image"] stringByAppendingPathComponent:@"index2.jpg"];
    
    NSString *url = @"http://demo2.qnssy.com/demo/upload_demo.php";
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL: [NSURL URLWithString: url]];
    [request setPostValue: @"true" forKey: @"is_phone"];
    [request setPostValue:@"true" forKey:@"do_upload_file"];
    [request setFile: filePath forKey: @"uploadedfile"];
    [request buildRequestHeaders];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    NSLog(@"header: %@", request.requestHeaders);
    [request startSynchronous];
    NSLog(@"responseString = %@", request.responseString);
    

}


@end
