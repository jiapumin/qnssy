//
//  BSRecommendImageViewController_iPhone.m
//  qnssy
//
//  Created by jpm on 13-3-31.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSRecommendImageViewController_iPhone.h"

@interface BSRecommendImageViewController_iPhone ()

@end

@implementation BSRecommendImageViewController_iPhone

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

- (void)dealloc {
    [_nickNameLabel release];
    [_spaceLabel release];
    [_neixindubaiLabel release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setNickNameLabel:nil];
    [self setSpaceLabel:nil];
    [self setNeixindubaiLabel:nil];
    [super viewDidUnload];
}
@end
