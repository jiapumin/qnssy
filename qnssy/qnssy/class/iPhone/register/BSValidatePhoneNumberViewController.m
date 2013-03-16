//
//  BSValidatePhoneNumberViewController.m
//  qnssy
//
//  Created by juchen on 13-3-16.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSValidatePhoneNumberViewController.h"

@interface BSValidatePhoneNumberViewController ()

@end

@implementation BSValidatePhoneNumberViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.validateNumber = [[UITextField alloc] initWithFrame:CGRectMake(20, 104, 170, 40)];
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
    [self hiddenKeyBoardFromView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc {
    [_validateNumber release];
    [super dealloc];
}

- (void) hiddenKeyBoardFromView{
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyBoard:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void) hiddenKeyBoard:(id) sender{
    [self.validateNumber resignFirstResponder];
}
@end
