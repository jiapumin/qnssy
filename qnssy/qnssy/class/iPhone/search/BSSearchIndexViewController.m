//
//  BSSearchIndexViewController.m
//  qnssy
//
//  Created by juchen on 13-5-29.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSSearchIndexViewController.h"
#import "SearchRequestVo.h"
#import "SearchResponseVo.h"
#import "BSSearchResultViewController_iPhone.h"

@interface BSSearchIndexViewController (){
    MBProgressHUD *progressHUD;
}

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
    
    //自定义头部按钮
    UIButton *topRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //按钮大小
    CGRect btnFrame = CGRectMake(315, 5, 43, 28);
    topRightButton.frame =btnFrame;
    [topRightButton setImage:[UIImage imageNamed:@"19搜索按钮.png"]
                   forState:UIControlStateNormal];
    [topRightButton addTarget:self
                      action:@selector(searchAction)
            forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem * topRightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:topRightButton];
    
    self.navigationItem.rightBarButtonItem = topRightBarButtonItem;
    
    self.defaultView.contentSize = CGSizeMake(self.view.frame.size.width, 1000);
    
    self.searchByIdView.hidden = YES;
    self.searchByNameView.hidden = YES;

    WorkAreaPickerViewDelegate *tempWorkArea = [[WorkAreaPickerViewDelegate alloc] init];
    self.workAreaPickerViewDelegate = tempWorkArea;
    [tempWorkArea release];
    
    UserAgePickerViewDelegate *tempAge = [[UserAgePickerViewDelegate alloc] init];
    self.userAgePickerViewDelegate = tempAge;
    [tempAge release];
    
    UserHeightPickerViewDelegate *tempHeight = [[UserHeightPickerViewDelegate alloc] init];
    self.userHeightPickerViewDelegate = tempHeight;
    [tempHeight release];
    
    [self initHUDView];
    [self setupData];
}

- (void)initHUDView{
    //-------加载框
    progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:progressHUD];
    
    progressHUD.labelText = @"数据加载中...";
    
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
    
    // hoursing
    self.hoursingArray = [NSArray arrayWithObjects:@"不限", @"暂未购房", @"需要时置房", @"已购住房", @"与人合租", @"独自租房", @"与父母同住", @"住亲朋家", @"住单位房", nil];
    // caring array
    self.caringArray = [NSArray arrayWithObjects:@"不限", @"暂未购车", @"已经购车", nil];
    
    // children array
    self.childArray = [NSArray arrayWithObjects:@"不限", @"无小孩", @"有,和我住一起", @"有,有时和我住一起", @"有,不和我住一起", nil];
    
    self.pictureArray = [NSArray arrayWithObjects:@"不限", @"有", @"无", nil];
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
    [_searchByIdView release];
    [_searchByNameView release];
    [_defaultView release];
    [_idField release];
    [_nickNameField release];
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
    [ActionSheetCustomPicker showPickerWithTitle:@"年龄范围" delegate:self.userAgePickerViewDelegate showCancelButton:NO origin:sender];
}

- (IBAction)heightRangAction:(UIButton *)sender {
    [ActionSheetCustomPicker showPickerWithTitle:@"身高范围" delegate:self.userHeightPickerViewDelegate showCancelButton:NO origin:sender];
}

- (IBAction)educationAction:(UIButton *)sender {
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        [sender setTitle:selectedValue forState:UIControlStateNormal];
        self.education = [NSString stringWithFormat:@"%d",selectedIndex];
        NSLog(@"education value %@", self.education);
    };
    [ActionSheetStringPicker showPickerWithTitle:@"学历" rows:self.educationArray initialSelection:0 doneBlock:done cancelBlock:nil origin:sender];
}

- (IBAction)salaryAction:(UIButton *)sender {
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        [sender setTitle:selectedValue forState:UIControlStateNormal];
        self.salary = [NSString stringWithFormat:@"%d",selectedIndex];
        NSLog(@"salary value %@", self.salary);
    };
    [ActionSheetStringPicker showPickerWithTitle:@"月收入" rows:self.salaryArray initialSelection:0 doneBlock:done cancelBlock:nil origin:sender];
}

- (IBAction)marryStatusAction:(UIButton *)sender {
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        [sender setTitle:selectedValue forState:UIControlStateNormal];
        self.marryStatus = [NSString stringWithFormat:@"%d",selectedIndex];
        NSLog(@"marry status %@", self.marryStatus);
    };
    [ActionSheetStringPicker showPickerWithTitle:@"婚姻状况" rows:self.marryStatusArray initialSelection:0 doneBlock:done cancelBlock:nil origin:sender];
}

- (IBAction)hoursingAction:(UIButton *)sender {
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        [sender setTitle:selectedValue forState:UIControlStateNormal];
        self.hoursing = [NSString stringWithFormat:@"%d",selectedIndex];
        NSLog(@"hoursing status %@", self.hoursing);
    };
    [ActionSheetStringPicker showPickerWithTitle:@"住房情况" rows:self.hoursingArray initialSelection:0 doneBlock:done cancelBlock:nil origin:sender];
}

- (IBAction)caringAction:(UIButton *)sender {
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        [sender setTitle:selectedValue forState:UIControlStateNormal];
        self.caring = [NSString stringWithFormat:@"%d",selectedIndex];
        NSLog(@"caring status %@", self.caring);
    };
    [ActionSheetStringPicker showPickerWithTitle:@"购车情况" rows:self.caringArray initialSelection:0 doneBlock:done cancelBlock:nil origin:sender];
}

- (IBAction)childAction:(UIButton *)sender {
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        [sender setTitle:selectedValue forState:UIControlStateNormal];
        self.child = [NSString stringWithFormat:@"%d",selectedIndex];
        NSLog(@"child status %@", self.child);
    };
    [ActionSheetStringPicker showPickerWithTitle:@"有无子女" rows:self.childArray initialSelection:0 doneBlock:done cancelBlock:nil origin:sender];
}

- (IBAction)loveKindAction:(UIButton *)sender {
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        [sender setTitle:selectedValue forState:UIControlStateNormal];
        self.loveKind = [NSString stringWithFormat:@"%d",selectedIndex];
        NSLog(@"loveKind value %@", self.loveKind);
    };
    [ActionSheetStringPicker showPickerWithTitle:@"交友类型" rows:self.loveKindArray initialSelection:0 doneBlock:done cancelBlock:nil origin:sender];
}

- (IBAction)pictureAction:(UIButton *)sender {
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        [sender setTitle:selectedValue forState:UIControlStateNormal];
        self.picture = [NSString stringWithFormat:@"%d",selectedIndex];
        NSLog(@"picture status %@", self.picture);
    };
    [ActionSheetStringPicker showPickerWithTitle:@"有无照片" rows:self.pictureArray initialSelection:0 doneBlock:done cancelBlock:nil origin:sender];
}

- (IBAction)segmentedAction:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.defaultView.hidden = NO;
            self.searchByIdView.hidden = YES;
            self.searchByNameView.hidden = YES;
            break;
        case 1:
            self.defaultView.hidden = YES;
            self.searchByIdView.hidden = NO;
            self.searchByNameView.hidden = YES;
            break;
        case 2:
            self.defaultView.hidden = YES;
            self.searchByIdView.hidden = YES;
            self.searchByNameView.hidden = NO;
            break;
        default:
            break;
    }
}

-(void)searchAction{
    NSMutableDictionary *dict;
    if (!self.defaultView.hidden) {
        self.provenceId = self.workAreaPickerViewDelegate.provinceId;
        self.cityId = self.workAreaPickerViewDelegate.cityId;
        dict = [NSMutableDictionary dictionary];
        [dict setObject:[NSNumber numberWithInt:0] forKey:@"searchtype"];
        [dict setObject:self.startAge forKey:@"startage"];
        [dict setObject:self.endAge forKey:@"endage"];
        [dict setObject:self.startHeight forKey:@"startheight"];
        [dict setObject:self.endHeight forKey:@"endheight"];
        [dict setObject:[NSNumber numberWithInt:self.provenceId] forKey:@"provinceid"];
        [dict setObject:[NSNumber numberWithInt:self.cityId] forKey:@"cityid"];
        [dict setObject:self.education forKey:@"education"];
        [dict setObject:self.salary forKey:@"salary"];
        [dict setObject:self.marryStatus forKey:@"marrystatus"];
        [dict setObject:self.hoursing forKey:@"housing"];
        [dict setObject:self.caring forKey:@"caring"];
        [dict setObject:self.child forKey:@"children"];
        [dict setObject:self.loveKind forKey:@"lovekind"];
        [dict setObject:self.picture forKey:@"havepic"];
    } else if(!self.searchByIdView.hidden){
        if (self.idField.text.length <= 0) {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"搜索ID不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
            [alter release];
            return;
        }
        dict = [NSMutableDictionary dictionary];
        [dict setObject:[NSNumber numberWithInt:1] forKey:@"searchtype"];
        [dict setObject:self.idField.text forKey:@"userid"];
    } else {
        if (self.nickNameField.text.length <= 0) {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"搜索昵称不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
            [alter release];
            return;
        }
        dict = [NSMutableDictionary dictionary];
        [dict setObject:[NSNumber numberWithInt:2] forKey:@"searchtype"];
        [dict setObject:self.nickNameField.text forKey:@"username"];
    }
    
    SearchRequestVo *requestVo = [[SearchRequestVo alloc] initWithParams:dict];
    [[BSContainer instance].serviceAgent callServletWithObject:self
                                                   requestDict:requestVo.mReqDic
                                                        target:self
                                               successCallBack:@selector(searchSucceess:data:)
                                                  failCallBack:@selector(searchFailed:data:)];
    [requestVo release];
}

- (void) searchSucceess:(id) sender data:(NSDictionary *) dic {
    
    SearchResponseVo *vo = [[SearchResponseVo alloc] initWithDic:dic];
    if (vo.status == 1 || vo.searchList == nil) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:[[[dic objectForKey:@"data"] objectForKey:@"ResData"] objectForKey:@"Message"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        [alter release];
        
    }else{
        BSSearchResultViewController_iPhone *searchResultViewController = [[BSSearchResultViewController_iPhone alloc] init];
        searchResultViewController.dataArray = vo.searchList;
        [searchResultViewController.myTableView reloadData];
        [self.navigationController pushViewController:searchResultViewController animated:YES];
        [searchResultViewController release];
    }
    [progressHUD hide:YES];
    [vo release];
    
}

- (void) searchFailed:(id) sender data:(NSDictionary *) dic{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"网络异常，请检查网络连接后重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    [progressHUD hide:YES];
}

- (void)viewDidUnload {
    [self setSearchByIdView:nil];
    [self setSearchByNameView:nil];
    [self setDefaultView:nil];
    [self setIdField:nil];
    [self setNickNameField:nil];
    [super viewDidUnload];
}
@end
