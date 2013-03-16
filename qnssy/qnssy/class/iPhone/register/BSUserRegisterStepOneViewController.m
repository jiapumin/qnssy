//
//  BSUserRegisterStepOneViewController.m
//  qnssy
//
//  Created by juchen on 13-3-15.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSUserRegisterStepOneViewController.h"

@interface BSUserRegisterStepOneViewController (){
    BOOL isTextFieldMoved;
}

@end

@implementation BSUserRegisterStepOneViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.userAccount = [[UITextField alloc] initWithFrame:CGRectMake(20, 74, 280, 40)];
        self.userAccount.borderStyle = UITextBorderStyleRoundedRect;
        self.userAccount.placeholder = @"请输入您的手机号码";
        self.userAccount.keyboardType = UIKeyboardTypePhonePad;
        self.userAccount.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.userAccount.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.userPassword = [[UITextField alloc] initWithFrame:CGRectMake(20, 138, 280, 40)];
        self.userPassword.borderStyle = UITextBorderStyleRoundedRect;
        self.userPassword.placeholder = @"密码（6-20位）";
        self.userPassword.keyboardType = UIKeyboardTypeDefault;
        self.userPassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.userPassword.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        self.userAccount.delegate = self;
        self.userPassword.delegate = self;
        
        [self.view addSubview:self.userAccount];
        [self.view addSubview:self.userPassword];
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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_userAccount release];
    [_userPassword release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setUserAccount:nil];
    [self setUserPassword:nil];
    [super viewDidUnload];
}
- (IBAction)tiaokuanAction:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"条款" message:@"服务条款" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

- (IBAction)zhengceAction:(id)sender {
    
}
@end
