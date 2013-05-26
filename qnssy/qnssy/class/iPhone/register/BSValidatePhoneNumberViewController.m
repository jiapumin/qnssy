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
}

@end

@implementation BSValidatePhoneNumberViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.validateNumber = [[UITextField alloc] initWithFrame:CGRectMake(20, 61, 170, 40)];
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
}

- (void)viewWillAppear:(BOOL)animated {
    self.userMobileLabel.text = self.mobile;
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
//    QRootElement *root = [[QRootElement alloc] init];
//    // 如果用户填写了验证码，则将用户填写的验证码进行MD5加密，并和服务器返回的MD5验证码做比对
////    if ([[MyMD5 md5:self.validateNumber.text] isEqualToString:self.md5code]) {
//        BSUserInfoViewController *userInfoController = (BSUserInfoViewController *)[[BSUserInfoViewController alloc] initWithRoot:root];
//    userInfoController.mobile = self.mobile;
//    userInfoController.password = self.password;
//        [self.navigationController pushViewController:userInfoController animated:YES];
//        [userInfoController release];
//    } else {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"验证码输入不正确" delegate:self cancelButtonTitle:@"重新输入" otherButtonTitles:nil];
//        [alertView show];
//        [alertView release];
//    }
    
    BSUserBasicInfoViewController *basicInfoViewController = [[BSUserBasicInfoViewController alloc] initWithNibName:@"BSUserBasicInfoViewController" bundle:nil];
    basicInfoViewController.mobile = self.mobile;
    basicInfoViewController.password = self.password;
    [self.navigationController pushViewController:basicInfoViewController animated:YES];
    [basicInfoViewController release];
}

#pragma mark - 服务器回调

- (void) validateSucceess:(id) sender data:(NSDictionary *) dic{
    ValidatePhoneResponseVo *vo = [[ValidatePhoneResponseVo alloc] initWithDic:dic];
    // 服务器验证成功后，跳转到验证码验证界面
    if ([vo.isSuccess isEqualToNumber:[NSNumber numberWithBool:YES]]) {
        self.md5code = vo.md5code;
    } else {
        // 服务器验证失败，提示用户
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:vo.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}

- (void) validateFailed:(id) sender data:(NSDictionary *) dic{
    NSLog(@"-----  %@",dic);
}

- (void) dealloc {
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
