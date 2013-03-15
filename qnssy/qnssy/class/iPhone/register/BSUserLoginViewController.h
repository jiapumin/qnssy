//
//  BSUserLoginViewController.h
//  qnssy
//
//  Created by juchen on 13-3-15.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSUserLoginViewController : UIViewController <UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UIImageView *userLogoImage_1;
@property (retain, nonatomic) IBOutlet UIImageView *userLogoImage_2;
@property (retain, nonatomic) IBOutlet UIImageView *userLogoImage_3;
@property (retain, nonatomic) IBOutlet UIImageView *userLogoImage_4;
@property (retain, nonatomic) IBOutlet UIImageView *userLogoImage_5;
@property (retain, nonatomic) IBOutlet UIImageView *userLogoImage_6;
@property (retain, nonatomic) IBOutlet UIImageView *userLogoImage_7;
@property (retain, nonatomic) IBOutlet UIImageView *userLogoImage_8;
@property (retain, nonatomic) IBOutlet UIImageView *userLogoImage_9;
@property (retain, nonatomic) IBOutlet UIImageView *userLogoImage_10;
@property (retain, nonatomic) IBOutlet UITextField *userAccount;
@property (retain, nonatomic) IBOutlet UITextField *userPassword;

@property (retain, nonatomic) IBOutlet UIView *loginBackgroundView;

@end
