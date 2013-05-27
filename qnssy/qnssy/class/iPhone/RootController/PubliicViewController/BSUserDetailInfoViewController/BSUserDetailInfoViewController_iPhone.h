//
//  BSUserDetailInfoViewController.h
//  qnssy
//
//  Created by jpm on 13-3-31.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSSuperCentreViewController_iPhone.h"

@interface BSUserDetailInfoViewController_iPhone : BSSuperCentreViewController_iPhone<UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView *myTableView;

@property (retain,nonatomic) NSDictionary *userInfoDic;

@property (retain, nonatomic) NSString *userId;

@end
