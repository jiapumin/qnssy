//
//  BSGreetingsViewController.h
//  qnssy
//
//  Created by jpm on 13-5-27.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSSuperCentreViewController_iPhone.h"

@interface BSGreetingsViewController_iPhone : BSSuperCentreViewController_iPhone<UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView *myTableView;
@property (retain, nonatomic) NSString *userid;
@property (retain, nonatomic) NSArray *dataArray;

@property (retain, nonatomic) NSString *contentText;
- (id)initWithNibName:(NSString *)nibNameOrNil userid:(NSString *)userid;


@end
