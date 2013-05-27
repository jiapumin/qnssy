//
//  BSUserDetailInfoTableViewCell1_iPhone.h
//  qnssy
//
//  Created by jpm on 13-4-19.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSUserDetailInfoViewController_iPhone.h"

@interface BSUserDetailInfoTableViewCell3_iPhone : UITableViewCell

@property (retain, nonatomic) NSDictionary *userVo;
@property (assign, nonatomic) BSUserDetailInfoViewController_iPhone *delegate;


- (IBAction)clickGZButton:(id)sender;
- (IBAction)clickXXButton:(id)sender;
- (IBAction)clickTJButton:(id)sender;
- (IBAction)clickWHButton:(id)sender;

@end
