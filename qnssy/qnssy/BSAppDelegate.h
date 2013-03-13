//
//  BSAppDelegate.h
//  qnssy
//
//  Created by jpm on 13-3-12.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSRootLeftViewController_iPhone;

@interface BSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) BSViewController *viewController;

@property (retain, nonatomic) BSRootLeftViewController_iPhone *leftvc;

@end
