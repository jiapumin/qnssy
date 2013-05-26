//
//  BSForgetPasswordViewController_iPhone.m
//  qnssy
//
//  Created by jpm on 13-5-24.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSForgetPasswordViewController_iPhone.h"

@interface BSForgetPasswordViewController_iPhone (){
    MBProgressHUD *progressHUD;
}

@end

@implementation BSForgetPasswordViewController_iPhone

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

    [self initHUDView];
    self.navigationController.navigationBarHidden = NO;
    self.myWebView.scalesPageToFit = YES;
    NSURL *url = [NSURL URLWithString:@"http://www.qnssy.com/m/passport.php?mod=forget"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.myWebView loadRequest:request];
}
- (void)initHUDView{
    //-------加载框
    progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:progressHUD];
    
    progressHUD.labelText = @"数据加载中...";
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_myWebView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMyWebView:nil];
    [super viewDidUnload];
}
#pragma  mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [progressHUD show:YES];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [progressHUD hide:YES];
}
@end
