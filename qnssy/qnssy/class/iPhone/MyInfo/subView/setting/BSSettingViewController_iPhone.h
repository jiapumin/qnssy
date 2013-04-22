//
//  BSSettingViewController_iPhone.h
//  qnssy
//
//  Created by jpm on 13-3-26.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSSettingViewController_iPhone : UIViewController<UIAlertViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView *myTableView;

@property (retain, nonatomic) NSArray *textNameArrays;
@property (retain, nonatomic) NSArray *noSelectedLeftImageArrays;
@property (retain, nonatomic) NSArray *selectedLeftImageArrays;

@end
