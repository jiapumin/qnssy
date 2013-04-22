//
//  BSMyAttentionViewController_iPhone.h
//  qnssy
//
//  Created by jpm on 13-4-14.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSSuperCentreViewController_iPhone.h"

@interface BSBaseInfoViewController_iPhone : BSSuperCentreViewController_iPhone

@property (retain, nonatomic) IBOutlet UITableView *myTableView;


@property (retain, nonatomic) NSDictionary *myBaseInfo;

@property (retain, nonatomic) NSMutableArray *myBaseInfoKey;

@end
