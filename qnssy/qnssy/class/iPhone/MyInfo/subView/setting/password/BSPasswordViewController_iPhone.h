//
//  BSAboutViewController_iphone.h
//  qnssy
//
//  Created by jpm on 13-4-21.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSSuperCentreViewController_iPhone.h"

@interface BSPasswordViewController_iPhone : BSSuperCentreViewController_iPhone<UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UITextField *oldPasswordText;
@property (retain, nonatomic) IBOutlet UITextField *passwordTextNew;
@property (retain, nonatomic) IBOutlet UIButton *changePasswordButton;
- (IBAction)clickChangeButton:(id)sender;

@end
