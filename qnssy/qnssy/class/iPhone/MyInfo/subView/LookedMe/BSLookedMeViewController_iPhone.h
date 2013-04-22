//
//  BSMyAttentionViewController_iPhone.h
//  qnssy
//
//  Created by jpm on 13-4-14.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSSuperCentreViewController_iPhone.h"

@interface BSLookedMeViewController_iPhone : BSSuperCentreViewController_iPhone<UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView *myTableView;

@property (retain, nonatomic) NSMutableArray *dataArray;

@end
