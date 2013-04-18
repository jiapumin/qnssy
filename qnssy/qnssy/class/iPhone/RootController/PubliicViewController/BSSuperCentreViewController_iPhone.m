//
//  BSSuperCentreViewController_iPhone.m
//  BSChartNet
//
//  Created by jpm on 13-3-4.
//  Copyright (c) 2013年 baosight. All rights reserved.
//

#import "BSSuperCentreViewController_iPhone.h"
#import "BSUserLoginViewController.h"

@interface BSSuperCentreViewController_iPhone ()

@end

@implementation BSSuperCentreViewController_iPhone


- (void)dealloc {
//    [_titleLabel release];
    [super dealloc];
}
- (void)viewDidUnload{
//    [self setTitleLabel:nil];
    [super viewDidUnload];
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSMutableArray *itemArray = [[NSMutableArray alloc] init];
    UIButton *topLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //按钮大小
    CGRect btnFrame = CGRectMake(0.0, 4.0, 29.0, 25.0);
    topLeftButton.frame =btnFrame;
    //判断当前页面是否是根目录
    if ([[self.navigationController.viewControllers objectAtIndex:0]  isEqual:self]) {
        //设置根目录的侧滑图片和方法

        [topLeftButton setImage:[UIImage imageNamed:@"5菜单列表图片"]
                       forState:UIControlStateNormal];
        
        [topLeftButton addTarget:self
                          action:@selector(showLeft:)
                forControlEvents:UIControlEventTouchUpInside];
        
        //默认偏移
        [self showLeft:nil];
    }else{
        //设置返回按钮图片和方法
        [topLeftButton setImage:[UIImage imageNamed:@"2向左返回箭头"]
                       forState:UIControlStateNormal];
        
        [topLeftButton addTarget:self
                          action:@selector(popViewContoller)
                forControlEvents:UIControlEventTouchUpInside];

    }
    UIBarButtonItem * topLeftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:topLeftButton];
    [itemArray addObject:topLeftBarButtonItem];
    [topLeftBarButtonItem release];
    
    [self.navigationItem setLeftBarButtonItems:itemArray animated:YES];
    [itemArray release];
    
    //设置背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"2顶部条状背景"] forBarMetrics:UIBarMetricsDefault];
    
//    //自定义头部标题
//    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 220, 33)];
//    
//    titleView.backgroundColor = [UIColor clearColor];
//    
//    self.navigationItem.titleView = titleView;
//    
//    [titleView release];
//    
//    self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220, 33)] autorelease];
//    
//    [self.navigationItem.titleView addSubview:self.titleLabel];
//    
//    self.titleLabel.backgroundColor = [UIColor clearColor];
//    
//    self.titleLabel.font = [UIFont systemFontOfSize:16];
//    
//    self.titleLabel.textColor = [UIColor whiteColor];
//    
//    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.view.backgroundColor = publicColor;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)showLeft:(id)sender
{
    [self.revealSideViewController pushViewController:(UIViewController *)app.leftvc onDirection:PPRevealSideDirectionLeft withOffset:60.f animated:YES];
}
- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
 
}
#pragma mark - pop
- (void)popViewContoller{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - push
- (void)pushViewContoller:(UIViewController *)vc{
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
