//
//  BSSearchViewController_iPhone.m
//  qnssy
//
//  Created by jpm on 13-3-12.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSSearchViewController_iPhone.h"
#import "AreaDatabase.h"
#import "AreaInfo.h"
#import "SegmentCell.h"
#import "LabelCell.h"
#import "SearchRequestVo.h"
#import "BSSearchResultViewController.h"

@interface BSSearchViewController_iPhone () {
    int selectedRow;
    NSString *provinceName;
    NSString *cityName;
    int provinceId;
    int cityId;
    NSString *startAge;
    NSString *endAge;
    NSString *startHeight;
    NSString *endHeight;
    NSString *education;
    NSString *salary;
    NSString *marryStatus;
    NSString *housing;
    NSString *caring;
    NSString *children;
    NSString *lovekind;
    NSString *havepic;
    NSString *searchID;
    NSString *searchNickName;
}

@property (assign, nonatomic) int searchType;

@end

@implementation BSSearchViewController_iPhone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 47, 280, 350) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.searchType = 0;
    startAge = @"0";
    endAge = @"0";
    startHeight = @"0";
    endHeight = @"0";
    education = @"0";
    salary = @"0";
    marryStatus = @"0";
    housing = @"0";
    caring = @"0";
    lovekind = @"0";
    children = @"0";
    havepic = @"0";

    
    // province and citry array
    self.provinceArray = [[AreaDatabase database] getProvince];
    self.cityArray = [[AreaDatabase database] getCityWithProvinceId:1];
    
    // age array
    self.startAgeArray = [NSMutableArray array];
    self.endAgeArray = [NSMutableArray array];
    [self.startAgeArray addObject:@"不限"];
    [self.endAgeArray addObject:@"不限"];
    for (int i=18; i<98; i++) {
        [self.startAgeArray addObject:[NSString stringWithFormat:@"%d",i]];
        [self.endAgeArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    // height array
    self.startHeightArray = [NSMutableArray array];
    self.endHeightArray = [NSMutableArray array];
    [self.startHeightArray addObject:@"不限"];
    [self.endHeightArray addObject:@"不限"];
    for (int i=130; i<=260; i++) {
        [self.startHeightArray addObject:[NSString stringWithFormat:@"%d",i]];
        [self.endHeightArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    // education array
    self.educationArray = [NSArray arrayWithObjects:@"不限", @"中专以下学历", @"中专" , @"大专", @"本科", @"硕士", @"博士", nil];
    
    // salary array
    self.salaryArray = [NSArray arrayWithObjects:@"不限", @"2000元以下", @"2000~5000元", @"5000~10000元", @"10000~20000元", @"20000元以上", nil];
    
    // marry status array
    self.marryStatusArray = [NSArray arrayWithObjects:@"不限", @"未婚", @"离异", @"丧偶", nil];
    
    // housing array
    self.housingArray = [NSArray arrayWithObjects:@"不限", @"暂未购房", @"需要时置房", @"已购住房", @"与人合租", @"独自租房", @"与父母同住", @"住亲朋家", @"住单位房", nil];
    
    // caring array
    self.caringArray = [NSArray arrayWithObjects:@"不限", @"暂未购车", @"已经购车", nil];
    
    // children array
    self.childrenArray = [NSArray arrayWithObjects:@"不限", @"无小孩", @"有,和我住一起", @"有,有时和我住一起", @"有,不和我住一起", nil];
    
    // love kind array
    self.lovekinkArray = [NSArray arrayWithObjects:@"不限", @"恋爱", @"结婚", nil];
    
    // have pic aray
    self.havepicArray = [NSArray arrayWithObjects:@"不限", @"有", @"无", nil];
    
    // default data
    provinceName = [[self.provinceArray objectAtIndex:0] areaName];
    cityName = [[self.cityArray objectAtIndex:0] areaName];
    //省、市
    provinceId = [[self.provinceArray objectAtIndex:0] areaId];
    cityId = [[self.cityArray objectAtIndex:0] areaId];
    //年龄范围
    startAge = [self.startAgeArray objectAtIndex:0];
    endAge = [self.endAgeArray objectAtIndex:0];
    //身高范围
    startHeight = [self.startHeightArray objectAtIndex:0];
    endHeight = [self.endHeightArray objectAtIndex:0];
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchType == 0) {
        return 13;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *segmentIdentifier = @"SegmentCellID";
//    static NSString *labelIdentifier = @"LabelCellID";
    
    SegmentCell *segmentCell = (SegmentCell *)[tableView dequeueReusableCellWithIdentifier:segmentIdentifier];
//    LabelCell *labelCell = [(LabelCell *) [tableView dequeueReusableCellWithIdentifier:labelIdentifier] autorelease];
    LabelCell *labelCell = (LabelCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (segmentCell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"SegmentCell" owner:self options:nil];
        segmentCell = [array objectAtIndex:0];
        [segmentCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    if (labelCell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"LabelCell" owner:self options:nil];
        labelCell = [array objectAtIndex:0];
        [labelCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 280, 44)];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton setBackgroundImage:[UIImage imageNamed:@"2下一步背景@2x.png"] forState:UIControlStateNormal];
    // add search action
    [searchButton addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.searchType == 0) {
        if (indexPath.row == 0) {
            return segmentCell;
        }
        switch (indexPath.row) {
            case 0:
                return segmentCell;
                break;
            case 1:
                labelCell.leftLabel.text = @"所在地区";
//                labelCell.rightLabel.text = [NSString stringWithFormat:@"%@ %@",provinceName, cityName];
                break;
            case 2:
                labelCell.leftLabel.text = @"年龄范围";
//                labelCell.rightLabel.text = [NSString stringWithFormat:@"%@ - %@",startAge, endAge];
                break;
            case 3:
                labelCell.leftLabel.text = @"身高范围";
//                labelCell.rightLabel.text = [NSString stringWithFormat:@"%@ - %@",startHeight, endHeight];
                break;
            case 4:
                labelCell.leftLabel.text = @"学历";
//                labelCell.rightLabel.text = education;
                break;
            case 5:
                labelCell.leftLabel.text = @"月薪";
//                labelCell.rightLabel.text = salary;
                break;
            case 6:
                labelCell.leftLabel.text = @"婚姻状况";
//                labelCell.rightLabel.text = marryStatus;
                break;
            case 7:
                labelCell.leftLabel.text = @"住房情况";
//                labelCell.rightLabel.text = housing;
                break;
            case 8:
                labelCell.leftLabel.text = @"购车情况";
//                labelCell.rightLabel.text = caring;
                break;
            case 9:
                labelCell.leftLabel.text = @"有无子女";
//                labelCell.rightLabel.text = children;
                break;
            case 10:
                labelCell.leftLabel.text = @"交友类型";
//                labelCell.rightLabel.text = lovekind;
                break;
            case 11:
                labelCell.leftLabel.text = @"照片";
//                labelCell.rightLabel.text = havepic;
                break;
            default:
                break;
        }
        if (indexPath.row == 12) {
            for (UILabel *label in labelCell.subviews) {
                [label removeFromSuperview];
            }
            labelCell.accessoryType = UITableViewCellAccessoryNone;
            [labelCell addSubview:searchButton];
            [searchButton release];
        }
        return labelCell;
    } else if(self.searchType == 1){
        if (indexPath.row == 0) {
            self.idField = [[UITextField alloc] initWithFrame:CGRectMake(0, 5, 280, 34)];
            self.idField.placeholder = @"请输入您要搜索的千千缘ID";
            self.idField.borderStyle = UITextBorderStyleRoundedRect;
            self.idField.delegate = self;
            for (UILabel *label in labelCell.subviews) {
                [label removeFromSuperview];
            }
            labelCell.accessoryType = UITableViewCellAccessoryNone;
            [labelCell addSubview:self.idField];
            [self.idField release];
        }
        if (indexPath.row == 1) {
            for (UILabel *label in labelCell.subviews) {
                [label removeFromSuperview];
            }
            labelCell.accessoryType = UITableViewCellAccessoryNone;
            [labelCell addSubview:searchButton];
            [searchButton release];
        }
        return labelCell;
    } else {
        if (indexPath.row == 0) {
            self.nickField = [[UITextField alloc] initWithFrame:CGRectMake(0, 5, 280, 34)];
            self.nickField.placeholder = @"请输入您要搜索的千千缘昵称";
            self.nickField.borderStyle = UITextBorderStyleRoundedRect;
            self.nickField.delegate = self;
            for (UILabel *label in labelCell.subviews) {
                [label removeFromSuperview];
            }
            labelCell.accessoryType = UITableViewCellAccessoryNone;
            [labelCell addSubview:self.nickField];
            [self.nickField release];
        }
        if (indexPath.row == 1) {
            for (UILabel *label in labelCell.subviews) {
                [label removeFromSuperview];
            }
            labelCell.accessoryType = UITableViewCellAccessoryNone;
            [labelCell addSubview:searchButton];
            [searchButton release];
        }
        return labelCell;
    }
}

-(void) getAreaPicker {
    UIView *viewForAreaPicker = [[UIView alloc] initWithFrame:CGRectMake(0, 200, 280, 250)];
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneBtnPressToGetArea)];
    
    [toolBar setItems:[NSArray arrayWithObject:btn]];
    [viewForAreaPicker addSubview:toolBar];
    
    self.areaPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 320, 200)];
    self.areaPickerView.delegate=self;
    self.areaPickerView.dataSource=self;
    self.areaPickerView.showsSelectionIndicator=YES;
    
    [viewForAreaPicker addSubview:self.areaPickerView];
    [self.view addSubview:viewForAreaPicker];
    
    [self.areaPickerView release];
}

-(void) doneBtnPressToGetArea {
    [self.areaPickerView.superview removeFromSuperview];
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedRow = indexPath.row;
    if (self.searchType == 0) {
        [self getAreaPicker];
    }
}

#pragma mark -
#pragma mark picker view delegate

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (selectedRow == 1 || selectedRow == 2 || selectedRow == 3) {
        return 2;
    }
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (selectedRow == 1) {
        if (component == 0) {
            return self.provinceArray.count;
        } else {
            return self.cityArray.count;
        }
    }
    if (selectedRow == 2) {
        if (component == 0) {
            return self.startAgeArray.count;
        } else {
            return self.endAgeArray.count;
        }
    }
    if (selectedRow == 3) {
        if (component == 0) {
            return self.startHeightArray.count;
        } else {
            return self.endHeightArray.count;
        }
    }
    if (selectedRow == 4) {
        return self.educationArray.count;
    }
    if (selectedRow == 5) {
        return self.salaryArray.count;
    }
    if (selectedRow == 6) {
        return self.marryStatusArray.count;
    }
    if (selectedRow == 7) {
        return self.housingArray.count;
    }
    if (selectedRow == 8) {
        return self.caringArray.count;
    }
    if (selectedRow == 9) {
        return self.childrenArray.count;
    }
    if (selectedRow == 10) {
        return self.lovekinkArray.count;
    }
    if (selectedRow == 11) {
        return self.havepicArray.count;
    }
    return 0;
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (selectedRow == 1) {
        if (component == 0) {
            return [[self.provinceArray objectAtIndex:row] areaName];
        } else {
            return [[self.cityArray objectAtIndex:row] areaName];
        }
    }
    if (selectedRow == 2) {
        if (component == 0) {
            if (row == 0) {
                return [NSString stringWithFormat:@"%@",[self.startAgeArray objectAtIndex:row]];
            } else {
                return [NSString stringWithFormat:@"从 %@ 岁",[self.startAgeArray objectAtIndex:row]];
            }
        } else {
            if (row == 0) {
                return [NSString stringWithFormat:@"%@",[self.endAgeArray objectAtIndex:row]];
            } else {
                return [NSString stringWithFormat:@"从 %@ 岁",[self.endAgeArray objectAtIndex:row]];
            }
        }
    }
    if (selectedRow == 3) {
        if (component == 0) {
            if (row == 0) {
               return [NSString stringWithFormat:@"%@",[self.startHeightArray objectAtIndex:row]]; 
            } else {
                return [NSString stringWithFormat:@"从 %@ 厘米",[self.startHeightArray objectAtIndex:row]];
            }
        } else {
            if (row == 0) {
                return [NSString stringWithFormat:@"%@",[self.endHeightArray objectAtIndex:row]];
            } else {
                return [NSString stringWithFormat:@"从 %@ 厘米",[self.endHeightArray objectAtIndex:row]];
            }
        }
    }
    if (selectedRow == 4) {
        return [self.educationArray objectAtIndex:row];
    }
    if (selectedRow == 5) {
        return [self.salaryArray objectAtIndex:row];
    }
    if (selectedRow == 6) {
        return [self.marryStatusArray objectAtIndex:row];
    }
    if (selectedRow == 7) {
        return [self.housingArray objectAtIndex:row];
    }
    if (selectedRow == 8) {
        return [self.caringArray objectAtIndex:row];
    }
    if (selectedRow == 9) {
        return [self.childrenArray objectAtIndex:row];
    }
    if (selectedRow == 10) {
        return [self.lovekinkArray objectAtIndex:row];
    }
    if (selectedRow == 11) {
        return [self.havepicArray objectAtIndex:row];
    }
    return nil;
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (selectedRow == 1) {
        if (component == 0) {
            int areaid = [[self.provinceArray objectAtIndex:row] areaId];
            provinceName = [[self.provinceArray objectAtIndex:row] areaName];
            self.cityArray = [[AreaDatabase database] getCityWithProvinceId:areaid];
            cityName = [[self.cityArray objectAtIndex:0] areaName];
            provinceId = [[self.provinceArray objectAtIndex:row] areaId];
            cityId = [[self.cityArray objectAtIndex:0] areaId];
            [self.areaPickerView reloadComponent:1];
        } else {
            cityName = [[self.cityArray objectAtIndex:row] areaName];
            cityId = [[self.cityArray objectAtIndex:row] areaId];
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        LabelCell *cell = (LabelCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.rightLabel.text = [NSString stringWithFormat:@"%@ %@",provinceName,cityName];
    }
    if (selectedRow == 2) {
        if (component == 0) {
            startAge = [self.startAgeArray objectAtIndex:row];
        } else {
            endAge = [self.endAgeArray objectAtIndex:row];
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
        LabelCell *cell = (LabelCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        if (row == 0) {
            cell.rightLabel.text = [NSString stringWithFormat:@"%@ 到 %@",startAge, endAge];
        } else {
            cell.rightLabel.text = [NSString stringWithFormat:@"%@ 到 %@ 岁",startAge, endAge];
        }
    }
    if (selectedRow == 3) {
        if (component == 0) {
            startHeight = [self.startHeightArray objectAtIndex:row];
        } else {
            endHeight = [self.endHeightArray objectAtIndex:row];
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
        LabelCell *cell = (LabelCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.rightLabel.text = [NSString stringWithFormat:@"%@ 到 %@ 厘米",startHeight, endHeight];
    }
    if (selectedRow == 4) {
        if (row == 0) {
            education = @"0";
        } else {
            education = [NSString stringWithFormat:@"%d",row];
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:4 inSection:0];
        LabelCell *cell = (LabelCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.rightLabel.text = [self.educationArray objectAtIndex:row];
    }
    if (selectedRow == 5) {
        if (row == 0) {
            salary = @"0";
        } else {
            salary = [NSString stringWithFormat:@"%d",row];
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        LabelCell *cell = (LabelCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.rightLabel.text = [self.salaryArray objectAtIndex:row];
    }
    if (selectedRow == 6) {
        if (row == 0) {
            marryStatus = @"0";
        } else {
            marryStatus = [NSString stringWithFormat:@"%d",row];
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:6 inSection:0];
        LabelCell *cell = (LabelCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.rightLabel.text = [self.marryStatusArray objectAtIndex:row];
    }
    if (selectedRow == 7) {
        if (row == 0) {
            housing = @"0";
        } else {
            housing = [NSString stringWithFormat:@"%d",row];
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:7 inSection:0];
        LabelCell *cell = (LabelCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.rightLabel.text = [self.housingArray objectAtIndex:row];
    }
    if (selectedRow == 8) {
        if (row == 0) {
            caring = @"0";
        } else {
            caring = [NSString stringWithFormat:@"%d",row];
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:8 inSection:0];
        LabelCell *cell = (LabelCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.rightLabel.text = [self.caringArray objectAtIndex:row];
    }
    if (selectedRow == 9) {
        if (row == 0) {
            children = @"0";
        } else {
            children = [NSString stringWithFormat:@"%d",row];
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:9 inSection:0];
        LabelCell *cell = (LabelCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.rightLabel.text = [self.childrenArray objectAtIndex:row];
    }
    if (selectedRow == 10) {
        if (row == 0) {
            lovekind = @"0";
        } else {
            lovekind = [NSString stringWithFormat:@"%d",row];
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:10 inSection:0];
        LabelCell *cell = (LabelCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.rightLabel.text = [self.lovekinkArray objectAtIndex:row];
    }
    if (selectedRow == 11) {
        if (row == 0) {
            havepic = @"0";
        } else {
            havepic = [NSString stringWithFormat:@"%d",row];
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:11 inSection:0];
        LabelCell *cell = (LabelCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.rightLabel.text = [self.havepicArray objectAtIndex:row];
    }
}

#pragma mark -
#pragma mark search action

-(void) searchAction:(id) sender {
    NSMutableDictionary *dict;
    if (self.searchType == 0) {
        dict = [NSMutableDictionary dictionary];
        [dict setObject:[NSNumber numberWithInt:self.searchType] forKey:@"searchtype"];
        [dict setObject:startAge forKey:@"startage"];
        [dict setObject:endAge forKey:@"endage"];
        [dict setObject:startHeight forKey:@"startheight"];
        [dict setObject:endHeight forKey:@"endheight"];
        [dict setObject:[NSNumber numberWithInt:provinceId] forKey:@"provinceid"];
        [dict setObject:[NSNumber numberWithInt:cityId] forKey:@"cityid"];
        [dict setObject:education forKey:@"education"];
        [dict setObject:salary forKey:@"salary"];
        [dict setObject:marryStatus forKey:@"marrystatus"];
        [dict setObject:housing forKey:@"housing"];
        [dict setObject:caring forKey:@"caring"];
        [dict setObject:children forKey:@"children"];
        [dict setObject:lovekind forKey:@"lovekind"];
        [dict setObject:havepic forKey:@"havepic"];
    } else if (self.searchType == 1) {
        dict = [NSMutableDictionary dictionary];
        [dict setObject:[NSNumber numberWithInt:self.searchType] forKey:@"searchtype"];
        [dict setObject:self.idField.text forKey:@"userid"];
    } else {
        dict = [NSMutableDictionary dictionary];
        [dict setObject:[NSNumber numberWithInt:self.searchType] forKey:@"searchtype"];
        [dict setObject:self.nickField.text forKey:@"username"];
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
    NSLog(@"search result: %@",dic);
    BSSearchResultViewController *searchResultViewController = [[BSSearchResultViewController alloc] init];
    searchResultViewController.userInfoDict = dic;
    [self.navigationController pushViewController:searchResultViewController animated:YES];
    [searchResultViewController release];
}

- (void) searchFailed:(id) sender data:(NSDictionary *) dic{
    NSLog(@"搜索出错了。");
}

//- (void)update{
//    //测试上传图片
//    NSString *filePath = [[[KBBreakpointTransmission instance] getTargetFloderPath:@"image"] stringByAppendingPathComponent:@"index2.jpg"];
//    
//    NSString *url = @"http://demo2.qnssy.com/demo/upload_demo.php";
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL: [NSURL URLWithString: url]];
//    [request setPostValue: @"true" forKey: @"is_phone"];
//    [request setPostValue:@"true" forKey:@"do_upload_file"];
//    [request setFile: filePath forKey: @"uploadedfile"];
//    [request buildRequestHeaders];
//    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
//    NSLog(@"header: %@", request.requestHeaders);
//    [request startSynchronous];
//    NSLog(@"responseString = %@", request.responseString);
//}

#pragma mark -
#pragma mark segment action
- (IBAction)segmentedAction:(UISegmentedControl *)sender {
    NSInteger index = sender.selectedSegmentIndex;
    self.searchType = index;
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark Memory Manage
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [super dealloc];
}
- (void)viewDidUnload {
    [super viewDidUnload];
}
@end
