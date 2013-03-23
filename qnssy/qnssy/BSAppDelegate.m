//
//  BSAppDelegate.m
//  qnssy
//
//  Created by jpm on 13-3-12.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSAppDelegate.h"
#import "BSRootLeftViewController_iPhone.h"
#import "DefaultLoadViewController_iPhone.h"
#import "ViewController.h"
#import "BSUserLoginViewController.h"

@implementation BSAppDelegate

- (void)dealloc
{
    [_revealSideViewController release];
    [_window release];
    [_leftvc release];
    [_viewController release];
    [super dealloc];
    //测试哦测试
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    //加载界面
    [self viewUpdate];

    //增加标识，用于判断是否是第一次启动应用...
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
    }

    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        ViewController *appStartController = [[ViewController alloc] init];
        self.window.rootViewController = appStartController;
        [appStartController release];
    }else {
//        self.viewController = [[[DefaultLoadViewController_iPhone alloc] initWithNibName:@"DefaultLoadViewController_iPhone" bundle:nil] autorelease];
        self.userLoginView = [[[BSUserLoginViewController alloc] initWithNibName:@"BSUserLoginViewController" bundle:nil] autorelease];
        
        UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:self.userLoginView];
        

        
        self.window.rootViewController = loginNav;
        
    }
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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
    
    
    BSRootLeftViewController_iPhone *leftvc  =
    [[BSRootLeftViewController_iPhone alloc] initWithNibName:@"BSRootLeftViewController_iPhone"
                                                         vcs:arrControllers
                                                      vcName:vcNameArrays];
    
    app.leftvc = leftvc;
    
    [leftvc release];
    
    self.revealSideViewController = [[[PPRevealSideViewController alloc] initWithRootViewController:[arrControllers objectAtIndex:0]] autorelease];
    
    
}
@end
