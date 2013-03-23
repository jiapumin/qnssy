//
//  ViewController.h
//  GuideViewController
//
//  Created by 发兵 杨 on 12-9-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+SplitImageIntoTwoParts.h"
#import "DefaultLoadViewController_iPhone.h"
@interface ViewController : UIViewController<UIScrollViewDelegate>

//@property (retain, nonatomic) DefaultLoadViewController_iPhone *defaultViewController;
@property (nonatomic,retain) IBOutlet UIImageView *imageView;
@property (nonatomic,retain) UIImageView *left;
@property (nonatomic,retain) UIImageView *right;

@property (retain, nonatomic) IBOutlet UIScrollView *pageScroll;
@property (retain, nonatomic) IBOutlet UIPageControl *pageControl;

- (IBAction)gotoMainView:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *gotoMainViewBtn;

@end
