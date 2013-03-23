//
//  BSUserRegisterStepOneViewController.m
//  qnssy
//
//  Created by juchen on 13-3-15.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSUserRegisterStepOneViewController.h"
#import "BSValidatePhoneNumberViewController.h"

#import "TPKeyboardAvoidingScrollView.h"

@interface BSUserRegisterStepOneViewController (){
    BOOL isTextFieldMoved;
}

@end

@implementation BSUserRegisterStepOneViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        

    }
    return self;
}


#pragma mark - TextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //隐藏键盘处理
    CGRect contentRect = CGRectZero;
    for ( UIView *subview in self.scrollView.subviews ) {
        contentRect = CGRectUnion(contentRect, subview.frame);
    }
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, CGRectGetMaxY(contentRect)+10);
    //头部nav背景
    [self.myNavigationBar setBackgroundImage:[UIImage imageNamed:@"2顶部条状背景"] forBarMetrics:UIBarMetricsDefault];

    //初始化控件
    self.userAccount = [[UITextField alloc] initWithFrame:CGRectMake(20, 20, 280, 40)];
    self.userAccount.borderStyle = UITextBorderStyleRoundedRect;
    self.userAccount.placeholder = @"请输入您的手机号码";
    self.userAccount.keyboardType = UIKeyboardTypePhonePad;
    self.userAccount.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.userAccount.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.userAccount.text = @"15666666666";
    self.userPassword = [[UITextField alloc] initWithFrame:CGRectMake(20, 80, 280, 40)];
    self.userPassword.borderStyle = UITextBorderStyleRoundedRect;
    self.userPassword.placeholder = @"密码（6-20位）";
    self.userPassword.keyboardType = UIKeyboardTypeDefault;
    self.userPassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.userPassword.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    self.userAccount.delegate = self;
    self.userPassword.delegate = self;
    
    [self.scrollView addSubview:self.userAccount];
    [self.scrollView addSubview:self.userPassword];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_userAccount release];
    [_userPassword release];
    [_scrollView release];
    [_myNavigationBar release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setUserAccount:nil];
    [self setUserPassword:nil];
    [self setScrollView:nil];
    [self setMyNavigationBar:nil];
    [super viewDidUnload];
}
- (IBAction)tiaokuanAction:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"条款" message:@"服务条款" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

- (IBAction)zhengceAction:(id)sender {
    
}

- (IBAction)registerNextAction:(id)sender {
    NSString *phoneNumber = self.userAccount.text;
    BOOL isPhoneNumber = [self isMobileNumber:phoneNumber];
    if (isPhoneNumber) {
        BSValidatePhoneNumberViewController *validatePhoneNumber = [[BSValidatePhoneNumberViewController alloc] initWithNibName:@"BSValidatePhoneNumberViewController" bundle:nil];
        [self.navigationController pushViewController:validatePhoneNumber animated:YES];
        [validatePhoneNumber release];
    } else {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"请输入正确的手机号码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        [alter release];
    }
}

- (IBAction)clickBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

// 正则判断手机号码地址格式
- (BOOL)isMobileNumber:(NSString *)mobileNum {
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
      * 中国移动：China Mobile
      * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
      */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
      * 中国联通：China Unicom
      * 130,131,132,152,155,156,185,186
      */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
      * 中国电信：China Telecom
      * 133,1349,153,180,189
      */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
      * 大陆地区固话及小灵通
      * 区号：010,020,021,022,023,024,025,027,028,029
      * 号码：七位或八位
      */
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)) {
        return YES;
    } else {
        return NO;
    }
}
//
//- (void) hiddenKeyBoardFromView{
//    self.view.userInteractionEnabled = YES;
//    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyBoard:)];
//    [self.view addGestureRecognizer:tapGesture];
//}
//
//- (void) hiddenKeyBoard:(id) sender{
//    [self.userAccount resignFirstResponder];
//    [self.userPassword resignFirstResponder];
//}

@end
