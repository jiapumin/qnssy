//
//  BSUserBasicInfoViewController.h
//  qnssy
//
//  Created by juchen on 13-3-17.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSOtherCell.h"

@interface BSUserBasicInfoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@end
