//
//  BSBuyViewController_iPhone.m
//  qnssy
//
//  Created by jpm on 13-3-12.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSBuyViewController_iPhone.h"

#import "LoginRequestVo.h"
#import "LoginResponseVo.h"

#import "BSBuyInfoViewController_iPhone.h"

@interface BSBuyViewController_iPhone ()

@end

@implementation BSBuyViewController_iPhone

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

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickButton1:(id)sender {
    
    BSBuyInfoViewController_iPhone *bivc = [[BSBuyInfoViewController_iPhone alloc] initWithNibName:@"BSBuyInfoViewController_iPhone" bundle:nil];
    
    [self.navigationController pushViewController:bivc animated:YES];
    [bivc release];
}

- (IBAction)clickButton2:(id)sender {
    BSBuyInfoViewController_iPhone *bivc = [[BSBuyInfoViewController_iPhone alloc] initWithNibName:@"BSBuyInfoViewController_iPhone" bundle:nil];
    
    [self.navigationController pushViewController:bivc animated:YES];
    [bivc release];
}

- (IBAction)clickButton3:(id)sender {
    BSBuyInfoViewController_iPhone *bivc = [[BSBuyInfoViewController_iPhone alloc] initWithNibName:@"BSBuyInfoViewController_iPhone" bundle:nil];
    
    [self.navigationController pushViewController:bivc animated:YES];
    [bivc release];
}

- (IBAction)clickButton4:(id)sender {
    BSBuyInfoViewController_iPhone *bivc = [[BSBuyInfoViewController_iPhone alloc] initWithNibName:@"BSBuyInfoViewController_iPhone" bundle:nil];
    
    [self.navigationController pushViewController:bivc animated:YES];
    [bivc release];
}

- (IBAction)clickButton5:(id)sender {
    BSBuyInfoViewController_iPhone *bivc = [[BSBuyInfoViewController_iPhone alloc] initWithNibName:@"BSBuyInfoViewController_iPhone" bundle:nil];
    
    [self.navigationController pushViewController:bivc animated:YES];
    [bivc release];
}
@end
