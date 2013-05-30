//
//  BSUserRegisterStepOneViewController.h
//  qnssy
//
//  Created by juchen on 13-3-15.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TPKeyboardAvoidingScrollView;

#import "BSSuperCentreViewController_iPhone.h"

@interface BSUserRegisterStepOneViewController : BSSuperCentreViewController_iPhone <UITextFieldDelegate>
@property (retain, nonatomic) UITextField *userAccount;
@property (retain, nonatomic) UITextField *userPassword;
@property (retain, nonatomic) NSString *openid;

@property (retain, nonatomic) IBOutlet UINavigationBar *myNavigationBar;
@property (retain, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIButton *agreementButton;
- (IBAction) toggleAgreementButtonStatus:(id) sender;
- (IBAction)tiaokuanAction:(id)sender;
- (IBAction)zhengceAction:(id)sender;
- (IBAction)registerNextAction:(id)sender;

@end
