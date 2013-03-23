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
//    [self configLoginBackgroundView];
//    [self hiddenKeyBoardFromView];
//
//    [self.registerButton addTarget:self action:@selector(toRegister:) forControlEvents:UIControlEventTouchUpInside];
//    self.userAccount.delegate  = self;
//    self.userPassword.delegate = self;
//    self.userPassword.secureTextEntry = YES;
//    isTextFieldMoved = NO;
//    [self configLoginBackgroundView];
//    [self hiddenKeyBoardFromView];
    //隐藏键盘处理
    CGRect contentRect = CGRectZero;
    for ( UIView *subview in self.scrollView.subviews ) {
        contentRect = CGRectUnion(contentRect, subview.frame);
    }
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, CGRectGetMaxY(contentRect)+10);
    //出事化加载框
    [self initHUDView];
    //此处检测本地是否自动登录，如果自动登录则请求服务器进行登录，否则进入登录界面
    isAutoLogin = NO;
    if (isAutoLogin) {
        
        [self loginRequestData];
        
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
    
    //请求服务器
    LoginRequestVo *vo = [[LoginRequestVo alloc] initWithUsername:@"jiapumin@163.com" password:@"jiapumin"];
    
    [[BSContainer instance].serviceAgent callServletWithObject:self
                                                   requestDict:vo.mReqDic
                                                        target:self
                                               successCallBack:@selector(loginSucceess:data:)
                                                  failCallBack:@selector(loginFailed:data:)];
    
    [vo release];
}
- (void)initHUDView{
    //-------加载框
    progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:progressHUD];
    
    progressHUD.labelText = @"数据加载中...";
    
}

//- (void) configLoginBackgroundView {
//    CALayer *layer = self.loginBackgroundView.layer;
//    layer.cornerRadius = 8.0;
//    UIColor *color = [UIColor colorWithRed:0.843 green:0.027 blue:0.16 alpha:1];
//    CGColorRef colorref = [color CGColor];
//    layer.borderColor = colorref;
//    layer.borderWidth = 2.0;
//}

//- (void) hiddenKeyBoardFromView{
//    self.view.userInteractionEnabled = YES;
////    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyBoard:)];
////    [self.view addGestureRecognizer:tapGesture];
//}

//- (void) hiddenKeyBoard:(id) sender{
//    [self.userAccount resignFirstResponder];
//    [self.userPassword resignFirstResponder];
//}

#pragma mark - TextField Delegate
//
//- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    if (isTextFieldMoved == NO) {
//        NSTimeInterval animationDuration = 0.5f;
//        CGRect frame = self.view.frame;
//        frame.origin.y -=216;
//        frame.size.height +=216;
//        self.view.frame = frame;
//        [UIView beginAnimations:@"ResizeView" context:nil];
//        [UIView setAnimationDuration:animationDuration];
//        self.view.frame = frame;
//        [UIView commitAnimations];
//    }
//    isTextFieldMoved = YES;
//}
//
//- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    if (isTextFieldMoved == YES) {
//        NSTimeInterval animationDuration = 0.5f;
//        CGRect frame = self.view.frame;
//        frame.origin.y +=216;
//        frame.size. height -=216;
//        self.view.frame = frame;
//        [UIView beginAnimations:@"ResizeView" context:nil];
//        [UIView setAnimationDuration:animationDuration];
//        self.view.frame = frame;
//        [UIView commitAnimations];
//        [textField resignFirstResponder];
//    }
//    isTextFieldMoved = NO;
//    return YES;
//}

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
//    [_userLogoImage_1 release];
    [_loginBackgroundView release];
    [_userAccount release];
    [_userPassword release];
    [_scrollView release];
    [_loginButton release];
    [_loginQQButton release];
    [super dealloc];
}
- (void)viewDidUnload {
//    [self setUserLogoImage_1:nil];
    [self setLoginBackgroundView:nil];
    [self setUserAccount:nil];
    [self setUserPassword:nil];
    [self setScrollView:nil];
    [self setLoginButton:nil];
    [self setLoginQQButton:nil];
    [super viewDidUnload];
}

#pragma mark - 注册事件
- (IBAction)toRegister:(id)sender {
   
    BSUserRegisterStepOneViewController *stepOne = [[BSUserRegisterStepOneViewController alloc] initWithNibName:@"BSUserRegisterStepOneViewController" bundle:nil];
    [self.navigationController pushViewController:stepOne animated:YES];
    [stepOne release];
}

- (IBAction)clickLoginButton:(id)sender {
//    [self loginRequestData];
    app.window.rootViewController = app.revealSideViewController;
}

- (IBAction)clickQQLoginButton:(id)sender {
    [_tencentOAuth authorize:_permissions inSafari:NO];
}



#pragma mark - 服务器回调
- (void)loginSucceess:(id)sender data:(NSDictionary *)dic {
    LoginResponseVo *vo = [[LoginResponseVo alloc] initWithDic:dic];
    
    
    NSLog(@"用户id:%@--登录消息:%@",vo.userId,vo.message);
    //登录成功，保存用户信息
    
    
    //进入主界面
    [self.view addSubview:app.revealSideViewController.view];
    
    [progressHUD hide:YES];
}

- (void)loginFailed:(id)sender data:(NSDictionary *)dic {
    //登录失败，取消加载框
    NSLog(@"%@",dic);
    //???
    [progressHUD hide:YES];
}
- (IBAction)autoLogin:(id)sender {
    if (!isAutoLogin) {
        isAutoLogin = YES;
        [sender setBackgroundImage:[UIImage imageNamed:@"1复选框选中@2x.png"] forState:UIControlStateNormal];
    } else {
        isAutoLogin = NO;
        [sender setBackgroundImage:[UIImage imageNamed:@"1复选框未选中@2x.png"] forState:UIControlStateNormal];
    }
}
@end
