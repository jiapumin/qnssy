//
//  BSSearchIndexViewController.m
//  qnssy
//
//  Created by juchen on 13-5-29.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSSearchIndexViewController.h"

@interface BSSearchIndexViewController ()

@end

@implementation BSSearchIndexViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.sex = @"1";// 1男  2 女
        self.provenceId = @"";
        self.cityId = @"";
        self.startAge = @"";
        self.endAge = @"";
        self.startHeight = @"";
        self.endHeight = @"";
        self.education = @"";
        self.salary = @"";
        self.marryStatus = @"";
        self.hoursing = @"";
        self.caring = @"";
        self.child = @"";
        self.loveKind = @"";
        self.picture = @"";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    WorkAreaPickerViewDelegate *tempWorkArea = [[WorkAreaPickerViewDelegate alloc] init];
    self.workAreaPickerViewDelegate = tempWorkArea;
    [tempWorkArea release];
    
    [self setupData];
}

-(void) setupData{
    // setup default date
    self.selectedDate = [NSDate date];
    // setup marrystatus data
    self.marryStatusArray = [NSArray arrayWithObjects:@"请选择", @"未婚", @"离异", @"丧偶", nil];
    // setup education data
    self.educationArray = [NSArray arrayWithObjects:@"请选择", @"中专以下学历", @"中专", @"大专", @"本科", @"硕士", @"博士", nil];
    // setup salary data
    self.salaryArray = [NSArray arrayWithObjects:@"请选择", @"2000元以下", @"2000 - 5000", @"5000 - 10000", @"10000 - 20000", @"20000元以上", nil];
    // setup love kind data
    self.loveKindArray = [NSArray arrayWithObjects:@"请选择", @"恋爱", @"结婚",nil];
    
    // setup height data
    NSMutableArray *tempHeightArray = [NSMutableArray array];
    for (int i=130; i<=260; i++) {
        [tempHeightArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    self.startHeightArray = tempHeightArray;
    self.endHeightArray = tempHeightArray;
}

-(void)dealloc{
    [_sex release];
    [_provenceId release];
    [_cityId release];
    [_startAgeArray release];
    [_endAgeArray release];
    [_startAge release];
    [_endAge release];
    [_startHeightArray release];
    [_endHeightArray release];
    [_startHeight release];
    [_endHeight release];
    [_educationArray release];
    [_education release];
    [_salaryArray release];
    [_salary release];
    [_marryStatusArray release];
    [_marryStatus release];
    [_hoursingArray release];
    [_hoursing release];
    [_caringArray release];
    [_caring release];
    [_childArray release];
    [_child release];
    [_loveKindArray release];
    [_loveKind release];
    [_pictureArray release];
    [_picture release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sexAction:(UISegmentedControl *)sender {
}

- (IBAction)areaAction:(UIButton *)sender {
    [ActionSheetCustomPicker showPickerWithTitle:@"工作地区" delegate:self.workAreaPickerViewDelegate showCancelButton:NO origin:sender];
}

- (IBAction)ageRangAction:(UIButton *)sender {
}

- (IBAction)heightRangAction:(UIButton *)sender {
}

- (IBAction)educationAction:(UIButton *)sender {
}

- (IBAction)salaryAction:(UIButton *)sender {
}

- (IBAction)marryStatusAction:(UIButton *)sender {
}

- (IBAction)hoursingAction:(UIButton *)sender {
}

- (IBAction)caringAction:(UIButton *)sender {
}

- (IBAction)childAction:(UIButton *)sender {
}

- (IBAction)loveKindAction:(UIButton *)sender {
}

- (IBAction)pictureAction:(UIButton *)sender {
}
@end
