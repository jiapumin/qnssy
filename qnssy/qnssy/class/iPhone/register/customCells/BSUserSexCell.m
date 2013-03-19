//
//  BSUserSexCell.m
//  qnssy
//
//  Created by juchen on 13-3-17.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSUserSexCell.h"

@implementation BSUserSexCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 280, 44)];
        [backgroundView setBackgroundColor:[UIColor whiteColor]];
        
        CALayer *layer = backgroundView.layer;
        layer.cornerRadius = 8.0;
        UIColor *color = [UIColor colorWithRed:0.603 green:0.603 blue:0.603 alpha:1];
        CGColorRef colorref = [color CGColor];
        layer.borderColor = colorref;
        layer.borderWidth = 1.0;
        
        [self setBackgroundView:backgroundView];
        
        UILabel *sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 50, 44)];
        sexLabel.backgroundColor = [UIColor clearColor];
        sexLabel.text = @"性别";
        UIColor *labelColor = [UIColor colorWithRed:0.333 green:0.333 blue:0.333 alpha:1];
        sexLabel.textColor = labelColor;
        
        NSArray *segmentedArray = [[NSArray alloc] initWithObjects:@"男",@"女", nil];
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
        segmentedControl.selectedSegmentIndex = 0;
        segmentedControl.frame = CGRectMake(backgroundView.frame.size.width - 70, 5, 80, 34);
        
        [self.contentView addSubview:sexLabel];
        [self.contentView addSubview:segmentedControl];
        [sexLabel release];
    }
    return self;
}

- (void) setFrame:(CGRect)frame {
    frame.origin.x = 10;
    frame.origin.y += 10;
    frame.size.width = 300;
    frame.size.height = 44;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    selected = NO;
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
