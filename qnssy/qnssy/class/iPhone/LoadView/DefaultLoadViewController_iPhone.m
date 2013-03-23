//
//  DefaultLoadViewController.m
//  IpadcoofficeManage
//
//  Created by  on 12-1-13.
//  Copyright (c) 2012年 baosight. All rights reserved.
//

#import "DefaultLoadViewController_iPhone.h"
#import "BSRootLeftViewController_iPhone.h"

@implementation DefaultLoadViewController_iPhone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}
- (void)dealloc{
    [super dealloc];
    
}
- (void)viewWillAppear:(BOOL)animated{
    //本方法有数据获取完成执行
    [self performSelector:@selector(viewUpdate) withObject:self afterDelay:0.1];
    
    //此处检测本地是否自动登录，如果自动登录则请求服务器进行登录，否则进入登录界面
    BOOL isAutoLogin = NO;
    if (isAutoLogin) {
        //请求服务器
        
    }else{
        //加载登录界面
        
    }
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        return (interfaceOrientation == UIInterfaceOrientationPortrait ||
                interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
    }else {
        return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
                interfaceOrientation == UIInterfaceOrientationLandscapeRight);
    }
}

#pragma mark - 

- (void)viewUpdate{
    //数据
    NSMutableArray *cf = [[NSMutableArray alloc] init];
    
    NSMutableArray *arraySub0 = [[NSMutableArray alloc] init];
    [arraySub0 addObject:@"bsteellogo.png"];//选中
    [arraySub0 addObject:@"bsteellogo.png"];//未选中
    [arraySub0 addObject:@"我的资料"];//标题
    [arraySub0 addObject:@"BSMyInfoViewController_iPhone"];//类名
    
    NSMutableArray *arraySub1 = [[NSMutableArray alloc] init];
    [arraySub1 addObject:@"left_menu_01.png"];//选中
    [arraySub1 addObject:@"left_menu_01.png"];//未选中
    [arraySub1 addObject:@"推荐"];//标题
    [arraySub1 addObject:@"BSRecommendViewController_iPhone"];//类名
    
    NSMutableArray *arraySub2 = [[NSMutableArray alloc] init];
    [arraySub2 addObject:@"left_menu_02.png"];//选中
    [arraySub2 addObject:@"left_menu_02.png"];//未选中
    [arraySub2 addObject:@"消息"];//标题
    [arraySub2 addObject:@"BSMessageViewController_iPhone"];//类名
    
    NSMutableArray *arraySub3 = [[NSMutableArray alloc] init];
    [arraySub3 addObject:@"left_menu_03.png"];//选中
    [arraySub3 addObject:@"left_menu_03.png"];//未选中
    [arraySub3 addObject:@"说说"];//标题
    [arraySub3 addObject:@"BSSaysayViewController_iPhone"];//类名
    
    NSMutableArray *arraySub4 = [[NSMutableArray alloc] init];
    [arraySub4 addObject:@"left_menu_04.png"];//选中
    [arraySub4 addObject:@"left_menu_04.png"];//未选中
    [arraySub4 addObject:@"搜索"];//标题
    [arraySub4 addObject:@"BSSearchViewController_iPhone"];//类名
    
    NSMutableArray *arraySub5 = [[NSMutableArray alloc] init];
    [arraySub5 addObject:@"left_menu_05.png"];//选中
    [arraySub5 addObject:@"left_menu_05.png"];//未选中
    [arraySub5 addObject:@"购买"];//标题
    [arraySub5 addObject:@"BSBuyViewController_iPhone"];//类名
    
    NSMutableArray *arraySub6 = [[NSMutableArray alloc] init];
    [arraySub6 addObject:@"left_menu_08.png"];
    [arraySub6 addObject:@"left_menu_08.png"];
    [arraySub6 addObject:@"天天相亲"];//标题
    [arraySub6 addObject:@"BSEveryDayMiaiViewController_iPhone"];
    
    NSMutableArray *arraySub7 = [[NSMutableArray alloc] init];
    [arraySub7 addObject:@"left_menu_LSDD.png"];
    [arraySub7 addObject:@"left_menu_LSDD.png"];
    [arraySub7 addObject:@"红娘服务"];//标题
    [arraySub7 addObject:@"BSMatchmakerViewController_iPhone"];
    
//    NSMutableArray *arraySub8 = [[NSMutableArray alloc] init];
//    [arraySub8 addObject:@"left_menu_06.png"];//选中
//    [arraySub8 addObject:@"left_menu_06.png"];//未选中
//    [arraySub8 addObject:@""];//标题
//    [arraySub8 addObject:@"CBGViewController_iPad"];//类名
//    
//    NSMutableArray *arraySub9 = [[NSMutableArray alloc] init];
//    [arraySub9 addObject:@"left_menu_07.png"];//选中
//    [arraySub9 addObject:@"left_menu_07.png"];//未选中
//    [arraySub9 addObject:@"退出"];//标题
//    [arraySub9 addObject:@"ExitLoginViewController_iPad"];//类名
//    
    
    
    
    [cf addObject:arraySub0];
    [cf addObject:arraySub1];
    [cf addObject:arraySub2];
    [cf addObject:arraySub3];
    [cf addObject:arraySub4];
    [cf addObject:arraySub5];
    [cf addObject:arraySub6];
    [cf addObject:arraySub7];
//    [cf addObject:arraySub8];
//    [cf addObject:arraySub9];
    
    [arraySub0 release];
    [arraySub1 release];
    [arraySub2 release];
    [arraySub3 release];
    [arraySub4 release];
    [arraySub5 release];
    [arraySub6 release];
    [arraySub7 release];
//    [arraySub8 release];
//    [arraySub9 release];
    
    //-------------------------------------------
    [self loadRootViewConfig:cf];
    [cf release];
}

- (void)loadRootViewConfig:(NSMutableArray *)cf{
    
    //遍历一级目录
    NSMutableArray *arrControllers = [[[NSMutableArray alloc] init] autorelease];
//    NSMutableArray *normalImages = [[[NSMutableArray alloc] init] autorelease];
//    NSMutableArray *selectImages = [[[NSMutableArray alloc] init] autorelease];
    
    NSMutableArray *vcNameArrays = [[[NSMutableArray alloc] init] autorelease];
    
    for (int i = 0; i<[cf count]; i++) {
        NSArray *array = [cf objectAtIndex:i];
        
        NSString *vcString = [array objectAtIndex:3];
        Class clazz = NSClassFromString(vcString);
        
        UIViewController *vc = [[[clazz alloc] initWithNibName:vcString bundle:nil] autorelease];
        
        UINavigationController *nav = [[[UINavigationController alloc] initWithRootViewController:vc] autorelease];
        
        NSString *title = [array objectAtIndex:2];
        
        [vcNameArrays addObject:title];
        
//        vc.title = title;
        
        
        NSString *normalImageName = [array objectAtIndex:1];
        NSString *selectImageName = [array objectAtIndex:0];
        
        UIImage *normalImage;
        UIImage *selectImage;
        
        normalImage = [UIImage imageNamed:normalImageName];
        selectImage = [UIImage imageNamed:selectImageName];

//        [normalImages addObject:normalImage];
//        [selectImages addObject:selectImage];
        
        [arrControllers addObject:nav];
        
    }
	
    //----------------------------------

	CATransition *transition = [CATransition animation];
	
    transition.duration = 2;
	
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	
    transition.type =   kCATransitionFade;
	
    transition.subtype = kCATransitionFromTop;
 
    
//    BSRootLeftViewController_iPhone *leftvc  =
//    [[BSRootLeftViewController_iPhone alloc] initWithNibName:@"BSRootLeftViewController_iPhone"
//                                                         vcs:arrControllers
//                                                      vcName:vcNameArrays];
//    
//    app.leftvc = leftvc;
    
//    [leftvc release];

    PPRevealSideViewController * revealSideViewController = [[PPRevealSideViewController alloc] initWithRootViewController:[arrControllers objectAtIndex:0]];

    app.window.rootViewController = revealSideViewController;
    
    [revealSideViewController release];
    
	[app.window.layer addAnimation:transition forKey:nil];
    
    // Do any additional setup after loading the view.
//    BSUserLoginViewController *userLoginView = [[BSUserLoginViewController alloc] initWithNibName:@"BSUserLoginViewController" bundle:nil];
//    [self.view addSubview:userLoginView.view];

}

//兼容ios6
- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}


@end
