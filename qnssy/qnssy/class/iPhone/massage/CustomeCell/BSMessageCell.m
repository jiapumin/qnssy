//
//  BSMessageCell.m
//  qnssy
//
//  Created by juchen on 13-5-8.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSMessageCell.h"

@implementation BSMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _isRead = NO;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void) setImageView {
    if (!_isRead) {
        _messageImageView.image = [UIImage imageNamed:@"9邮件为空时显示图片@2x.png"];
    } else {
        _messageImageView.image = [UIImage imageNamed:@"10未读邮件ico@2x.png"];
    }
}

- (void)dealloc {
    [_messageTitleLabel release];
    [_messageDetailsLabel release];
    [_messageImageView release];
    [super dealloc];
}
@end
