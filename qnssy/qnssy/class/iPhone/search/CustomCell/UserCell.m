//
//  UserCell.m
//  qnssy
//
//  Created by juchen on 13-5-2.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "UserCell.h"

@implementation UserCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_userImageView release];
    [_userNameLabel release];
    [_ageAndHeightLabel release];
    [_userOtherInfoLabel release];
    [super dealloc];
}
- (IBAction)talkWithMeAction:(id)sender {
}
@end
