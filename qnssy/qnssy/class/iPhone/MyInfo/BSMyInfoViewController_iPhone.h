//
//  BSMyInfoViewController_iPhone.h
//  qnssy
//
//  Created by jpm on 13-3-12.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSSuperCentreViewController_iPhone.h"

@interface BSMyInfoViewController_iPhone : BSSuperCentreViewController_iPhone<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
//@property (retain, nonatomic) IBOutlet UIImageView *testImgeView;
//@property (retain, nonatomic) IBOutlet UIImageView *headImage;
@property (retain, nonatomic) IBOutlet UIButton *avatarImgButton;
@property (retain, nonatomic) IBOutlet UILabel *nickname;
@property (retain, nonatomic) IBOutlet UILabel *myInfo;
@property (retain, nonatomic) IBOutlet UITableView *contextTableView;

@property (retain, nonatomic) NSArray *textNameArrays;
@property (retain, nonatomic) NSArray *noSelectedLeftImageArrays;
@property (retain, nonatomic) NSArray *selectedLeftImageArrays;

- (IBAction)clickRegister:(id)sender;
- (IBAction)changeAvatar:(id)sender;

@end
