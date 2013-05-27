//
//  BSValidatePhoneNumberViewController.h
//  qnssy
//
//  Created by juchen on 13-3-16.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSSuperCentreViewController_iPhone.h"

@interface BSValidatePhoneNumberViewController : BSSuperCentreViewController_iPhone

@property (retain, nonatomic) IBOutlet UILabel *userMobileLabel;
@property (retain, nonatomic) UITextField *validateNumber;
@property (retain, nonatomic) IBOutlet UIButton *resendButton;
@property (retain, nonatomic) NSTimer *timer;;
@property (retain, nonatomic) IBOutlet UINavigationBar *myNavigationBar;
@property (retain, nonatomic) NSString *md5code;
@property (assign, nonatomic) BOOL isResend;
// 这里定义用户的手机号码和密码，是为了用户在点击重新发送按钮时，能再次请求服务器
@property (retain, nonatomic) NSString *mobile;
@property (retain, nonatomic) NSString *password;
- (IBAction)resendAction:(id)sender;
- (IBAction)submitAction:(id)sender;

@end
