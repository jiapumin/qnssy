//
//  LabelCell.m
//  qnssy
//
//  Created by juchen on 13-4-30.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "LabelCell.h"

@implementation LabelCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UILabel *tempLeftLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 11, 97, 21)];
        self.leftLabel = tempLeftLabel;
        [tempLeftLabel release];
        UILabel *tempRightLabel = [[UILabel alloc] initWithFrame:CGRectMake(125, 11, 130, 21)];
        self.rightLabel = tempRightLabel;
        [tempRightLabel release];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_leftLabel release];
    [_rightLabel release];
    [super dealloc];
}
@end
