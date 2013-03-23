//
//  BSSearchViewController_iPhone.m
//  qnssy
//
//  Created by jpm on 13-3-12.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSSearchViewController_iPhone.h"

@interface BSSearchViewController_iPhone ()

@end

@implementation BSSearchViewController_iPhone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self update];
}
- (void)update{
    //测试上传图片
    NSString *filePath = [[[KBBreakpointTransmission instance] getTargetFloderPath:@"image"] stringByAppendingPathComponent:@"index2.jpg"];
    
    NSString *url = @"http://demo2.qnssy.com/demo/upload_demo.php";
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL: [NSURL URLWithString: url]];
    [request setPostValue: @"true" forKey: @"is_phone"];
    [request setPostValue:@"true" forKey:@"do_upload_file"];
    [request setFile: filePath forKey: @"uploadedfile"];
    [request buildRequestHeaders];
    NSLog(@"header: %@", request.requestHeaders);
    [request startSynchronous];
    NSLog(@"responseString = %@", request.responseString);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
