//
//  BSApplyViewController_iPhone.h
//  qnssy
//
//  Created by jpm on 13-4-23.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSSuperCentreViewController_iPhone.h"
#import "MiaiApplyRequestVo.h"
#import "MiaiApplyResponseVo.h"

@interface BSApplyViewController_iPhone : BSSuperCentreViewController_iPhone
@property (retain, nonatomic) IBOutlet UITableView *myTableView;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UITextField *phoneText;
@property (retain, nonatomic) IBOutlet UITextView *contentText;
@property (retain, nonatomic) NSString *datingid;


@end
