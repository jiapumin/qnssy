//
//  SDWebImageRootViewController.m
//  Sample
//
//  Created by Kirby Turner on 3/18/10.
//  Copyright 2010 White Peak Software Inc. All rights reserved.
//

#import "SDWebImageRootViewController.h"
#import "SDWebImageDataSource.h"


#import "MyPhotoRequestVo.h"
#import "MyPhotoResponseVo.h"

@interface SDWebImageRootViewController (){
    MBProgressHUD *progressHUD;
}
- (void)showActivityIndicator;
- (void)hideActivityIndicator;
@end

@implementation SDWebImageRootViewController

- (void)dealloc 
{
   [activityIndicatorView_ release], activityIndicatorView_ = nil;
   [images_ release], images_ = nil;
   [super dealloc];
}

- (void)viewDidLoad 
{
   [super viewDidLoad];
  
   self.title = @"我的照片";
   
   images_ = [[SDWebImageDataSource alloc] init];
   [self setDataSource:images_];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(edit)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(edit)];
    
    
    //返回按钮
    UIButton *topLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //按钮大小
    CGRect btnFrame = CGRectMake(0.0, 4.0, 29.0, 25.0);
    topLeftButton.frame =btnFrame;
    //设置返回按钮图片和方法
    [topLeftButton setImage:[UIImage imageNamed:@"2向左返回箭头"]
                   forState:UIControlStateNormal];
    [topLeftButton addTarget:self
                      action:@selector(popViewContoller)
            forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * topLeftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:topLeftButton];
    [self.navigationItem setLeftBarButtonItem:topLeftBarButtonItem];
    [topLeftBarButtonItem release];
    
    //设置背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"2顶部条状背景"] forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor = publicColor;
    
    
    //初始化加载框
    [self initHUDView];
    [self loadServiceData];
    
}

- (void)initHUDView{
    //-------加载框
    progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:progressHUD];
    
    progressHUD.labelText = @"数据加载中...";
    
}
- (void)loadServiceData{
    [progressHUD show:YES];
    MyPhotoRequestVo *vo = [[MyPhotoRequestVo alloc] initWithPageNum:@"0" pageCount:@"10"];
    [[BSContainer instance].serviceAgent callServletWithObject:self
                                                   requestDict:vo.mReqDic
                                                        target:self
                                               successCallBack:@selector(requestSucceess:data:)
                                                  failCallBack:@selector(requestFailed:data:)];
    
    [vo release];
}
- (void)edit{
    
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning 
{
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload 
{
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)willLoadThumbs 
{
   [self showActivityIndicator];
}

- (void)didLoadThumbs 
{
   [self hideActivityIndicator];
}


#pragma mark -
#pragma mark Activity Indicator

- (UIActivityIndicatorView *)activityIndicator 
{
   if (activityIndicatorView_) {
      return activityIndicatorView_;
   }

   activityIndicatorView_ = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
   CGPoint center = [[self view] center];
   [activityIndicatorView_ setCenter:center];
   [activityIndicatorView_ setHidesWhenStopped:YES];
   [activityIndicatorView_ startAnimating];
   [[self view] addSubview:activityIndicatorView_];
   
   return activityIndicatorView_;
}

- (void)showActivityIndicator 
{
   [[self activityIndicator] startAnimating];
}

- (void)hideActivityIndicator 
{
   [[self activityIndicator] stopAnimating];
}
#pragma mark - 回调方法

- (void)requestSucceess:(id)sender data:(NSDictionary *)dic {
    
    MyPhotoResponseVo *vo = [[MyPhotoResponseVo alloc] initWithDic:dic];
    
    images_.images_ = vo.imageList;
    
    [self setDataSource:images_];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:vo.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    [progressHUD hide:YES];
    
    [vo release];
}


- (void)requestFailed:(id)sender data:(NSDictionary *)dic {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"网络异常，请检查网络连接后重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    [progressHUD hide:YES];
}
#pragma mark - pop
- (void)popViewContoller{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
