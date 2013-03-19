//
//  BSValidatePhoneNumberViewController.h
//  qnssy
//
//  Created by juchen on 13-3-16.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSValidatePhoneNumberViewController : UIViewController

@property (retain, nonatomic) UITextField *validateNumber;
@property (retain, nonatomic) IBOutlet UIButton *resendButton;
@property (retain, nonatomic) NSTimer *timer;;
- (IBAction)resendAction:(id)sender;
- (IBAction)submitAction:(id)sender;

@end
