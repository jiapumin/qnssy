//
//  BSUserDetailInfoTableViewCell1_iPhone.h
//  qnssy
//
//  Created by jpm on 13-4-19.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSUserDetailInfoTableViewCell2_iPhone : UITableViewCell

@property (retain, nonatomic) NSDictionary *userVo;

@property (retain, nonatomic) NSArray *imageList;
@property (retain, nonatomic) IBOutlet UIScrollView *myScrollView;

- (void)reloadData:(NSDictionary *)dic;

@end
