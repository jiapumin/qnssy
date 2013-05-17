//
//  BSBindUserAccountViewController.m
//  qnssy
//
//  Created by juchen on 13-3-27.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSBindUserAccountViewController.h"
#import "BSUserRegisterStepOneViewController.h"

@interface BSBindUserAccountViewController ()

@end

@implementation BSBindUserAccountViewController

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
    [self.myNavigationBar setBackgroundImage:[UIImage imageNamed:@"2顶部条状背景"] forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [UIColor colorWithRed:247.f/255 green:232.f/255 blue:232.f/255 alpha:1.f];
    [self configureElements];
}

// 初始化界面控件
- (void) configureElements {
    CGFloat marginx = 10;
    CGFloat marginy = 54;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(marginx, marginy, self.view.frame.size.width - marginx*2, 24)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"您还未绑定千千缘账号";
    [self.view addSubview:label];
    [label release];
    
    marginy = label.frame.origin.y + label.frame.size.height + 10;
    
    UITextField *accountField = [[UITextField alloc] initWithFrame:CGRectMake(marginx, marginy, self.view.frame.size.width - marginx*2, 44)];
    accountField.borderStyle = UITextBorderStyleRoundedRect;
    accountField.placeholder = @"请输入您的手机号";
    accountField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    accountField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.view addSubview:accountField];
    [accountField release];
    
    marginy = accountField.frame.origin.y + accountField.frame.size.height + 10;
    
    UITextField *passwordField = [[UITextField alloc] initWithFrame:CGRectMake(marginx, marginy, self.view.frame.size.width - marginx*2, 44)];
    passwordField.borderStyle = UITextBorderStyleRoundedRect;
    passwordField.placeholder = @"密码（6-20位）";
    passwordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    passwordField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.view addSubview:passwordField];
    [passwordField release];
    
    marginy = passwordField.frame.origin.y + passwordField.frame.size.height + 10;
    
    UIButton *bindButton = [[UIButton alloc] initWithFrame:CGRectMake(marginx, marginy, self.view.frame.size.width-marginx*2, 44)];
    [bindButton setBackgroundImage:[UIImage imageNamed:@"2下一步背景@2x.png"] forState:UIControlStateNormal];
    [bindButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bindButton setTitle:@"绑定" forState:UIControlStateNormal];
    [bindButton addTarget:self action:@selector(bindAccount:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bindButton];
    [bindButton release];
    
    marginy = bindButton.frame.origin.y + bindButton.frame.size.height + 10;
    
    UIButton *registerButton = [[UIButton alloc] initWithFrame:CGRectMake(marginx, marginy, self.view.frame.size.width-marginx*2, 44)];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"4倒计时按钮@2x.png"] forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [registerButton setTitle:@"没有千千缘账号？" forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerAccount:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    [registerButton release];
}

// 绑定账号
- (void) bindAccount:(id) sender {
    
}

//注册账号
- (void) registerAccount:(id) sender {
    BSUserRegisterStepOneViewController *registerViewController = [[BSUserRegisterStepOneViewController alloc] initWithNibName:@"BSUserRegisterStepOneViewController" bundle:nil];
    [self.navigationController pushViewController:registerViewController animated:YES];
    [registerViewController release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_myNavigationBar release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setMyNavigationBar:nil];
    [super viewDidUnload];
}

- (IBAction)clickBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
