//
//  BSBindUserAccountViewController.m
//  qnssy
//
//  Created by juchen on 13-3-27.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSBindUserAccountViewController.h"
#import "BSUserRegisterStepOneViewController.h"
#import "LoginResponseVo.h"
#import "LoginRequestVo.h"

#import "UserInfoDao.h"

#import "BSBindQQRequestVo.h"

@interface BSBindUserAccountViewController (){
    MBProgressHUD *progressHUD;
}

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
    self.navigationController.navigationBarHidden = NO;
    self.title = @"绑定账号";
    [self configureElements];
    [self initHUDView];
}
- (void)initHUDView{
    //-------加载框
    progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:progressHUD];
    
    progressHUD.labelText = @"数据加载中...";
    
}
// 初始化界面控件
- (void) configureElements {
    CGFloat marginx = 10;
    CGFloat marginy = 10;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(marginx, marginy, self.view.frame.size.width - marginx*2, 24)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"您还未绑定千千缘账号";
    [self.view addSubview:label];
    [label release];
    
    marginy = label.frame.origin.y + label.frame.size.height + 10;
    
    self.accountField = [[[UITextField alloc] initWithFrame:CGRectMake(marginx, marginy, self.view.frame.size.width - marginx*2, 44)] autorelease];
    self.accountField.borderStyle = UITextBorderStyleRoundedRect;
    self.accountField.placeholder = @"请输入您的手机号";
    self.accountField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.accountField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.view addSubview:self.accountField];
    
    marginy = self.accountField.frame.origin.y + self.accountField.frame.size.height + 10;
    
    self.passwordField = [[[UITextField alloc] initWithFrame:CGRectMake(marginx, marginy, self.view.frame.size.width - marginx*2, 44)] autorelease];
    self.passwordField.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordField.placeholder = @"密码（6-20位）";
    self.passwordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.passwordField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.view addSubview:self.passwordField];
    
    marginy = self.passwordField.frame.origin.y + self.passwordField.frame.size.height + 10;
    
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
    
    NSString *username = self.accountField.text;
    NSString *password = self.passwordField.text;
    
    if ([username isEqualToString:@""] || username == nil  || [password isEqualToString:@""]||password == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您输入的信息不完整请输入" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    
    [progressHUD show:YES];
    
    //请求服务器
    BSBindQQRequestVo *vo = [[BSBindQQRequestVo alloc] initWithId:self.openid
                                                         username:username
                                                         password:password];
    
    [[BSContainer instance].serviceAgent callServletWithObject:self
                                                   requestDict:vo.mReqDic
                                                        target:self
                                               successCallBack:@selector(BindQQSucceess:data:)
                                                  failCallBack:@selector(BindQQFailed:data:)];
    
    [vo release];
}

//注册账号
- (void) registerAccount:(id) sender {
    BSUserRegisterStepOneViewController *rvc = [[BSUserRegisterStepOneViewController alloc] initWithNibName:@"BSUserRegisterStepOneViewController" bundle:nil];
    
    rvc.openid = self.openid;
    
    [self.navigationController pushViewController:rvc animated:YES];
    [rvc release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_accountField release];
    [_passwordField release];
    [_openid release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setAccountField:nil];
    [self setPasswordField:nil];
    [self setOpenid:nil];
    [super viewDidUnload];
}

#pragma mark - 服务器回调
- (void)BindQQSucceess:(id)sender data:(NSDictionary *)dic {
    LoginResponseVo *vo = [[LoginResponseVo alloc] initWithDic:dic];
    
    
    if (vo.status == 0) {
        //绑定成功并登录成功，保存用户信息
        [BSContainer instance].userInfo = vo.userInfo;
        //处理记住密码
        NSString *username = self.accountField.text;
        NSString *password = self.passwordField.text;
        //获取是否保存用户名密码
        //保存用户名
        [UserInfoDao saveLoginInfoUsername:username
                                  password:password
                                isRemember:0];

        
        [app viewUpdate];
        app.window.rootViewController = app.revealSideViewController;
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:vo.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
    }
    [vo release];
    
    [progressHUD hide:YES];
}



- (void)BindQQFailed:(id)sender data:(NSDictionary *)dic {
    //登录失败，取消加载框
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"网络异常，请检查网络连接后重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    [progressHUD hide:YES];
}
@end
