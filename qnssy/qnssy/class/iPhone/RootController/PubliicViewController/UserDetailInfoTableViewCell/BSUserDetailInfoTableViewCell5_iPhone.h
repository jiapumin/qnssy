//
//  BSUserDetailInfoTableViewCell1_iPhone.h
//  qnssy
//
//  Created by jpm on 13-4-19.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSUserDetailInfoTableViewCell5_iPhone : UITableViewCell
@property (retain, nonatomic) IBOutlet UIImageView *leftImageView;
@property (retain, nonatomic) IBOutlet UILabel *myInfoLabel;
@property (retain, nonatomic) IBOutlet UILabel *locationLabel;

@property (retain, nonatomic) NSDictionary *userVo;

- (void)reloadData:(NSDictionary *)dic;

@end
