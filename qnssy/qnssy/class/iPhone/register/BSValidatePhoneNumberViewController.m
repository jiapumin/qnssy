//
//  BSValidatePhoneNumberViewController.m
//  qnssy
//
//  Created by juchen on 13-3-16.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSValidatePhoneNumberViewController.h"
#import "BSUserInfoViewController.h"
#import "ValidatePhoneRequestVo.h"
#import "ValidatePhoneResponseVo.h"
#import "MyMD5.h"
#import "BSUserBasicInfoViewController.h"

@interface BSValidatePhoneNumberViewController (){
    int second;
    MBProgressHUD *progressHUD;
}

@end

@implementation BSValidatePhoneNumberViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.validateNumber = [[[UITextField alloc] initWithFrame:CGRectMake(20, 61, 170, 40)] autorelease];
        self.validateNumber.borderStyle = UITextBorderStyleRoundedRect;
        self.validateNumber.placeholder = @"请输入验证码";
        self.validateNumber.keyboardType = UIKeyboardTypePhonePad;
        self.validateNumber.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.validateNumber.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;

        [self.view addSubview:self.validateNumber];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.resendButton setEnabled:NO];
    [self beginTimer];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"验证码激活";
    //初始化加载框
    [self initHUDView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.userMobileLabel.text = self.mobile;
}
- (void)initHUDView{
    //-------加载框
    progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:progressHUD];
    
    progressHUD.labelText = @"数据加载中...";
    
}
- (void) beginTimer {
    second = 60;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handlerTimer:) userInfo:nil repeats:YES];
}

- (void) handlerTimer:(NSTimer *) timer {
    if (second > 0) {
        second --;
        self.resendButton.titleLabel.text = [NSString stringWithFormat:@"%d秒后重新发送",second];
    } else {
        [self.resendButton setEnabled:YES];
        self.resendButton.titleLabel.text = @"重新发送验证码";
        [self.timer invalidate];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setOpenid:nil];
    [self setResendButton:nil];
    [self setMyNavigationBar:nil];
    [self setUserMobileLabel:nil];
    [super viewDidUnload];
}
- (IBAction)resendAction:(id)sender {
    [self.timer invalidate];
    second = 60;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handlerTimer:) userInfo:nil repeats:YES];
    [self.resendButton setEnabled: NO];

    [progressHUD show:YES];
    ValidatePhoneRequestVo *requestVo = [[ValidatePhoneRequestVo alloc] initWithPhoneNumAndPassword:self.mobile password:self.password];
    [[BSContainer instance].serviceAgent callServletWithObject:self
                                                   requestDict:requestVo.mReqDic
                                                        target:self
                                               successCallBack:@selector(validateSucceess:data:)
                                                  failCallBack:@selector(validateFailed:data:)];
    [requestVo release];
}

#pragma mark - 提交注册-进行MD5验证
- (IBAction)submitAction:(id)sender {

    // 如果用户填写了验证码，则将用户填写的验证码进行MD5加密，并和服务器返回的MD5验证码做比对
    if (self.validateNumber.text != nil) {
        if ([[MyMD5 md5:self.validateNumber.text] isEqualToString:self.md5code]) {
            BSUserBasicInfoViewController *basicInfoViewController = [[BSUserBasicInfoViewController alloc] initWithNibName:@"BSUserBasicInfoViewController" bundle:nil];
            basicInfoViewController.mobile = self.mobile;
            basicInfoViewController.password = self.password;
            basicInfoViewController.openid = self.openid;
            
            [self.navigationController pushViewController:basicInfoViewController animated:YES];
            [basicInfoViewController release];
            
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"验证码输入不正确" delegate:self cancelButtonTitle:@"重新输入" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
        }
    } 
}

#pragma mark - 服务器回调

- (void) validateSucceess:(id) sender data:(NSDictionary *) dic{
    ValidatePhoneResponseVo *vo = [[ValidatePhoneResponseVo alloc] initWithDic:dic];
    // 服务器验证成功后，跳转到验证码验证界面
    if (vo.status == 0) {
        self.md5code = vo.md5code;
    } else {
        // 服务器验证失败，提示用户
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:vo.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
    [progressHUD hide:YES];
    [vo release];
}

- (void) validateFailed:(id) sender data:(NSDictionary *) dic{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"网络异常，请检查网络连接后重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    [progressHUD hide:YES];
}

- (void) dealloc {
    [_openid release];
    [_validateNumber release];
    [_resendButton release];
    [_myNavigationBar release];
    [_md5code release];
    [_mobile release];
    [_password release];
    [_userMobileLabel release];
    [super dealloc];
}

@end
