//
//  BSRootLeftViewController_iPhone.h
//  BSChartNet
//
//  Created by jpm on 13-2-22.
//  Copyright (c) 2013年 baosight. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSRootLeftViewController_iPhone : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView *leftTableView;

@property (retain, nonatomic) NSMutableArray *vcArrays;

@property (retain, nonatomic) NSMutableArray *vcNameArrays;

@property (retain, nonatomic) IBOutlet UINavigationBar *navBar;
@property (retain, nonatomic) IBOutlet UINavigationItem *navItem;

@property (retain, nonatomic) IBOutlet UIToolbar *toolBar;


- (id)initWithNibName:(NSString *)nibNameOrNil vcs:(NSMutableArray *)vcs vcName:(NSMutableArray *)vcName;

@end
