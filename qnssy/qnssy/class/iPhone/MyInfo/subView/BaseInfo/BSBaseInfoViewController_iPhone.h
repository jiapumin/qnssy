//
//  BSMyAttentionViewController_iPhone.h
//  qnssy
//
//  Created by jpm on 13-4-14.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSSuperCentreViewController_iPhone.h"
#import "WorkAreaPickerViewDelegate.h"

@interface BSBaseInfoViewController_iPhone : BSSuperCentreViewController_iPhone<UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UITableView *myTableView;


@property (retain, nonatomic) NSMutableDictionary *myBaseInfo;

@property (retain, nonatomic) NSMutableArray *myBaseInfoKey;

@property (retain, nonatomic) NSMutableDictionary *commitData;

@property (retain, nonatomic) UITextField *usernameTextField;

@property (retain, nonatomic) WorkAreaPickerViewDelegate *tempWorkArea1;

@property (retain, nonatomic) WorkAreaPickerViewDelegate *tempWorkArea2;

@end
