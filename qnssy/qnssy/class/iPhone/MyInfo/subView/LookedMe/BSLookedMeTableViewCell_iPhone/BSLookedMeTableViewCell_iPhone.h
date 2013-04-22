//
//  MyTableViewCell.h
//  ContactDocFilesManage
//
//  Created by Sophie Sun on 12-4-26.
//  Copyright (c) 2012年 baosight. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSLookedMeTableViewCell_iPhone : UITableViewCell

@property (retain, nonatomic) NSDictionary *userVo;

@property (retain, nonatomic) IBOutlet UIImageView *leftImageView;
@property (retain, nonatomic) IBOutlet UILabel *nickname;
@property (retain, nonatomic) IBOutlet UILabel *myInfo;
@property (retain, nonatomic) IBOutlet UILabel *myInfo2;

- (IBAction)clickAskMeButton:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *askMeButton;

- (void)reloadData:(NSDictionary *)dic;

@end
