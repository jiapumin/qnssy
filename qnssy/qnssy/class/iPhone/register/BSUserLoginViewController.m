//
//  BSUserLoginViewController.m
//  qnssy
//
//  Created by juchen on 13-3-15.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSUserLoginViewController.h"

@interface BSUserLoginViewController ()

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_userLogoImage_1 release];
    [_loginBackgroundView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setUserLogoImage_1:nil];
    [self setLoginBackgroundView:nil];
    [super viewDidUnload];
}
@end
