//
//  BSUserBasicInfoViewController.m
//  qnssy
//
//  Created by juchen on 13-5-23.
//  Copyright (c) 2013年 jpm. All rights reserved.
//
#import "TPKeyboardAvoidingScrollView.h"
#import "NSDate+TCUtils.h"
#import "BSUserBasicInfoViewController.h"
#import "RegisterRequestVo.h"
#import "LoginResponseVo.h"

@interface BSUserBasicInfoViewController () {
    
}
@property (nonatomic, retain) NSArray *marryStatusArray;
@property (nonatomic, retain) NSArray *educationArray;
@property (nonatomic, retain) NSArray *salaryArray;
@property (nonatomic, retain) NSArray *heightArray;
@property (nonatomic, retain) NSArray *loveKindArray;
@property (nonatomic, retain) NSString *year;
@property (nonatomic, retain) NSString *month;
@property (nonatomic, retain) NSString *day;
@end

@implementation BSUserBasicInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"用户基本信息";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    WorkAreaPickerViewDelegate *tempWorkArea = [[WorkAreaPickerViewDelegate alloc] init];
    self.workAreaPickerViewDelegate = tempWorkArea;
    [tempWorkArea release];
    
    //隐藏键盘处理
    CGRect contentRect = CGRectZero;
    for ( UIView *subview in self.scrollView.subviews ) {
        contentRect = CGRectUnion(contentRect, subview.frame);
    }
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 790);
    
//    [self configureNavigationController];
    self.view.backgroundColor = publicColor;
    
    // setup data
    [self setupData];
}

-(void)hiddenKeyBoard:(id) sender {
    [self.nickNameField resignFirstResponder];
}

#pragma mark -
#pragma mark setup data

-(void) setupData{
    // setup default data
    self.sex = @"1";
    self.province = @"0";
    self.city = @"0";
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
    self.heightArray = tempHeightArray;
}


#pragma mark -
#pragma mark Actions

- (IBAction)sexAction:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.sex = [NSString stringWithFormat:@"%d",1];
            break;
        case 1:
            self.sex = [NSString stringWithFormat:@"%d",2];
            break;
            
        default:
            self.sex = [NSString stringWithFormat:@"%d",1];
            break;
    }
}

- (IBAction)birthdayAction:(UIButton *)sender {
    _actionSheetPicker = [[ActionSheetDatePicker alloc] initWithTitle:@"生日" datePickerMode:UIDatePickerModeDate selectedDate:self.selectedDate target:self action:@selector(dateWasSelected:element:) origin:sender];
    self.actionSheetPicker.hideCancel = YES;
    [self.actionSheetPicker showActionSheetPicker];
}

- (IBAction)workAreaAction:(UIButton *)sender {
//    WorkAreaPickerViewDelegate *del = [[WorkAreaPickerViewDelegate alloc] init];
    [ActionSheetCustomPicker showPickerWithTitle:@"工作地区" delegate:self.workAreaPickerViewDelegate showCancelButton:NO origin:sender];
}

- (IBAction)marryStatusAction:(UIButton *)sender {
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        [sender setTitle:selectedValue forState:UIControlStateNormal];
        self.marryStatus = [NSString stringWithFormat:@"%d",selectedIndex];
        NSLog(@"marry status %@", self.marryStatus);
    };
    [ActionSheetStringPicker showPickerWithTitle:@"婚姻状况" rows:self.marryStatusArray initialSelection:0 doneBlock:done cancelBlock:nil origin:sender];
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

- (IBAction)heightAction:(UIButton *)sender {
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        [sender setTitle:selectedValue forState:UIControlStateNormal];
        self.height = [NSString stringWithFormat:@"%d",selectedIndex];
        NSLog(@"height value %@", self.height);
    };
    [ActionSheetStringPicker showPickerWithTitle:@"身高" rows:self.heightArray initialSelection:0 doneBlock:done cancelBlock:nil origin:sender];
}

- (IBAction)loveKindAction:(UIButton *)sender {
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        [sender setTitle:selectedValue forState:UIControlStateNormal];
        self.loveKind = [NSString stringWithFormat:@"%d",selectedIndex];
        NSLog(@"loveKind value %@", self.loveKind);
    };
    [ActionSheetStringPicker showPickerWithTitle:@"身高" rows:self.loveKindArray initialSelection:0 doneBlock:done cancelBlock:nil origin:sender];
}

#pragma mark 注册事件
- (IBAction)registerAction:(UIButton *)sender {
    /**
     * 点击下一步，封装参数，请求数据接口
     * 参数：
     1. username     用户名
     2. mobile       手机号
     3. password     密码
     4. sex          性别
     5. height       身高
     6. year         出生年
     7. month        出生月
     8. day          出生日
     9. marrystatus  婚姻状况
     10.lovekind     交友类型
     11.education    教育程度
     12.salary       月收入
     13.provinceid   所在省
     14.cityid       所在市
     **/
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    self.nickName = self.nickNameField.text;
    self.province = self.workAreaPickerViewDelegate.provinceId;
    self.city = self.workAreaPickerViewDelegate.cityId;
    if ([self.nickName isEqual:[NSNull null]] || [self.mobile isEqual:[NSNull null]] || [self.password isEqual:[NSNull null]] || [self.sex isEqual:[NSNull null]] || [self.height isEqual:[NSNull null]] || [self.year isEqual:[NSNull null]] || [self.month isEqual:[NSNull null]] || [self.day isEqual:[NSNull null]] || [self.marryStatus isEqual:[NSNull null]] || [self.loveKind isEqual:[NSNull null]] || [self.education isEqual:[NSNull null]] || [self.salary isEqual:[NSNull null]] || [self.province isEqual:[NSNull null]] || [self.city isEqual:[NSNull null]]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"资料似乎不完整" delegate:self cancelButtonTitle:@"检查" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    } else if(self.nickName.length < 2){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"昵称太短了，要大于2个哦" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    } else {
        [params setObject:self.nickName forKey:@"username"];
        [params setObject:self.mobile forKey:@"mobile"];
        [params setObject:self.password forKey:@"password"];
        [params setObject:self.sex forKey:@"sex"];
        [params setObject:self.height forKey:@"height"];
        [params setObject:self.year forKey:@"year"];
        [params setObject:self.month forKey:@"month"];
        [params setObject:self.day forKey:@"day"];
        [params setObject:self.marryStatus forKey:@"marrystatus"];
        [params setObject:self.loveKind forKey:@"lovekind"];
        [params setObject:self.education forKey:@"education"];
        [params setObject:self.salary forKey:@"salary"];
        [params setObject:self.province forKey:@"provinceid"];
        [params setObject:self.city forKey:@"cityid"];
        
        RegisterRequestVo *requestVo = [[RegisterRequestVo alloc] initWithParams:params];
        [[BSContainer instance].serviceAgent callServletWithObject:self
                                                       requestDict:requestVo.mReqDic
                                                            target:self
                                                   successCallBack:@selector(validateSucceess:data:)
                                                      failCallBack:@selector(validateFailed:data:)];
        [requestVo release];
        [params release];
    }
}

#pragma mark -
#pragma mark birthday picker view selected action

- (void)dateWasSelected:(NSDate *)selectedDate element:(id)element {
    self.selectedDate = selectedDate;
    NSString *tempDates = [NSString stringWithFormat:@"%@",selectedDate];
    NSArray *data = [tempDates componentsSeparatedByString:@" "];
    NSString *riqi = [data objectAtIndex:0];
    NSArray *dates = [riqi componentsSeparatedByString:@"-"];
    
    self.year = [dates objectAtIndex:0];
    self.month = [NSString stringWithFormat:@"%d",[[dates objectAtIndex:1] intValue]];
    self.day = [dates objectAtIndex:2];
    
    [self.birthdayButton setTitle:[NSString stringWithFormat:@"%@-%@-%@",self.year, self.month, self.day] forState:UIControlStateNormal];
    
}

#pragma mark - 服务器回调

- (void) validateSucceess:(id) sender data:(NSDictionary *) dic{
    LoginResponseVo *vo = [[LoginResponseVo alloc] initWithDic:dic];   
    
    NSLog(@"用户id:%@--登录消息:%@",vo.userInfo.userId,vo.message);
    //登录成功，保存用户信息
    [BSContainer instance].userInfo = vo.userInfo;
    
    if (vo.status == 0) {
        [app viewUpdate];
        app.window.rootViewController = app.revealSideViewController;
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:vo.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
}

- (void) validateFailed:(id) sender data:(NSDictionary *) dic{
    NSLog(@"注册出错了。");
}

#pragma mark alter view delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}

#pragma mark -
#pragma mark Memory Manage

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_birthdayButton release];
    [_scrollView release];
    [_nickNameField release];
    [_mobile release];
    [_password release];
    [_selectedDate release];
    [_nickName release];
    [_sex release];
    [_birthday release];
    [_province release];
    [_city release];
    [_marryStatus release];
    [_education release];
    [_loveKind release];
    [_salary release];
    [_height release];
    [_marryStatusArray release];
    [_educationArray release];
    [_loveKindArray release];
    [_year release];
    [_month release];
    [_day release];
    [_salaryArray release];
    [_heightArray release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setBirthdayButton:nil];
    [self setScrollView:nil];
    [self setNickNameField:nil];
    [super viewDidUnload];
}
@end
