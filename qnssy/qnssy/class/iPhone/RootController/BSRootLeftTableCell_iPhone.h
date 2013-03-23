//
//  MyTableViewCell.h
//  ContactDocFilesManage
//
//  Created by Sophie Sun on 12-4-26.
//  Copyright (c) 2012年 baosight. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSRootLeftTableCell_iPhone : UITableViewCell

@property (retain, nonatomic) IBOutlet UIImageView *leftImage;
@property (retain, nonatomic) IBOutlet UILabel *menuLabel;
@property (retain, nonatomic) IBOutlet UIImageView *bgImage;

@property (retain, nonatomic) NSString *selectedLeftImageName;
@property (retain, nonatomic) NSString *noSelectedLeftImageName;

@property (retain, nonatomic) NSString *selectedBgImageName;
@property (retain, nonatomic) NSString *noSelectedBgImageName;


@end
