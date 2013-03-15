//
//  BSUserLoginViewController.m
//  qnssy
//
//  Created by juchen on 13-3-15.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSUserLoginViewController.h"

@interface BSUserLoginViewController (){
    BOOL isTextFieldMoved;
}

@end

@implementation BSUserLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.userAccount.delegate  = self;
    self.userPassword.delegate = self;
    self.userPassword.secureTextEntry = YES;
    isTextFieldMoved = NO;
    [self configLoginBackgroundView];
}

- (void) configLoginBackgroundView {
    CALayer *layer = self.loginBackgroundView.layer;
    layer.cornerRadius = 8.0;
    UIColor *color = [UIColor colorWithRed:0.843 green:0.027 blue:0.16 alpha:1];
    CGColorRef colorref = [color CGColor];
    layer.borderColor = colorref;
    layer.borderWidth = 2.0;
//    layer.shadowColor
    
}

#pragma mark - TextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (isTextFieldMoved == NO) {
        NSTimeInterval animationDuration = 0.5f;
        CGRect frame = self.view.frame;
        frame.origin.y -=216;
        frame.size.height +=216;
        self.view.frame = frame;
        [UIView beginAnimations:@"ResizeView" context:nil];
        [UIView setAnimationDuration:animationDuration];
        self.view.frame = frame;
        [UIView commitAnimations];
    }
    isTextFieldMoved = YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (isTextFieldMoved == YES) {
        NSTimeInterval animationDuration = 0.5f;
        CGRect frame = self.view.frame;
        frame.origin.y +=216;
        frame.size. height -=216;
        self.view.frame = frame;
        [UIView beginAnimations:@"ResizeView" context:nil];
        [UIView setAnimationDuration:animationDuration];
        self.view.frame = frame;
        [UIView commitAnimations];
        [textField resignFirstResponder];
    }
    isTextFieldMoved = NO;
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_userLogoImage_1 release];
    [_loginBackgroundView release];
    [_userAccount release];
    [_userPassword release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setUserLogoImage_1:nil];
    [self setLoginBackgroundView:nil];
    [self setUserAccount:nil];
    [self setUserPassword:nil];
    [super viewDidUnload];
}
@end
