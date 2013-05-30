//
//  BSBindUserAccountViewController.h
//  qnssy
//
//  Created by juchen on 13-3-27.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "QuickDialogController.h"
#import "BSSuperCentreViewController_iPhone.h"


@interface BSBindUserAccountViewController : BSSuperCentreViewController_iPhone<UITextFieldDelegate>

@property (retain, nonatomic)NSString *openid;

@property (retain, nonatomic) UITextField *accountField;

@property (retain, nonatomic) UITextField *passwordField;


@end
