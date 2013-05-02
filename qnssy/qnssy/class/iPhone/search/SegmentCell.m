//
//  SegmentCell.m
//  qnssy
//
//  Created by juchen on 13-4-30.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "SegmentCell.h"

@implementation SegmentCell

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

- (IBAction)changeSexAction:(id)sender {
}
@end
