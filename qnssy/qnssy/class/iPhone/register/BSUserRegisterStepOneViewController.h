//
//  BSUserRegisterStepOneViewController.h
//  qnssy
//
//  Created by juchen on 13-3-15.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSUserRegisterStepOneViewController : UIViewController <UITextFieldDelegate>
@property (retain, nonatomic) UITextField *userAccount;
@property (retain, nonatomic) UITextField *userPassword;
- (IBAction)tiaokuanAction:(id)sender;
- (IBAction)zhengceAction:(id)sender;

@end
