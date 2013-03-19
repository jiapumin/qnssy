//
//  BSOtherCell.m
//  qnssy
//
//  Created by juchen on 13-3-19.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSOtherCell.h"

@implementation BSOtherCell

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
        
        [backgroundView release];
        
        self.lableName = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 44)];
        self.lableName.backgroundColor = [UIColor clearColor];
        self.lableName.text = @"性别";
        UIColor *labelColor = [UIColor colorWithRed:0.333 green:0.333 blue:0.333 alpha:1];
        self.lableName.textColor = labelColor;
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        self.detailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(backgroundView.frame.size.width-65, 0, 80, 44)];
        self.detailsLabel.backgroundColor = [UIColor clearColor];
        self.detailsLabel.text = @"请选择";
        self.detailsLabel.textColor = [UIColor colorWithRed:0.803 green:0.113 blue:0.364 alpha:1];
        [self.contentView addSubview:self.lableName];
        [self.contentView addSubview:self.detailsLabel];
        [self.detailsLabel release];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    selected = NO;
    [super setSelected:selected animated:animated];
}

- (void) setFrame:(CGRect)frame {
    frame.origin.x = 10;
    frame.origin.y += 10;
    frame.size.width = 300;
    frame.size.height = 44;
    [super setFrame:frame];
}

- (void) dealloc {
    [_lableName release];
    [_detailsLabel release];
    [super dealloc];
}

@end
