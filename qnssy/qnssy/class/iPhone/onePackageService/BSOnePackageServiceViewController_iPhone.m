//
//  BSOnePackageServiceViewController_iPhone.m
//  qnssy
//
//  Created by jpm on 13-3-23.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSOnePackageServiceViewController_iPhone.h"

@interface BSOnePackageServiceViewController_iPhone ()

@end

@implementation BSOnePackageServiceViewController_iPhone

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
    [self setupServiceImage];
}

-(void) setupServiceImage {
    UIImageView *imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 280, 150)];
    imageview1.image = [UIImage imageNamed:@"一站式服务1.png"];
    [self.view addSubview:imageview1];
    CGRect frame = imageview1.frame;
    frame.origin.y = frame.size.height + 40;
    UIImageView *imageview2 = [[UIImageView alloc] initWithFrame:frame];
    imageview2.image = [UIImage imageNamed:@"一站式服务2.png"];
    [self.view addSubview:imageview2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
