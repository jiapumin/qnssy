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

    //判断当前页面是否是根目录
    if (![[self.navigationController.viewControllers objectAtIndex:0]  isEqual:self]) {
        UIBarButtonItem *leftBarButtonItem2 =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply
                                                      target:self
                                                      action:@selector(popViewContoller)];
        
        [itemArray addObject:leftBarButtonItem2];
        
        [leftBarButtonItem2 release];
    }else{
        UIBarButtonItem *leftBarButtonItem1 =
        [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"左栏_button_03"]
                                         style:UIBarButtonItemStyleBordered
                                        target:self
                                        action:@selector(showLeft:)];
        leftBarButtonItem1.width = 25;
        [itemArray addObject:leftBarButtonItem1];
        
        [leftBarButtonItem1 release];
        //默认偏移
        [self showLeft:nil];
    }

    [self.navigationItem setLeftBarButtonItems:itemArray animated:YES];
    [itemArray release];
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
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
