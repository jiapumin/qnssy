//
//  BSApplyViewController_iPhone.h
//  qnssy
//
//  Created by jpm on 13-4-23.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSSuperCentreViewController_iPhone.h"
#import "SendMailRequestVo.h"
#import "SendMailResponseVo.h"

@interface BSSendMailViewController_iPhone : BSSuperCentreViewController_iPhone<UITextViewDelegate>

@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UITextView *contentText;
@property (retain, nonatomic) NSString *userid;

@property (retain, nonatomic) NSString *username;

@property (retain, nonatomic) IBOutlet UILabel *hideLabel;
- (IBAction)clickSubmitButton:(id)sender;

- (id)initWithNibName:(NSString *)nibNameOrNil userid:(NSString *)userid username:(NSString *)username;

@end
