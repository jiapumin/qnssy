//
//  BSSearchViewController_iPhone.h
//  qnssy
//
//  Created by jpm on 13-3-12.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSSuperCentreViewController_iPhone.h"

@interface BSSearchViewController_iPhone : BSSuperCentreViewController_iPhone <UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UISegmentedControl *searchTypeControl;
@property (nonatomic, retain) NSArray *provinceArray;
@property (nonatomic, retain) NSArray *cityArray;
@property (nonatomic, retain) NSMutableArray *startAgeArray;
@property (nonatomic, retain) NSMutableArray *endAgeArray;
@property (nonatomic, retain) NSMutableArray *startHeightArray;
@property (nonatomic, retain) NSMutableArray *endHeightArray;
@property (nonatomic, retain) NSArray *educationArray;
@property (nonatomic, retain) NSArray *salaryArray;
@property (nonatomic, retain) NSArray *marryStatusArray;
@property (nonatomic, retain) NSArray *housingArray;
@property (nonatomic, retain) NSArray *caringArray;
@property (nonatomic, retain) NSArray *childrenArray;
@property (nonatomic, retain) NSArray *lovekinkArray;
@property (nonatomic, retain) NSArray *havepicArray;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIPickerView *areaPickerView;
@property (nonatomic, retain) NSMutableArray *cells;
@property (nonatomic, retain) UITextField *idField;
@property (nonatomic, retain) UITextField *nickField;

- (IBAction)segmentedAction:(UISegmentedControl *)sender;

@end
