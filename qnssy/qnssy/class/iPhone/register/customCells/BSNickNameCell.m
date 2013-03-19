//
//  BSNickNameCell.m
//  qnssy
//
//  Created by juchen on 13-3-17.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSNickNameCell.h"

@implementation BSNickNameCell

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
        
        self.nickName = [[UITextField alloc] initWithFrame:CGRectMake(80, 2, 230, 40)];
        self.nickName.borderStyle = UITextBorderStyleNone;
        self.nickName.placeholder = @"请输入昵称";
        self.nickName.keyboardType = UIKeyboardTypeDefault;
        self.nickName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.nickName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        UILabel *nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 50, 40)];
        nickNameLabel.backgroundColor = [UIColor clearColor];
        nickNameLabel.text = @"昵称";
        UIColor *labelColor = [UIColor colorWithRed:0.333 green:0.333 blue:0.333 alpha:1];
        nickNameLabel.textColor = labelColor;
        [self.contentView addSubview:nickNameLabel];
        [self.contentView addSubview:self.nickName];
        self.selected = NO;
        [nickNameLabel release];
        [self.nickName release];
    }
    return self;
}

- (void) setFrame:(CGRect)frame {
    frame.origin.x = 10;
    frame.origin.y = 10;
    frame.size.width = 300;
    frame.size.height = 44;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    selected = NO;
    [super setSelected:selected animated:animated];
}

- (void) dealloc {
    [_nickName release];
    [_nickNameLabel release];
    [super dealloc];
}

@end
