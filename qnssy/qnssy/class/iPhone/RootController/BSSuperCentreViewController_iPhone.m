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
    [_titleLabel release];
    [super dealloc];
}
- (void)viewDidUnload{
    [self setTitleLabel:nil];
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
    CGRect btnFrame = CGRectMake(5.0, 7.0, 40.0, 30.0);
    topLeftButton.frame =btnFrame;
    //判断当前页面是否是根目录
    if ([[self.navigationController.viewControllers objectAtIndex:0]  isEqual:self]) {
        //设置根目录的侧滑图片和方法

        [topLeftButton setImage:[UIImage imageNamed:@"左栏_button_03"]
                       forState:UIControlStateNormal];
        
        [topLeftButton addTarget:self
                          action:@selector(showLeft:)
                forControlEvents:UIControlEventTouchUpInside];
        
        //默认偏移
        [self showLeft:nil];
    }else{
        //设置返回按钮图片和方法
        [topLeftButton setImage:[UIImage imageNamed:@"左栏_button_03"]
                       forState:UIControlStateNormal];
        
        [topLeftButton addTarget:self
                          action:@selector(popViewContoller:)
                forControlEvents:UIControlEventTouchUpInside];
        
        
        UIBarButtonItem * topLeftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:topLeftButton];
        
        [itemArray addObject:topLeftBarButtonItem];
        
        [topLeftBarButtonItem release];

    }
    UIBarButtonItem * topLeftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:topLeftButton];
    [itemArray addObject:topLeftBarButtonItem];
    [topLeftBarButtonItem release];
    
    [self.navigationItem setLeftBarButtonItems:itemArray animated:YES];
    [itemArray release];
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    //设置背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbkimg.png"] forBarMetrics:UIBarMetricsDefault];
   
    //自定义头部标题
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 33)];
    
    titleView.backgroundColor = [UIColor clearColor];
    
    self.navigationItem.titleView = titleView;
    
    [titleView release];
    
    self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 7, 150, 21)] autorelease];
    
    [self.navigationItem.titleView addSubview:self.titleLabel];
    
    self.titleLabel.backgroundColor = [UIColor clearColor];
    
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    
    self.titleLabel.textColor = [UIColor whiteColor];
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
	// Do any additional setup after loading the view.
    BSUserLoginViewController *userLoginView = [[BSUserLoginViewController alloc] initWithNibName:@"BSUserLoginViewController" bundle:nil];
    [self.view addSubview:userLoginView.view];
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
