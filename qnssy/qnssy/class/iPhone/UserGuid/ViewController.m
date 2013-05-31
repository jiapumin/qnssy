//
//  ViewController.m
//  GuideViewController
//
//  Created by 发兵 杨 on 12-9-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize gotoMainViewBtn = _gotoMainViewBtn;

//@synthesize imageView;
//@synthesize left = _left;
//@synthesize right = _right;
@synthesize pageScroll;
@synthesize pageControl;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    pageControl.numberOfPages = 5;
    pageControl.currentPage = 0;
    pageScroll.delegate = self;
    
    pageScroll.contentSize = CGSizeMake(self.view.frame.size.width * 5, self.view.frame.size.height);
    
    
}

- (void)viewDidUnload
{
    
    [self setGotoMainViewBtn:nil];
    [super viewDidUnload];
}

-(void)dealloc
{   
    [_gotoMainViewBtn release];
//    [_defaultViewController release];
    [_imageView release];
    [_left release];
    [_right release];
    [super dealloc];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}




-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    if ([animationID isEqualToString:@"split"] && finished) {
        
        [self.left removeFromSuperview];
        [self.right removeFromSuperview];
//        app.viewController = [[[DefaultLoadViewController_iPhone alloc] initWithNibName:@"DefaultLoadViewController_iPhone" bundle:nil] autorelease];
        app.window.rootViewController =  app.loginNav;

//        [self presentModalViewController:self.defaultViewController animated:YES];
    }
}

- (IBAction)gotoMainView:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    [self.gotoMainViewBtn setHidden:YES];
    NSArray *array = [UIImage splitImageIntoTwoParts:self.imageView.image];
    self.left = [[[UIImageView alloc] initWithImage:[array objectAtIndex:0]] autorelease];
    self.right = [[[UIImageView alloc] initWithImage:[array objectAtIndex:1]] autorelease];
    [self.view addSubview:self.left];
    [self.view addSubview:self.right];
    [self.pageScroll setHidden:YES];
    [self.pageControl setHidden:YES];
    self.left.transform = CGAffineTransformIdentity;
    self.right.transform = CGAffineTransformIdentity;
    
    [UIView beginAnimations:@"split" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    self.left.transform = CGAffineTransformMakeTranslation(-160 ,0);
    self.right.transform = CGAffineTransformMakeTranslation(160 ,0);   
    [UIView commitAnimations];
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{	
    CGFloat pageWidth = self.view.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
}

@end
