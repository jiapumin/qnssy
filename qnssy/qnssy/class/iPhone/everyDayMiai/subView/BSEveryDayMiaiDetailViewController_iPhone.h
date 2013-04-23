//
//  BSEveryDayMiaiDetailViewController_iPhone.h
//  qnssy
//
//  Created by jpm on 13-4-23.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BSSuperCentreViewController_iPhone.h"

@interface BSEveryDayMiaiDetailViewController_iPhone : BSSuperCentreViewController_iPhone<UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView *myTableView;

@property (retain, nonatomic) NSDictionary *topDataDic;

@property (nonatomic, retain) NSDictionary *dataDic;

@end
