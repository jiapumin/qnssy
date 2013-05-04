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
    int provinceId;
    int cityId;
}

@property (assign, nonatomic) int searchType;
@property (retain, nonatomic) NSArray *searchCriteria;
@property (retain, nonatomic) UISegmentedControl *sexControl;
@property (retain, nonatomic) UIView *areaView;


@property (retain, nonatomic) NSString *provinceName;
@property (retain, nonatomic) NSString *cityName;
@property (retain, nonatomic) NSString *startAge;
@property (retain, nonatomic) NSString *endAge;
@property (retain, nonatomic) NSString *startHeight;
@property (retain, nonatomic) NSString *endHeight;
@property (retain, nonatomic) NSString *education;
@property (retain, nonatomic) NSString *salary;
@property (retain, nonatomic) NSString *marryStatus;
@property (retain, nonatomic) NSString *housing;
@property (retain, nonatomic) NSString *caring;
@property (retain, nonatomic) NSString *children;
@property (retain, nonatomic) NSString *lovekind;
@property (retain, nonatomic) NSString *havepic;
@property (retain, nonatomic) NSString *searchID;
@property (retain, nonatomic) NSString *searchNickName;

@end

@implementation BSSearchViewController_iPhone

- (void)dealloc {
    [_searchCriteria release];
    [_sexControl release];
    [_searchTypeControl release];
    [_areaView release];
    
    [_provinceName release];
    [_cityName release];
    [_startAge release];
    [_endAge release];
    [_startHeight release];
    [_endHeight release];
    [_education release];
    [_salary release];
    [_marryStatus release];
    [_housing release];
    [_caring release];
    [_children release];
    [_lovekind release];
    [_havepic release];
    [_searchID release];
    [_searchNickName release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        @autoreleasepool {
            self.searchCriteria = @[@"性别", ];
            self.sexControl = [[[UISegmentedControl alloc] initWithItems:@[@"男性", @"女性"]] autorelease];
            self.sexControl.segmentedControlStyle = UISegmentedControlStyleBar;
            self.sexControl.selectedSegmentIndex = 0;
            self.sexControl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        }
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
    self.provinceName = [[self.provinceArray objectAtIndex:0] areaName];
    self.cityName = [[self.cityArray objectAtIndex:0] areaName];
    //省、市
    provinceId = [[self.provinceArray objectAtIndex:0] areaId];
    cityId = [[self.cityArray objectAtIndex:0] areaId];
    //年龄范围
    self.startAge = [self.startAgeArray objectAtIndex:0];
    self.endAge = [self.endAgeArray objectAtIndex:0];
    //身高范围
    self.startHeight = [self.startHeightArray objectAtIndex:0];
    self.endHeight = [self.endHeightArray objectAtIndex:0];
    
    
    UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 280, 44)];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton setBackgroundImage:[UIImage imageNamed:@"2下一步背景@2x.png"] forState:UIControlStateNormal];
    // add search action
    [searchButton addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableView setTableFooterView:searchButton];
    
    [searchButton release];
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchType == 0) {
        return 12;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     NSString *CellIdentifier = [self.searchTypeControl titleForSegmentAtIndex:self.searchTypeControl.selectedSegmentIndex];
    if (self.searchTypeControl.selectedSegmentIndex == 0 && indexPath.row == 0) {
        CellIdentifier = [CellIdentifier stringByAppendingString:@"sex"];
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if (self.searchType == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        switch (indexPath.row) {
            case 0: {
                cell.textLabel.text = @"性别";
                CGSize contentSize = cell.contentView.bounds.size;
                CGSize size = self.sexControl.frame.size;
                CGRect rect;
                rect.origin = CGPointMake(contentSize.width-size.width,
                                          (contentSize.height - size.height) / 2.f);
                rect.size = size;
                self.sexControl.frame = rect;
                
                [self.sexControl removeFromSuperview];
                [cell.contentView addSubview:self.sexControl];
                
                cell.accessoryType = UITableViewCellAccessoryNone;
                break;
            }
            case 1:
                cell.textLabel.text = @"所在地区";
                if (self.provinceName && self.cityName) {
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@",self.provinceName, self.cityName];
                }
                
                break;
            case 2:
                cell.textLabel.text = @"年龄范围";
                if (self.startAge && self.endAge) {
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@",self.startAge, self.endAge];
                }
                
                break;
            case 3:
                cell.textLabel.text = @"身高范围";
                if (self.startHeight && self.endHeight) {
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@",self.startHeight, self.endHeight];
                }
                
                break;
            case 4:
                cell.textLabel.text = @"学历";
                if (self.education) {
                    cell.detailTextLabel.text = self.education;
                }
                
                break;
            case 5:
                cell.textLabel.text = @"月薪";
                if (self.salary) {
                    cell.detailTextLabel.text = self.salary;
                }
                
                break;
            case 6:
                cell.textLabel.text = @"婚姻状况";
                if (self.marryStatus) {
                    cell.detailTextLabel.text = self.marryStatus;
                }
                
                break;
            case 7:
                cell.textLabel.text = @"住房情况";
                if (self.housing) {
                    cell.detailTextLabel.text = self.housing;
                }
                
                break;
            case 8:
                cell.textLabel.text = @"购车情况";
                if (self.caring) {
                    cell.detailTextLabel.text = self.caring;
                }
                
                break;
            case 9:
                cell.textLabel.text = @"有无子女";
                if (self.children) {
                    cell.detailTextLabel.text = self.children;
                }

                break;
            case 10:
                cell.textLabel.text = @"交友类型";
                if (self.lovekind) {
                    cell.detailTextLabel.text = self.lovekind;
                }
                
                break;
            case 11:
                cell.textLabel.text = @"照片";
                if (self.havepic) {
                    cell.detailTextLabel.text = self.havepic;
                }
                
                break;
            default:
                break;
        }
        
    } else if(self.searchType == 1){
        if (indexPath.row == 0) {
            UITextField *field =[[UITextField alloc] initWithFrame:CGRectMake(0, 5, 280, 34)];
            self.idField = field;
            self.idField.placeholder = @"请输入您要搜索的千千缘ID";
            self.idField.borderStyle = UITextBorderStyleRoundedRect;
            self.idField.delegate = self;
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            [cell addSubview:self.idField];
            [field release];
        }
        if (indexPath.row == 1) {
            for (UILabel *label in cell.subviews) {
                [label removeFromSuperview];
            }
            cell.accessoryType = UITableViewCellAccessoryNone;
//            [cell addSubview:searchButton];
//            [searchButton release];
        }
//        return cell;
    } else {
        if (indexPath.row == 0) {
            UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(0, 5, 280, 34)];
            self.nickField = field;
            self.nickField.placeholder = @"请输入您要搜索的千千缘昵称";
            self.nickField.borderStyle = UITextBorderStyleRoundedRect;
            self.nickField.delegate = self;
            for (UILabel *label in cell.subviews) {
                [label removeFromSuperview];
            }
            cell.accessoryType = UITableViewCellAccessoryNone;
            [cell addSubview:self.nickField];
            [field release];
        }
        if (indexPath.row == 1) {
            for (UILabel *label in cell.subviews) {
                [label removeFromSuperview];
            }
            cell.accessoryType = UITableViewCellAccessoryNone;
//            [cell addSubview:searchButton];
//            [searchButton release];
        }
        return cell;
    }
    
    return cell;
}

-(void) getAreaPicker {
    [self doneBtnPressToGetArea];
    
    if (self.areaView == nil) {
        UIView *viewForAreaPicker = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, 320, 250)];
        self.areaView = viewForAreaPicker;
        
        UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
        toolBar.barStyle = UIBarStyleBlackTranslucent;
        
        UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneBtnPressToGetArea)];
        
        [toolBar setItems:[NSArray arrayWithObject:btn]];
        [viewForAreaPicker addSubview:toolBar];
        
        UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, 320, 210)];
        self.areaPickerView = picker;
        picker.delegate=self;
        picker.dataSource=self;
        picker.showsSelectionIndicator=YES;
        
        [viewForAreaPicker addSubview:self.areaPickerView];
        
        [self.view addSubview:viewForAreaPicker];
        
        [picker release];
        [btn release];
        [toolBar release];
        [viewForAreaPicker release];
    }
    
    [UIView beginAnimations:@"showSearchView" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationRepeatCount:1];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationDelegate:self.areaPickerView];
    [UIView setAnimationDidStopSelector:@selector(reloadAllComponents)];
    
    CGPoint point = self.areaView.center;
    point.y = self.navigationController.view.frame.size.height-(self.areaView.frame.size.height/2)-10;
    self.areaView.center = point;
    
    [UIView commitAnimations];
}

-(void) doneBtnPressToGetArea {
    [UIView beginAnimations:@"showSearchView" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationRepeatCount:1];
    [UIView setAnimationRepeatAutoreverses:NO];
    
    CGPoint point = self.areaView.center;
    point.y = self.navigationController.view.frame.size.height + (self.areaView.frame.size.height/2);
    self.areaView.center = point;
    
    [UIView commitAnimations];
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedRow = indexPath.row;
    if (self.searchType == 0 && selectedRow > 0) {
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
            self.provinceName = [[self.provinceArray objectAtIndex:row] areaName];
            self.cityArray = [[AreaDatabase database] getCityWithProvinceId:areaid];
            self.cityName = [[self.cityArray objectAtIndex:0] areaName];
            provinceId = [[self.provinceArray objectAtIndex:row] areaId];
            cityId = [[self.cityArray objectAtIndex:0] areaId];
            [self.areaPickerView reloadComponent:1];
        } else {
            self.cityName = [[self.cityArray objectAtIndex:row] areaName];
            cityId = [[self.cityArray objectAtIndex:row] areaId];
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        LabelCell *cell = (LabelCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@",self.provinceName,self.cityName];
    }
    if (selectedRow == 2) {
        if (component == 0) {
            self.startAge = [self.startAgeArray objectAtIndex:row];
        } else {
            self.endAge = [self.endAgeArray objectAtIndex:row];
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
        LabelCell *cell = (LabelCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        if (row == 0) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ 到 %@",self.startAge, self.endAge];
        } else {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ 到 %@ 岁",self.startAge, self.endAge];
        }
    }
    if (selectedRow == 3) {
        if (component == 0) {
            self.startHeight = [self.startHeightArray objectAtIndex:row];
        } else {
            self.endHeight = [self.endHeightArray objectAtIndex:row];
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
        LabelCell *cell = (LabelCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ 到 %@ 厘米",self.startHeight, self.endHeight];
    }
    if (selectedRow == 4) {
        if (row == 0) {
            self.education = @"0";
        } else {
            self.education = [NSString stringWithFormat:@"%d",row];
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:4 inSection:0];
        LabelCell *cell = (LabelCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.detailTextLabel.text = [self.educationArray objectAtIndex:row];
    }
    if (selectedRow == 5) {
        if (row == 0) {
            self.salary = @"0";
        } else {
            self.salary = [NSString stringWithFormat:@"%d",row];
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        LabelCell *cell = (LabelCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.detailTextLabel.text = [self.salaryArray objectAtIndex:row];
    }
    if (selectedRow == 6) {
        if (row == 0) {
            self.marryStatus = @"0";
        } else {
            self.marryStatus = [NSString stringWithFormat:@"%d",row];
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:6 inSection:0];
        LabelCell *cell = (LabelCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.detailTextLabel.text = [self.marryStatusArray objectAtIndex:row];
    }
    if (selectedRow == 7) {
        if (row == 0) {
            self.housing = @"0";
        } else {
            self.housing = [NSString stringWithFormat:@"%d",row];
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:7 inSection:0];
        LabelCell *cell = (LabelCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.detailTextLabel.text = [self.housingArray objectAtIndex:row];
    }
    if (selectedRow == 8) {
        if (row == 0) {
            self.caring = @"0";
        } else {
            self.caring = [NSString stringWithFormat:@"%d",row];
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:8 inSection:0];
        LabelCell *cell = (LabelCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.detailTextLabel.text = [self.caringArray objectAtIndex:row];
    }
    if (selectedRow == 9) {
        if (row == 0) {
            self.children = @"0";
        } else {
            self.children = [NSString stringWithFormat:@"%d",row];
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:9 inSection:0];
        LabelCell *cell = (LabelCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.detailTextLabel.text = [self.childrenArray objectAtIndex:row];
    }
    if (selectedRow == 10) {
        if (row == 0) {
            self.lovekind = @"0";
        } else {
            self.lovekind = [NSString stringWithFormat:@"%d",row];
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:10 inSection:0];
        LabelCell *cell = (LabelCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.detailTextLabel.text = [self.lovekinkArray objectAtIndex:row];
    }
    if (selectedRow == 11) {
        if (row == 0) {
            self.havepic = @"0";
        } else {
            self.havepic = [NSString stringWithFormat:@"%d",row];
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:11 inSection:0];
        LabelCell *cell = (LabelCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.detailTextLabel.text = [self.havepicArray objectAtIndex:row];
    }
}

#pragma mark -
#pragma mark search action

-(void) searchAction:(id) sender {
    NSMutableDictionary *dict;
    if (self.searchType == 0) {
        dict = [NSMutableDictionary dictionary];
        [dict setObject:[NSNumber numberWithInt:self.searchType] forKey:@"searchtype"];
        [dict setObject:self.startAge forKey:@"startage"];
        [dict setObject:self.endAge forKey:@"endage"];
        [dict setObject:self.startHeight forKey:@"startheight"];
        [dict setObject:self.endHeight forKey:@"endheight"];
        [dict setObject:[NSNumber numberWithInt:provinceId] forKey:@"provinceid"];
        [dict setObject:[NSNumber numberWithInt:cityId] forKey:@"cityid"];
        [dict setObject:self.education forKey:@"education"];
        [dict setObject:self.salary forKey:@"salary"];
        [dict setObject:self.marryStatus forKey:@"marrystatus"];
        [dict setObject:self.housing forKey:@"housing"];
        [dict setObject:self.caring forKey:@"caring"];
        [dict setObject:self.children forKey:@"children"];
        [dict setObject:self.lovekind forKey:@"lovekind"];
        [dict setObject:self.havepic forKey:@"havepic"];
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
- (void)viewDidUnload {
    [self setSearchTypeControl:nil];
    [super viewDidUnload];
}
@end
