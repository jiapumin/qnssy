//
//  BSMessageCell.h
//  qnssy
//
//  Created by juchen on 13-5-8.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSMessageCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIImageView *messageImageView;
@property (retain, nonatomic) IBOutlet UILabel *messageTitleLabel;
@property (retain, nonatomic) IBOutlet UILabel *messageDetailsLabel;
@property (assign, nonatomic) BOOL isRead;

-(void) setImageView;

@end
