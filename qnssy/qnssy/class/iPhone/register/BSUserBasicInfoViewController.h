//
//  BSUserBasicInfoViewController.h
//  qnssy
//
//  Created by juchen on 13-5-23.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "WorkAreaPickerViewDelegate.h"

@class TPKeyboardAvoidingScrollView;

@interface BSUserBasicInfoViewController : UIViewController <UIActionSheetDelegate, UIScrollViewDelegate, UIAlertViewDelegate> {
}

//@property (retain, nonatomic) UIView *areaView;
@property (retain, nonatomic) NSString *mobile;
@property (nonatomic, retain) NSString *password;

@property (retain, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (nonatomic, retain) WorkAreaPickerViewDelegate *workAreaPickerViewDelegate;
@property (retain, nonatomic) IBOutlet UITextField *nickNameField;

@property (nonatomic, retain) NSString *nickName;
@property (nonatomic, retain) NSString *sex;
@property (nonatomic, retain) NSString *birthday;
@property (nonatomic, retain) NSString *province;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *marryStatus;
@property (nonatomic, retain) NSString *education;
@property (nonatomic, retain) NSString *loveKind;
@property (nonatomic, retain) NSString *salary;
@property (nonatomic, retain) NSString *height;


@property (retain, nonatomic) IBOutlet UIButton *birthdayButton;

- (IBAction)sexAction:(UISegmentedControl *)sender;
- (IBAction)birthdayAction:(UIButton *)sender;
- (IBAction)workAreaAction:(UIButton *)sender;
- (IBAction)marryStatusAction:(UIButton *)sender;
- (IBAction)educationAction:(UIButton *)sender;
- (IBAction)salaryAction:(UIButton *)sender;
- (IBAction)heightAction:(UIButton *)sender;
- (IBAction)loveKindAction:(UIButton *)sender;

- (IBAction)registerAction:(UIButton *)sender;

@end
