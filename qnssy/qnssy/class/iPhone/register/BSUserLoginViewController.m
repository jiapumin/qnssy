//
//  BSUserLoginViewController.m
//  qnssy
//
//  Created by juchen on 13-3-15.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSUserLoginViewController.h"
#import "BSUserRegisterStepOneViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "LoginRequestVo.h"
#import "LoginResponseVo.h"
#import "BSBindUserAccountViewController.h"
#import "UserInfo.h"
#import "BSRootLeftViewController_iPhone.h"
#import "UserInfoDao.h"
#import "BSForgetPasswordViewController_iPhone.h"


#import "BSVerifyBindRequestVo.h"

@interface BSUserLoginViewController (){
    BOOL isTextFieldMoved;
    BOOL isAutoLogin;
    MBProgressHUD *progressHUD;
}

@end

@implementation BSUserLoginViewController

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
    self.userAccount.delegate  = self;
    self.userPassword.delegate = self;
    self.userPassword.secureTextEntry = YES;
    isTextFieldMoved = NO;
    [self configLoginBackgroundView];
    //隐藏键盘处理
    CGRect contentRect = CGRectZero;
    for ( UIView *subview in self.scrollView.subviews ) {
        contentRect = CGRectUnion(contentRect, subview.frame);
    }
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, CGRectGetMaxY(contentRect)+10);
    //出事化加载框
    [self initHUDView];
//    //此处检测本地是否自动登录，如果自动登录则请求服务器进行登录，否则进入登录界面
    //此处获取是否保存用户名密码
    NSDictionary *loginInfo = [UserInfoDao loginInfoForFile];
    isAutoLogin = [[loginInfo objectForKey:@"isRemember"] isEqualToString:@"true"];
    if (isAutoLogin) {
        //设置选中状态
        isAutoLogin = NO;
        [self autoLogin:nil];
        
        //读取记忆的用户名和密码
        if (loginInfo != nil) {
            [self.userAccount setText:[loginInfo valueForKey:USERNAME_USERINFO]];
            [self.userPassword setText:[loginInfo valueForKey:USERPARD_USERINFO]];
            [self loginRequestData];
        }
        
    }else{
        //读取记忆的用户名
        if (loginInfo != nil) {
            [self.userAccount setText:[loginInfo valueForKey:USERNAME_USERINFO]];
//            [self.userPassword setText:[loginInfo valueForKey:USERPARD_USERINFO]];
        }
    }
    
    //腾讯登录服务
    _permissions = [[NSArray arrayWithObjects:
                     kOPEN_PERMISSION_GET_USER_INFO,
                     kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                     kOPEN_PERMISSION_ADD_ALBUM,
                     kOPEN_PERMISSION_ADD_IDOL,
                     kOPEN_PERMISSION_ADD_ONE_BLOG,
                     kOPEN_PERMISSION_ADD_PIC_T,
                     kOPEN_PERMISSION_ADD_SHARE,
                     kOPEN_PERMISSION_ADD_TOPIC,
                     kOPEN_PERMISSION_CHECK_PAGE_FANS,
                     kOPEN_PERMISSION_DEL_IDOL,
                     kOPEN_PERMISSION_DEL_T,
                     kOPEN_PERMISSION_GET_FANSLIST,
                     kOPEN_PERMISSION_GET_IDOLLIST,
                     kOPEN_PERMISSION_GET_INFO,
                     kOPEN_PERMISSION_GET_OTHER_INFO,
                     kOPEN_PERMISSION_GET_REPOST_LIST,
                     kOPEN_PERMISSION_LIST_ALBUM,
                     kOPEN_PERMISSION_UPLOAD_PIC,
                     kOPEN_PERMISSION_GET_VIP_INFO,
                     kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                     kOPEN_PERMISSION_GET_INTIMATE_FRIENDS_WEIBO,
                     kOPEN_PERMISSION_MATCH_NICK_TIPS_WEIBO,
                     nil] retain];
	
    NSString *appid = @"100400895";
    
	_tencentOAuth = [[TencentOAuth alloc] initWithAppId:appid
											andDelegate:self];
}

- (void)loginRequestData{
    [progressHUD show:YES];
    
    NSString *userName = self.userAccount.text;
    NSString *userPassword = self.userPassword.text;
    if (userName == nil || [userName isEqualToString:@""]) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写用户名" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
        [alterView release];
        [progressHUD hide:YES];
    } else if (userPassword == nil || [userPassword isEqualToString:@""]) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
        [alterView release];
        [progressHUD hide:YES];
    } else {
        //请求服务器
        LoginRequestVo *vo = [[LoginRequestVo alloc] initWithUsername:userName password:userPassword];
        
        [[BSContainer instance].serviceAgent callServletWithObject:self
                                                       requestDict:vo.mReqDic
                                                            target:self
                                                   successCallBack:@selector(loginSucceess:data:)
                                                      failCallBack:@selector(loginFailed:data:)];
        
        [vo release];
    }
}
- (void)initHUDView{
    //-------加载框
    progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:progressHUD];
    
    progressHUD.labelText = @"数据加载中...";
    
}

- (void) configLoginBackgroundView {
    CALayer *layer = self.loginBackgroundView.layer;
    layer.cornerRadius = 8.0;
    UIColor *color = [UIColor colorWithRed:0.843 green:0.027 blue:0.16 alpha:1];
    CGColorRef colorref = [color CGColor];
    layer.borderColor = colorref;
    layer.borderWidth = 2.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)dealloc {
    [_loginBackgroundView release];
    [_userAccount release];
    [_userPassword release];
    [_scrollView release];
    [_loginButton release];
    [_loginQQButton release];
    [_autoButton release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setLoginBackgroundView:nil];
    [self setUserAccount:nil];
    [self setUserPassword:nil];
    [self setScrollView:nil];
    [self setLoginButton:nil];
    [self setLoginQQButton:nil];
    [self setAutoButton:nil];
    [super viewDidUnload];
}

#pragma mark - 注册事件
- (IBAction)toRegister:(id)sender {
   
    BSUserRegisterStepOneViewController *stepOne = [[BSUserRegisterStepOneViewController alloc] initWithNibName:@"BSUserRegisterStepOneViewController" bundle:nil];
    [self.navigationController pushViewController:stepOne animated:YES];
    [stepOne release];
}

#pragma mark - 登录事件
- (IBAction)clickLoginButton:(id)sender {
    [self loginRequestData];
    [self.userAccount resignFirstResponder];
    [self.userPassword resignFirstResponder];
}

#pragma mark - QQ登录
- (IBAction)clickQQLoginButton:(id)sender {
    [_tencentOAuth authorize:_permissions inSafari:NO];
}

#pragma mark - 腾讯登录Delegate

- (void)tencentDidLogin {
    if (_tencentOAuth.accessToken && 0 != [_tencentOAuth.accessToken length]) {
        
        //请求服务器是否绑定
        [progressHUD show:YES];
        //请求服务器
        BSVerifyBindRequestVo *vo = [[BSVerifyBindRequestVo alloc] initWithId:_tencentOAuth.openId];
        
        [[BSContainer instance].serviceAgent callServletWithObject:self
                                                       requestDict:vo.mReqDic
                                                            target:self
                                                   successCallBack:@selector(VerifyBindSucceess:data:)
                                                      failCallBack:@selector(loginFailed:data:)];
        
        [vo release];

        // 记录登录用户的OpenID、Token以及过期时间
        //_labelAccessToken.text = _tencentOAuth.accessToken;
//        QRootElement *root = [[QRootElement alloc] init];
//        root.presentationMode = QPresentationModeNormal;
//        BSBindUserAccountViewController *bindUserAccountVC = [[BSBindUserAccountViewController alloc] initWithNibName:@"BSBindUserAccountViewController" bundle:nil];
//        [self.navigationController pushViewController:bindUserAccountVC animated:YES];
//        [bindUserAccountVC release];
    } else {
        //@"登录不成功 没有获取accesstoken";
    }
}

-(void)tencentDidNotLogin:(BOOL)cancelled {
    if (cancelled)  {
        //_labelTitle.text = @"用户取消登录";
    } else {
        //_labelTitle.text = @"登录失败";
    }
}

-(void)tencentDidNotNetWork {
    //_labelTitle.text=@"无网络连接，请设置网络";
}

/**
 * Get user info.
 */
- (void)onClickGetUserInfo {
//	_labelTitle.text = @"开始获取用户基本信息";
	if(![_tencentOAuth getUserInfo]){
        [self showInvalidTokenOrOpenIDMessage];
    }
}

- (void)showInvalidTokenOrOpenIDMessage{
    UIAlertView *alert = [[[UIAlertView alloc]initWithTitle:@"api调用失败" message:@"可能授权已过期，请重新获取" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] autorelease];
    [alert show];
}

#pragma mark - 服务器回调
- (void)VerifyBindSucceess:(id)sender data:(NSDictionary *)dic {
    LoginResponseVo *vo = [[LoginResponseVo alloc] initWithDic:dic];
    
    
    if (vo.status == 0) {
        [self loginSaveData:vo];
    }else{
        //验证失败跳转到填写用户信息界面
        
        BSBindUserAccountViewController *buavc = [[BSBindUserAccountViewController alloc] initWithNibName:@"BSBindUserAccountViewController" bundle:nil];
        buavc.openid = _tencentOAuth.openId;
        [self.navigationController pushViewController:buavc animated:YES];
        
        [buavc release];
        
    }
    [vo release];
    
    
    [progressHUD hide:YES];
}


- (void)loginSucceess:(id)sender data:(NSDictionary *)dic {
    LoginResponseVo *vo = [[LoginResponseVo alloc] initWithDic:dic];
    
    NSLog(@"用户id:%@--登录消息:%@",vo.userInfo.userId,vo.message);


   if (vo.status == 0) {
       [self loginSaveData:vo];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:vo.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    [vo release];
    
    [progressHUD hide:YES];
}
- (void)loginSaveData:(LoginResponseVo *)vo{
    //登录成功，保存用户信息
    [BSContainer instance].userInfo = vo.userInfo;
    //处理记住密码
    NSString *username = self.userAccount.text;
    NSString *password = self.userPassword.text;
    //获取是否保存用户名密码
    if (isAutoLogin) {
        //保存用户名和密码
        [UserInfoDao saveLoginInfoUsername:username
                                  password:password
                                isRemember:1];
    }else{
        //保存用户名
        [UserInfoDao saveLoginInfoUsername:username
                                  password:password
                                isRemember:0];
    }
    
    
    //加载界面
    [app viewUpdate];
    app.window.rootViewController = app.revealSideViewController;
}
- (void)loginFailed:(id)sender data:(NSDictionary *)dic {
    
    //登录失败，取消加载框
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"网络异常，请检查网络连接后重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    NSLog(@"%@",dic);
    //???
    [progressHUD hide:YES];
}
- (IBAction)clickForgetPassword:(id)sender {
    BSForgetPasswordViewController_iPhone *fpvc = [[BSForgetPasswordViewController_iPhone alloc] initWithNibName:@"BSForgetPasswordViewController_iPhone" bundle:nil];
    [self.navigationController pushViewController:fpvc animated:YES];
    [fpvc release];
    
}

- (IBAction)autoLogin:(id)sender {
    if (!isAutoLogin) {
        isAutoLogin = YES;
        [self.autoButton setBackgroundImage:[UIImage imageNamed:@"1复选框选中@2x.png"] forState:UIControlStateNormal];
    } else {
        isAutoLogin = NO;
        [self.autoButton setBackgroundImage:[UIImage imageNamed:@"1复选框未选中@2x.png"] forState:UIControlStateNormal];
    }
}
@end
