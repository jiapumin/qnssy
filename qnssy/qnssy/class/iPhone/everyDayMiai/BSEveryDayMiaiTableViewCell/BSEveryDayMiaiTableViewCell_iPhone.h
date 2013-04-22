//
//  MyTableViewCell.h
//  ContactDocFilesManage
//
//  Created by Sophie Sun on 12-4-26.
//  Copyright (c) 2012年 baosight. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSEveryDayMiaiTableViewCell_iPhone : UITableViewCell

@property (retain, nonatomic) NSDictionary *userVo;

@property (retain, nonatomic) IBOutlet UIImageView *leftImageView;
@property (retain, nonatomic) IBOutlet UILabel *title;
@property (retain, nonatomic) IBOutlet UILabel *time;
@property (retain, nonatomic) IBOutlet UILabel *place;
@property (retain, nonatomic) IBOutlet UILabel *status;
@property (retain, nonatomic) IBOutlet UILabel *personNum;

- (IBAction)clickBaoMingButton:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *baoMingButton;

- (void)reloadData:(NSDictionary *)dic;

@end
