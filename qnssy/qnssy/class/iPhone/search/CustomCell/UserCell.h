//
//  UserCell.h
//  qnssy
//
//  Created by juchen on 13-5-2.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIImageView *userImageView;
@property (retain, nonatomic) IBOutlet UILabel *userNameLabel;
@property (retain, nonatomic) IBOutlet UILabel *ageAndHeightLabel;
@property (retain, nonatomic) IBOutlet UILabel *userOtherInfoLabel;
- (IBAction)talkWithMeAction:(id)sender;

@end
