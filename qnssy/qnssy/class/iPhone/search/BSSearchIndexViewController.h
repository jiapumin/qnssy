//
//  BSSearchIndexViewController.h
//  qnssy
//
//  Created by juchen on 13-5-29.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSSuperCentreViewController_iPhone.h"
#import "WorkAreaPickerViewDelegate.h"

@interface BSSearchIndexViewController : BSSuperCentreViewController_iPhone

@property (nonatomic, retain) WorkAreaPickerViewDelegate *workAreaPickerViewDelegate;
@property (nonatomic, retain) AbstractActionSheetPicker *actionSheetPicker;
@property (nonatomic, retain) NSDate *selectedDate;

@property (nonatomic, retain) NSString *sex;
@property (nonatomic, retain) NSString *provenceId;
@property (nonatomic, retain) NSString *cityId;
@property (nonatomic, retain) NSString *startAge;
@property (nonatomic, retain) NSString *endAge;
@property (nonatomic, retain) NSString *startHeight;
@property (nonatomic, retain) NSString *endHeight;
@property (nonatomic, retain) NSString *education;
@property (nonatomic, retain) NSString *salary;
@property (nonatomic, retain) NSString *marryStatus;
@property (nonatomic, retain) NSString *hoursing;
@property (nonatomic, retain) NSString *caring;
@property (nonatomic, retain) NSString *child;
@property (nonatomic, retain) NSString *loveKind;
@property (nonatomic, retain) NSString *picture;

@property (nonatomic, retain) NSArray *startAgeArray;
@property (nonatomic, retain) NSArray *endAgeArray;
@property (nonatomic, retain) NSArray *startHeightArray;
@property (nonatomic, retain) NSArray *endHeightArray;
@property (nonatomic, retain) NSArray *educationArray;
@property (nonatomic, retain) NSArray *salaryArray;
@property (nonatomic, retain) NSArray *marryStatusArray;
@property (nonatomic, retain) NSArray *hoursingArray;
@property (nonatomic, retain) NSArray *caringArray;
@property (nonatomic, retain) NSArray *childArray;
@property (nonatomic, retain) NSArray *loveKindArray;
@property (nonatomic, retain) NSArray *pictureArray;

- (IBAction)sexAction:(UISegmentedControl *)sender;
- (IBAction)areaAction:(UIButton *)sender;
- (IBAction)ageRangAction:(UIButton *)sender;
- (IBAction)heightRangAction:(UIButton *)sender;
- (IBAction)educationAction:(UIButton *)sender;
- (IBAction)salaryAction:(UIButton *)sender;
- (IBAction)marryStatusAction:(UIButton *)sender;
- (IBAction)hoursingAction:(UIButton *)sender;
- (IBAction)caringAction:(UIButton *)sender;
- (IBAction)childAction:(UIButton *)sender;
- (IBAction)loveKindAction:(UIButton *)sender;
- (IBAction)pictureAction:(UIButton *)sender;

@end
