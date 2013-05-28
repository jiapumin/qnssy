//
//  BSMessageViewController_iPhone.h
//  qnssy
//  我的邮件
//  Created by jpm on 13-3-12.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSSuperCentreViewController_iPhone.h"

@interface BSMessageViewController_iPhone : BSSuperCentreViewController_iPhone

@property (retain, nonatomic) IBOutlet UISegmentedControl *topSegmented;

@property (retain, nonatomic) NSMutableArray *mySendedArray;
@property (retain, nonatomic) NSMutableArray *unReadArray;
@property (retain, nonatomic) NSMutableArray *myMailArray;
@property (retain, nonatomic) NSMutableArray *sysMailArray;

@property (retain, nonatomic) IBOutlet UITableView *myTableView;

- (IBAction)clickTopSegmented:(id)sender;
@end
