//
//  BSUserInfoViewController.m
//  qnssy
//
//  Created by juchen on 13-3-19.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSUserInfoViewController.h"
#import "BSSexElement.h"

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
    }
}

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
        
        QAppearance *appearance = [[QAppearance alloc] init];
        [appearance setValueColorEnabled:[UIColor colorWithRed:0.8 green:0.058 blue:0.325 alpha:1]];
        appearance.labelColorEnabled = [UIColor colorWithRed:0.603 green:0.603 blue:0.603 alpha:1];
        //昵称
        QEntryElement *nickEntry = [[QEntryElement alloc] initWithTitle:@"昵称" Value:nil Placeholder:@"请输入昵称"];
        //性别
        BSSexElement *sexEntry = [[BSSexElement alloc] initWithItems:[[NSArray alloc] initWithObjects:@"男", @"女", nil] selected:0 title:@"性别"];
        sexEntry.appearance = appearance;
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
        NSArray *hunyinArray = [[NSArray alloc] initWithObjects:@"已婚", @"未婚", nil];
        QPickerElement *hunyin = [[QPickerElement alloc] initWithTitle:@"婚姻状况" items: @[hunyinArray] value:kPleaseSelect];
        hunyin.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        hunyin.appearance = appearance;
        [hunyinArray release];
        //月收入
        QPickerElement *moneyElement = [self configMoney];
        moneyElement.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        moneyElement.appearance = appearance;
        //身高
        QPickerElement *heightElement = [self configHeight];
        heightElement.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        heightElement.appearance = appearance;
        
        //下一步按钮
        QButtonElement *buttonElement = [[QButtonElement alloc] init];
        buttonElement.title = @"下一步";
        
        [section addElement:nickEntry];
        [section2 addElement:sexEntry];
        [section3 addElement:birthdayPicker];
        [section4 addElement:workAreaElement];
        [section5 addElement:hunyin];
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
        
        [self.root addSection:section];
        [self.root addSection:section2];
        [self.root addSection:section3];
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
    }
    return self;
}

// 生日数据
- (QPickerElement *) configUserBirthday {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *dateString=[dateFormatter stringFromDate:[NSDate date]];
    int year = [dateString intValue];
    int old = year - 40;
    int yong = year - 18;
    NSMutableArray *bronYearArray = [[NSMutableArray alloc] init];
    NSMutableArray *bronMonthArray = [[NSMutableArray alloc] init];
    for (int i=old; i <= yong; i++) {
        [bronYearArray addObject:[NSString stringWithFormat:@"%d年",i]];
    }
    for (int i=1; i<=12; i++) {
        [bronMonthArray addObject:[NSString stringWithFormat:@"%d月",i]];
    }
    QPickerElement *birthdayElement = [[QPickerElement alloc] initWithTitle:@"生日" items:@[bronYearArray, bronMonthArray] value:kPleaseSelect];
    [bronYearArray release];
    [bronMonthArray release];
    return birthdayElement;
}

// 工作地区数据配置
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

//学历配置
- (QPickerElement *) configEdu {
    NSArray *eduArray = [NSArray arrayWithObjects:@"初中",@"高中",@"中专",@"大专",@"本科",@"研究生",@"博士",@"硕士", nil];
    QPickerElement *eduElement = [[QPickerElement alloc] initWithTitle:@"学历" items:@[eduArray] value:kPleaseSelect];
    return eduElement;
}

//月收入
- (QPickerElement *) configMoney {
    NSArray *moneyArray = [NSArray arrayWithObjects:@"5000以下",@"5000-1000",@"10000-15000",@"15000以上", nil];
    QPickerElement *moneyElement = [[QPickerElement alloc] initWithTitle:@"月收入" items:@[moneyArray] value:kPleaseSelect];
    return moneyElement;
}

//身高
- (QPickerElement *) configHeight {
    NSArray *heightArray = [NSArray arrayWithObjects:@"1.50-1.60",@"1.60-1.65",@"1.65-1.70",@"1.70以上", nil];
    QPickerElement *heightElement = [[QPickerElement alloc] initWithTitle:@"身高" items:@[heightArray] value:kPleaseSelect];
    return heightElement;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated  {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}
- (void)dealloc {
    [_myNavigationBar release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMyNavigationBar:nil];
    [super viewDidUnload];
}
- (IBAction)clickBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - pop
- (void)popViewContoller{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
