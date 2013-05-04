//
//  BSUserInfoViewController.m
//  qnssy
//
//  Created by juchen on 13-3-19.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSUserInfoViewController.h"
#import "BSSexElement.h"
#import "RegisterRequestVo.h"

@interface BSUserInfoViewController ()

@end

@implementation BSUserInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    //头部nav背景
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"2顶部条状背景"] forBarMetrics:UIBarMetricsDefault];
    //自定义头部按钮
    UIButton *topLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //按钮大小
    CGRect btnFrame = CGRectMake(5, 5, 40, 33);
    topLeftButton.frame =btnFrame;
    [topLeftButton setImage:[UIImage imageNamed:@"2向左返回箭头@2x"]
                   forState:UIControlStateNormal];
    
    [topLeftButton addTarget:self
                      action:@selector(popViewContoller)
            forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem * topLeftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:topLeftButton];
    
    self.navigationItem.leftBarButtonItem = topLeftBarButtonItem;

    selectedProvince = [province objectAtIndex: 0];
    self.wantsFullScreenLayout = YES;
}

- (void)viewWillAppear:(BOOL)animated  {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

#pragma mark - pop
- (void)popViewContoller{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setQuickDialogTableView:(QuickDialogTableView *)aQuickDialogTableView {
    [super setQuickDialogTableView:aQuickDialogTableView];
    self.quickDialogTableView.backgroundView = nil;
    self.quickDialogTableView.backgroundColor = [UIColor colorWithRed:0.968 green:0.878 blue:0.909 alpha:1];
    self.quickDialogTableView.bounces = NO;
    self.quickDialogTableView.styleProvider = self;
    
    ((QEntryElement *)[self.root elementWithKey:@"login"]).delegate = self;
}

-(void) cell:(UITableViewCell *)cell willAppearForElement:(QElement *)element atIndexPath:(NSIndexPath *)indexPath{
    cell.textLabel.textColor = [UIColor grayColor];
    if ([element isKindOfClass:[QButtonElement class]]) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2下一步背景@2x.png"]];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont fontWithName:@"" size:14];
        cell.backgroundView = imageView;
        [imageView release];
    }
}

#pragma mark -
#pragma mark setup view
- (QuickDialogController *) initWithRoot:(QRootElement *)rootElement {
    self = [super init];
    if (self) {
        [self configCityAndArea];
        self.root = rootElement;
        self.resizeWhenKeyboardPresented =YES;
        self.root.title = @"基本资料";
        self.root.grouped = YES;
        
        QSection *section = [[QSection alloc] init];
        QSection *section2 = [[QSection alloc] init];
        QSection *section3 = [[QSection alloc] init];
        QSection *section4 = [[QSection alloc] init];
        QSection *section5 = [[QSection alloc] init];
        QSection *section6 = [[QSection alloc] init];
        QSection *section7 = [[QSection alloc] init];
        QSection *section8 = [[QSection alloc] init];
        QSection *section9 = [[QSection alloc] init];
        QSection *section10 = [[QSection alloc] init];
        
        QAppearance *appearance = [[QAppearance alloc] init];
        [appearance setValueColorEnabled:[UIColor colorWithRed:0.8 green:0.058 blue:0.325 alpha:1]];
        appearance.labelColorEnabled = [UIColor colorWithRed:0.603 green:0.603 blue:0.603 alpha:1];
        //昵称
        QEntryElement *nickEntry = [[QEntryElement alloc] initWithTitle:@"昵称" Value:nil Placeholder:@"请输入昵称"];
        nickEntry.onValueChanged = ^(QRootElement *element) {
            self.userName = nickEntry.textValue;
        };
        //性别
        BSSexElement *sexEntry = [[BSSexElement alloc] initWithItems:[[NSArray alloc] initWithObjects:@"男", @"女", nil] selected:0 title:@"性别"];
        sexEntry.appearance = appearance;
        self.sex = @"1";
        sexEntry.onValueChanged = ^(QRootElement *el){
            if (sexEntry.selected == -1) {
                self.sex = @"1";
            } else {
                self.sex = @"2";
            }
        };
        //生日
        QPickerElement *birthdayPicker = [self configUserBirthday];
        birthdayPicker.appearance = appearance;
        birthdayPicker.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        //工作地区
        QPickerElement *workAreaElement = [self configWorkArea];
        workAreaElement.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        workAreaElement.appearance = appearance;
        //学历
        QPickerElement *eduElement = [self configEdu];
        eduElement.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        eduElement.appearance = appearance;

        //婚姻状况
        NSArray *marryStatusArray = [[NSArray alloc] initWithObjects:@"请选择",@"未婚", @"离异", @"丧偶", nil];
        QPickerElement *marryStatusElement = [[QPickerElement alloc] initWithTitle:@"婚姻状况" items: @[marryStatusArray] value:kPleaseSelect];
        marryStatusElement.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        marryStatusElement.appearance = appearance;
        [marryStatusArray release];
        marryStatusElement.onValueChanged = ^(QRootElement *element) {
            int row = [[marryStatusElement.selectedIndexes objectAtIndex:0] intValue];
            self.marrystatus = [NSString stringWithFormat:@"%d",row + 1];
        };

        //月收入
        QPickerElement *moneyElement = [self configMoney];
        moneyElement.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        moneyElement.appearance = appearance;
        //身高
        QPickerElement *heightElement = [self configHeight];
        heightElement.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        heightElement.appearance = appearance;
        
        NSArray *loveKindArray = [NSArray arrayWithObjects:@"请选择", @"恋爱", @"结婚", nil];
        QPickerElement *loveKindElement = [[QPickerElement alloc] initWithTitle:@"交友类型" items:@[loveKindArray] value:kPleaseSelect];
        loveKindElement.appearance = appearance;
        loveKindElement.onValueChanged = ^(QRootElement *element){
            int row = [[loveKindElement.selectedIndexes objectAtIndex:0] intValue];
            if (row == 0) {
                self.lovekind = @"3";
            } else {
                self.lovekind = @"4";
            }
        };
        
        //下一步按钮
        QButtonElement *buttonElement = [[QButtonElement alloc] init];
        buttonElement.title = @"下一步";
        [buttonElement setControllerAction:@"registerNextStepHandler:"];
        
        [section addElement:nickEntry];
        [section2 addElement:sexEntry];
        [section3 addElement:birthdayPicker];
        [section10 addElement:loveKindElement];
        [section4 addElement:workAreaElement];
        [section5 addElement:marryStatusElement];
        [section6 addElement:eduElement];
        [section7 addElement:moneyElement];
        [section8 addElement:heightElement];
        [section9 addElement:buttonElement];
        
        [nickEntry release];
        [sexEntry release];
        [birthdayPicker release];
        [eduElement release];
        [moneyElement release];
        [heightElement release];
        [loveKindElement release];
        
        [appearance release];
        
        [self.root addSection:section];
        [self.root addSection:section2];
        [self.root addSection:section3];
        [self.root addSection:section10];
        [self.root addSection:section4];
        [self.root addSection:section5];
        [self.root addSection:section6];
        [self.root addSection:section7];
        [self.root addSection:section8];
        [self.root addSection:section9];
        
        [section release];
        [section2 release];
        [section3 release];
        [section4 release];
        [section5 release];
        [section6 release];
        [section7 release];
        [section8 release];
        [section10 release];
    }
    return self;
}

#pragma mark 工作地区
- (void) configCityAndArea {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
    areaDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    NSArray *components = [areaDic allKeys];
    NSArray *sortedArray = [components sortedArrayUsingComparator: ^(id obj1, id obj2) {

        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }

        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];

    NSMutableArray *provinceTmp = [[NSMutableArray alloc] init];
    for (int i=0; i<[sortedArray count]; i++) {
        NSString *index = [sortedArray objectAtIndex:i];
        NSArray *tmp = [[areaDic objectForKey: index] allKeys];
        [provinceTmp addObject: [tmp objectAtIndex:0]];
    }

    province = [[NSArray alloc] initWithArray: provinceTmp];
    [provinceTmp release];

    NSString *index = [sortedArray objectAtIndex:0];
    NSString *selected = [province objectAtIndex:0];
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [[areaDic objectForKey:index]objectForKey:selected]];

    NSArray *cityArray = [dic allKeys];
    NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [cityArray objectAtIndex:0]]];
    city = [[NSArray alloc] initWithArray: [cityDic allKeys]];


    NSString *selectedCity = [city objectAtIndex: 0];
    district = [[NSArray alloc] initWithArray: [cityDic objectForKey: selectedCity]];
}

#pragma mark 生日数据

- (QPickerElement *) configUserBirthday {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *dateString=[dateFormatter stringFromDate:[NSDate date]];
    int year = [dateString intValue];
    int old = year - 40;
    int yong = year - 18;
    NSMutableArray *bronYearArray = [[NSMutableArray alloc] init];
    NSMutableArray *bronMonthArray = [[NSMutableArray alloc] init];
    NSMutableArray *bronDayArray = [[NSMutableArray alloc] init];
    for (int i=old; i <= yong; i++) {
        [bronYearArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    for (int i=1; i<=12; i++) {
        if (i < 10) {
            [bronMonthArray addObject:[NSString stringWithFormat:@"0%d",i]];
        } else {
            [bronMonthArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    for (int k = 1; k <= 30; k++) {
        [bronDayArray addObject:[NSString stringWithFormat:@"%d", k]];
    }
    QPickerElement *birthdayElement = [[QPickerElement alloc] initWithTitle:@"生日" items:@[bronYearArray, bronMonthArray, bronDayArray] value:kPleaseSelect];
    birthdayElement.onValueChanged = ^(QRootElement *element) {
        self.year = [bronYearArray objectAtIndex:[[birthdayElement.selectedIndexes objectAtIndex:0] intValue]];
        self.month = [bronMonthArray objectAtIndex:[[birthdayElement.selectedIndexes objectAtIndex:1] intValue]];
        self.day = [bronDayArray objectAtIndex:[[birthdayElement.selectedIndexes objectAtIndex:2] intValue]];
    };
    [bronYearArray release];
    [bronMonthArray release];
    [bronDayArray release];
    return birthdayElement;
}

#pragma mark 工作地区数据配置
- (QPickerElement *) configWorkArea {
    QPickerElement *workAreaElement = [[QPickerElement alloc] initWithTitle:@"工作地区" items: @[province, city, district] value:kPleaseSelect];
    
    workAreaElement.onValueChanged = ^(QRootElement *el){
        [workAreaElement reloadAllComponents];
        if ([workAreaElement.selectedIndexes objectAtIndex:0] != 0) {
            int row = [[workAreaElement.selectedIndexes objectAtIndex:0] intValue];
            selectedProvince = [province objectAtIndex: row];
            NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [areaDic objectForKey: [NSString stringWithFormat:@"%d", row]]];
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: selectedProvince]];
            NSArray *cityArray = [dic allKeys];
            NSArray *sortedArray = [cityArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
                
                if ([obj1 integerValue] > [obj2 integerValue]) {
                    return (NSComparisonResult)NSOrderedDescending;//递减
                }
                
                if ([obj1 integerValue] < [obj2 integerValue]) {
                    return (NSComparisonResult)NSOrderedAscending;//上升
                }
                return (NSComparisonResult)NSOrderedSame;
            }];
            
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (int i=0; i<[sortedArray count]; i++) {
                NSString *index = [sortedArray objectAtIndex:i];
                NSArray *temp = [[dic objectForKey: index] allKeys];
                [array addObject: [temp objectAtIndex:0]];
            }
            
            [city release];
            city = [[NSArray alloc] initWithArray: array];
            [array release];
            
            [district release];
            NSDictionary *cityDic = [dic objectForKey: [sortedArray objectAtIndex: 0]];
            district = [[NSArray alloc] initWithArray: [cityDic objectForKey: [city objectAtIndex: 0]]];
            workAreaElement.items = @[province, city, district];
            [workAreaElement reloadAllComponents];
        }
        
        if ([workAreaElement.selectedIndexes objectAtIndex:1] != 0) {
            self.provinceid = [NSString stringWithFormat:@"%d",1];
            self.cityid = [NSString stringWithFormat:@"%d",2];
            int row = [[workAreaElement.selectedIndexes objectAtIndex:1] intValue];
            NSString *provinceIndex = [NSString stringWithFormat: @"%d", [province indexOfObject: selectedProvince]];
            NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [areaDic objectForKey: provinceIndex]];
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: selectedProvince]];
            NSArray *dicKeyArray = [dic allKeys];
            NSArray *sortedArray = [dicKeyArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
                
                if ([obj1 integerValue] > [obj2 integerValue]) {
                    return (NSComparisonResult)NSOrderedDescending;
                }
                
                if ([obj1 integerValue] < [obj2 integerValue]) {
                    return (NSComparisonResult)NSOrderedAscending;
                }
                return (NSComparisonResult)NSOrderedSame;
            }];
            
            NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [sortedArray objectAtIndex: row]]];
            NSArray *cityKeyArray = [cityDic allKeys];
            
            [district release];
            district = [[NSArray alloc] initWithArray: [cityDic objectForKey: [cityKeyArray objectAtIndex:0]]];
            workAreaElement.items = @[province, city, district];
            [workAreaElement reloadAllComponents];
        }
    };
    return workAreaElement;
}

#pragma mark 学历配置
- (QPickerElement *) configEdu {
    NSArray *eduArray = [NSArray arrayWithObjects:@"请选择", @"中专以下学历",@"中专",@"大专",@"本科",@"硕士",@"博士", nil];
    QPickerElement *eduElement = [[QPickerElement alloc] initWithTitle:@"学历" items:@[eduArray] value:kPleaseSelect];
    eduElement.onValueChanged = ^(QRootElement *element){
        int row = [[eduElement.selectedIndexes objectAtIndex:0] intValue];
        self.education = [NSString stringWithFormat:@"%d",row+1];
    };
    return eduElement;
}

#pragma mark 月收入配置
- (QPickerElement *) configMoney {
    NSArray *moneyArray = [NSArray arrayWithObjects:@"请选择", @"2000元以下",@"2000~5000元",@"5000~10000元",@"10000~20000元",@"20000元以上", nil];
    QPickerElement *moneyElement = [[QPickerElement alloc] initWithTitle:@"月收入" items:@[moneyArray] value:kPleaseSelect];
    moneyElement.onValueChanged = ^(QRootElement *element){
        int row = [[moneyElement.selectedIndexes objectAtIndex:0] intValue];
        self.salary = [NSString stringWithFormat:@"%d",row+1];
    };
    return moneyElement;
}

#pragma mark 身高配置
- (QPickerElement *) configHeight {
    NSMutableArray *heightArray = [[NSMutableArray alloc]init];
    [heightArray addObject:@"请选择"];
    for (int i = 130; i <= 260; i++) {
        [heightArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    QPickerElement *heightElement = [[QPickerElement alloc] initWithTitle:@"身高" items:@[heightArray] value:kPleaseSelect];
    heightElement.onValueChanged = ^(QRootElement *element){
        int row = [[heightElement.selectedIndexes objectAtIndex:0] intValue];
        self.height = [heightArray objectAtIndex:row];
    };
    [heightArray release];
    return heightElement;
}

#pragma mark - 点击“下一步”按钮事件
- (void)registerNextStepHandler:(QButtonElement *) button {
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
    
    if ([self.userName isEqual:[NSNull null]] || [self.mobile isEqual:[NSNull null]] || [self.password isEqual:[NSNull null]] || [self.sex isEqual:[NSNull null]] || [self.height isEqual:[NSNull null]] || [self.year isEqual:[NSNull null]] || [self.month isEqual:[NSNull null]] || [self.day isEqual:[NSNull null]] || [self.marrystatus isEqual:[NSNull null]] || [self.lovekind isEqual:[NSNull null]] || [self.education isEqual:[NSNull null]] || [self.salary isEqual:[NSNull null]] || [self.provinceid isEqual:[NSNull null]] || [self.cityid isEqual:[NSNull null]]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"资料似乎不完整" delegate:self cancelButtonTitle:@"检查" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    } else if(self.userName.length < 2){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"昵称太短了，要大于2个哦" delegate:self cancelButtonTitle:@"改一下" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    } else {
        [params setObject:self.userName forKey:@"username"];
        [params setObject:self.mobile forKey:@"mobile"];
        [params setObject:self.password forKey:@"password"];
        [params setObject:self.sex forKey:@"sex"];
        [params setObject:self.height forKey:@"height"];
        [params setObject:self.year forKey:@"year"];
        [params setObject:self.month forKey:@"month"];
        [params setObject:self.day forKey:@"day"];
        [params setObject:self.marrystatus forKey:@"marrystatus"];
        [params setObject:self.lovekind forKey:@"lovekind"];
        [params setObject:self.education forKey:@"education"];
        [params setObject:self.salary forKey:@"salary"];
        [params setObject:self.provinceid forKey:@"provinceid"];
        [params setObject:self.cityid forKey:@"cityid"];
    }
    RegisterRequestVo *requestVo = [[RegisterRequestVo alloc] initWithParams:params];
    [[BSContainer instance].serviceAgent callServletWithObject:self
                                                   requestDict:requestVo.mReqDic
                                                        target:self
                                               successCallBack:@selector(validateSucceess:data:)
                                                  failCallBack:@selector(validateFailed:data:)];
    [requestVo release];
    [params release];
}

#pragma mark - 服务器回调

- (void) validateSucceess:(id) sender data:(NSDictionary *) dic{
    int status = [[dic objectForKey:@"status"] intValue];
    if (status == 0) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    } else {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:[[dic objectForKey:@"ResData"] objectForKey:@"Message"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        [alter release];
    }
}

- (void) validateFailed:(id) sender data:(NSDictionary *) dic{
    NSLog(@"注册出错了。");
}

#pragma mark - memory manage

- (void)dealloc {
    [_userName release];
    [_mobile release];
    [_password release];
    [_sex release];
    [_height release];
    [_year release];
    [_month release];
    [_day release];
    [_marrystatus release];
    [_lovekind release];
    [_education release];
    [_salary release];
    [_provinceid release];
    [_cityid release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setUserName:nil];
    [self setMobile:nil];
    [self setPassword:nil];
    [self setSex:nil];
    [self setHeight:nil];
    [self setYear:nil];
    [self setMonth:nil];
    [self setDay:nil];
    [self setMarrystatus:nil];
    [self setLovekind:nil];
    [self setEducation:nil];
    [self setSalary:nil];
    [self setProvinceid:nil];
    [self setCityid:nil];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
