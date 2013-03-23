//
//  BSUserRegisterStepOneViewController.h
//  qnssy
//
//  Created by juchen on 13-3-15.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TPKeyboardAvoidingScrollView;

@interface BSUserRegisterStepOneViewController : UIViewController <UITextFieldDelegate>
@property (retain, nonatomic) UITextField *userAccount;
@property (retain, nonatomic) UITextField *userPassword;
@property (retain, nonatomic) IBOutlet UINavigationBar *myNavigationBar;
@property (retain, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
- (IBAction)tiaokuanAction:(id)sender;
- (IBAction)zhengceAction:(id)sender;
- (IBAction)registerNextAction:(id)sender;

- (IBAction)clickBackButton:(id)sender;
@end
