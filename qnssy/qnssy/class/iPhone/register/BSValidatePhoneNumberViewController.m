//
//  BSValidatePhoneNumberViewController.m
//  qnssy
//
//  Created by juchen on 13-3-16.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSValidatePhoneNumberViewController.h"
#import "BSUserInfoViewController.h"

@interface BSValidatePhoneNumberViewController (){
    int second;
}

@end

@implementation BSValidatePhoneNumberViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.validateNumber = [[UITextField alloc] initWithFrame:CGRectMake(20, 97, 170, 40)];
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
//    [self hiddenKeyBoardFromView];
    [self.resendButton setEnabled:NO];
    [self beginTimer];
    //头部nav背景
    [self.myNavigationBar setBackgroundImage:[UIImage imageNamed:@"2顶部条状背景"] forBarMetrics:UIBarMetricsDefault];
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

//- (void) hiddenKeyBoardFromView{
//    self.view.userInteractionEnabled = YES;
//    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyBoard:)];
//    [self.view addGestureRecognizer:tapGesture];
//}
//
//- (void) hiddenKeyBoard:(id) sender{
//    [self.validateNumber resignFirstResponder];
//}
- (void)viewDidUnload {
    [self setResendButton:nil];
    [self setMyNavigationBar:nil];
    [super viewDidUnload];
}
- (IBAction)resendAction:(id)sender {
    [self.timer invalidate];
    second = 60;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handlerTimer:) userInfo:nil repeats:YES];
    [self.resendButton setEnabled: NO];
}

#pragma mark - 提交注册
- (IBAction)submitAction:(id)sender {
    QRootElement *root = [[QRootElement alloc] init];
    
    BSUserInfoViewController *userInfoController = (BSUserInfoViewController *)[[BSUserInfoViewController alloc] initWithRoot:root];
    [self.navigationController pushViewController:userInfoController animated:YES];
}
- (IBAction)clickBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void) dealloc {
    [_validateNumber release];
    [_resendButton release];
    [_myNavigationBar release];
    [super dealloc];
}

@end
