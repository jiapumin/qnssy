//
//  BSMyAttentionViewController_iPhone.m
//  qnssy
//
//  Created by jpm on 13-4-14.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSBaseInfoViewController_iPhone.h"

#import "BaseInfoTableViewCell_iPhone.h"

#import "BaseInfoRequestVo.h"
#import "BaseInfoResponseVo.h"

#import "ChangeBaseInfoRequestVo.h"
#import "ChangeBaseInfoResponseVo.h"

#import "ActionSheetStringPicker.h"

#import "WorkAreaPickerViewDelegate.h"

#import "ActionSheetCustomPicker.h"

#import "AreaDatabase.h"
#import "AreaInfo.h"

@interface BSBaseInfoViewController_iPhone (){
    MBProgressHUD *progressHUD;
}

@end

@implementation BSBaseInfoViewController_iPhone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.commitData = [[[NSMutableDictionary alloc] init] autorelease];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"基本资料";
    
    
    
    UIButton *topRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //按钮大小
    CGRect btnFrame = CGRectMake(0.0, 4.0, 42, 27.0);
    topRightButton.frame = btnFrame;
    
    [topRightButton setImage:[UIImage imageNamed:@"saveUserInfo"]
                   forState:UIControlStateNormal];
    
    [topRightButton addTarget:self
                      action:@selector(commitChange)
            forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * topRightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:topRightButton];
    
    [self.navigationItem setRightBarButtonItem:topRightBarButtonItem animated:YES];
    
    [topRightBarButtonItem release];
    
    //初始化加载框
    [self initHUDView];
    [self loadServiceData];
    
}
- (void)dealloc{
    [_tempWorkArea1 release];
    [_tempWorkArea2 release];
    [_usernameTextField release];
    [_commitData release];
    [_myBaseInfo release];
    [_myTableView release];
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidUnload {
    [self setCommitData:nil];
    [self setMyTableView:nil];
    [super viewDidUnload];
}
- (void)initHUDView{
    //-------加载框
    progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:progressHUD];
    
    progressHUD.labelText = @"数据加载中...";
    
}
- (void)loadServiceData{
    [progressHUD show:YES];
    BaseInfoRequestVo *vo = [[BaseInfoRequestVo alloc] init];
    [[BSContainer instance].serviceAgent callServletWithObject:self
                                                   requestDict:vo.mReqDic
                                                        target:self
                                               successCallBack:@selector(requestSucceess:data:)
                                                  failCallBack:@selector(requestFailed:data:)];
    
    [vo release];
}
#pragma mark - 回调方法

- (void)requestSucceess:(id)sender data:(NSDictionary *)dic {
    
    BaseInfoResponseVo *vo = [[BaseInfoResponseVo alloc] initWithDic:dic];
    
    self.myBaseInfo = [NSMutableDictionary dictionaryWithDictionary:vo.myBaseInfo];
    
    self.myBaseInfoKey = [NSMutableArray arrayWithArray:[self.myBaseInfo allKeys]];
    
    [self.commitData setObject:[self.myBaseInfo objectForKey:@"email"] forKey:@"email"];
    [self.commitData setObject:[self.myBaseInfo objectForKey:@"username"] forKey:@"username"];
    [self.commitData setObject:[self.myBaseInfo objectForKey:@"username"] forKey:@"oldusername"];//复制老的用户名
//    [self.commitData setObject:[self.myBaseInfo objectForKey:@"sex"] forKey:@"sex"];
    [self.commitData setObject:[self.myBaseInfo objectForKey:@"age"] forKey:@"age"];
    [self.commitData setObject:[self.myBaseInfo objectForKey:@"marrystatus"] forKey:@"marrystatus"];
    [self.commitData setObject:[self.myBaseInfo objectForKey:@"height"] forKey:@"height"];
    [self.commitData setObject:[self.myBaseInfo objectForKey:@"blood"] forKey:@"blood"];
    [self.commitData setObject:[self.myBaseInfo objectForKey:@"childrenstatus"] forKey:@"childrenstatus"];
    [self.commitData setObject:[self.myBaseInfo objectForKey:@"nationality"] forKey:@"nationality"];
    [self.commitData setObject:[self.myBaseInfo objectForKey:@"nationalprovinceid"] forKey:@"nationalprovinceid"];
    [self.commitData setObject:[self.myBaseInfo objectForKey:@"nationalcityid"] forKey:@"nationalcityid"];
    [self.commitData setObject:[self.myBaseInfo objectForKey:@"provinceid"] forKey:@"provinceid"];
    [self.commitData setObject:[self.myBaseInfo objectForKey:@"cityid"] forKey:@"cityid"];
    [self.commitData setObject:@"1" forKey:@"areaid"];
    [self.commitData setObject:[self.myBaseInfo objectForKey:@"lovekind"] forKey:@"lovekind"];
    [self.commitData setObject:[self.myBaseInfo objectForKey:@"personality"] forKey:@"personality"];
    [self.commitData setObject:[self.myBaseInfo objectForKey:@"national"] forKey:@"national"];
    [self.commitData setObject:[self.myBaseInfo objectForKey:@"jobs"] forKey:@"jobs"];
    [self.commitData setObject:[self.myBaseInfo objectForKey:@"salary"] forKey:@"salary"];
    [self.commitData setObject:[self.myBaseInfo objectForKey:@"housing"] forKey:@"housing"];
    [self.commitData setObject:[self.myBaseInfo objectForKey:@"caring"] forKey:@"caring"];
    [self.commitData setObject:[self.myBaseInfo objectForKey:@"weight"] forKey:@"weight"];
    [self.commitData setObject:[self.myBaseInfo objectForKey:@"profile"] forKey:@"profile"];
    [self.commitData setObject:[self.myBaseInfo objectForKey:@"charmparts"] forKey:@"charmparts"];
    [self.commitData setObject:[self.myBaseInfo objectForKey:@"hairstyle"] forKey:@"hairstyle"];
    [self.commitData setObject:[self.myBaseInfo objectForKey:@"haircolor"] forKey:@"haircolor"];
    [self.commitData setObject:[self.myBaseInfo objectForKey:@"facestyle"] forKey:@"facestyle"];
    [self.commitData setObject:[self.myBaseInfo objectForKey:@"bodystyle"] forKey:@"bodystyle"];
    [self.commitData setObject:[self.myBaseInfo objectForKey:@"education"] forKey:@"education"];

    if (vo.status != 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:vo.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    
    [progressHUD hide:YES];
    
    [vo release];
    [self.myTableView reloadData];
}


- (void)requestFailed:(id)sender data:(NSDictionary *)dic {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"网络异常，请检查网络连接后重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    [progressHUD hide:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.myBaseInfoKey == nil) {
        return 0;
    }
    return 26;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.f;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"BaseInfoTableViewCell_iPhone" owner:tableView options:nil];
    BaseInfoTableViewCell_iPhone *cell = [nib objectAtIndex:0];

    
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.leftLabel.text = @"登录邮箱";
        cell.rightLabel.text = [self.myBaseInfo objectForKey:@"email"];
        [self.commitData setObject:[self.myBaseInfo objectForKey:@"email"] forKey:@"email"];
        cell.key = @"email";
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }else if (indexPath.section == 0 && indexPath.row == 1) {
        cell.leftLabel.text = @"会员名称";
        cell.rightLabel.hidden = YES;
        cell.username.hidden = NO;
        cell.username.text = [self.myBaseInfo objectForKey:@"username"];//单独处理
        cell.username.delegate = self;
        self.usernameTextField = cell.username;
        
//        cell.rightLabel.text = [self.myBaseInfo objectForKey:@"username"];//单独处理
        [self.commitData setObject:[self.myBaseInfo objectForKey:@"username"] forKey:@"username"];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        cell.key = @"username";
    }else if (indexPath.section == 0 && indexPath.row == 2) {
        cell.leftLabel.text = @"性别";
        cell.rightLabel.text = [self stringFormat:@"sex"];
//        [self.commitData setObject:[self.myBaseInfo objectForKey:@"sex"] forKey:@"sex"];
        cell.key = @"sex";
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }else if (indexPath.section == 0 && indexPath.row == 3) {
        cell.leftLabel.text = @"年龄";
        cell.rightLabel.text = [self stringFormat:@"age"];
//        [self.commitData setObject:[self.myBaseInfo objectForKey:@"age"] forKey:@"age"];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        cell.key = @"age";
    }else if (indexPath.section == 0 && indexPath.row == 4) {
        cell.leftLabel.text = @"婚姻状态";
        cell.rightLabel.text = [self stringFormat:@"marrystatus"];
        [self.commitData setObject:[self.myBaseInfo objectForKey:@"marrystatus"] forKey:@"marrystatus"];
        cell.key = @"marrystatus";
    }else if (indexPath.section == 0 && indexPath.row == 5) {
        cell.leftLabel.text = @"身高";
        cell.rightLabel.text = [self stringFormat:@"height"];
        [self.commitData setObject:[self.myBaseInfo objectForKey:@"height"] forKey:@"height"];
        cell.key = @"height";
    }else if (indexPath.section == 0 && indexPath.row == 6) {
        cell.leftLabel.text = @"血型";
        cell.rightLabel.text = [self stringFormat:@"blood"];
        [self.commitData setObject:[self.myBaseInfo objectForKey:@"blood"] forKey:@"blood"];
        cell.key = @"blood";
    }else if (indexPath.section == 0 && indexPath.row == 7) {
        cell.leftLabel.text = @"有无子女";
        cell.rightLabel.text = [self stringFormat:@"childrenstatus"];
        [self.commitData setObject:[self.myBaseInfo objectForKey:@"childrenstatus"] forKey:@"childrenstatus"];
        cell.key = @"childrenstatus";
    }else if (indexPath.section == 0 && indexPath.row == 8) {
        cell.leftLabel.text = @"国籍";
        cell.rightLabel.text = [self stringFormat:@"nationality"];
        [self.commitData setObject:[self.myBaseInfo objectForKey:@"nationality"] forKey:@"nationality"];
        cell.key = @"nationality";
    }else if (indexPath.section == 0 && indexPath.row == 9) {
        cell.leftLabel.text = @"户籍";
        NSString *shengValue = [self.myBaseInfo objectForKey:@"nationalprovinceid"];
        NSString *shiValue = [self.myBaseInfo objectForKey:@"nationalcityid"];
        
        NSArray *shengArray =[[AreaDatabase database] getProvince];
        NSArray *shiArray = [[AreaDatabase database] getCityWithProvinceId:shengValue.intValue];
    
        NSString *sheng = nil;
        for (AreaInfo *area in [shengArray objectEnumerator]) {
            if (area.areaId == shengValue.intValue) {
                sheng = area.areaName;
                break;
            }
        }
        NSString *shi = nil;
        for (AreaInfo *area in [shiArray objectEnumerator]) {
            if (area.areaId == shiValue.intValue) {
                shi = area.areaName;
                break;
            }
        }
        
        cell.rightLabel.text = [NSString stringWithFormat:@"%@-%@",sheng,shi];
        [self.commitData setObject:[self.myBaseInfo objectForKey:@"nationalprovinceid"] forKey:@"nationalprovinceid"];
        [self.commitData setObject:[self.myBaseInfo objectForKey:@"nationalcityid"] forKey:@"nationalcityid"];
        cell.delegate = self;
        cell.key = @"nationalprovinceid";
    }else if (indexPath.section == 0 && indexPath.row == 10) {
        cell.leftLabel.text = @"所在地区";
        
        NSString *shengValue = [self.myBaseInfo objectForKey:@"nationalprovinceid"];
        NSString *shiValue = [self.myBaseInfo objectForKey:@"nationalcityid"];
        
        NSArray * shengArray =[[AreaDatabase database] getProvince];
        NSArray *shiArray = [[AreaDatabase database] getCityWithProvinceId:shengValue.intValue];
        
        NSString *sheng = nil;
        for (AreaInfo *area in [shengArray objectEnumerator]) {
            if (area.areaId == shengValue.intValue) {
                sheng = area.areaName;
                break;
            }
        }
        NSString *shi = nil;
        for (AreaInfo *area in [shiArray objectEnumerator]) {
            if (area.areaId == shiValue.intValue) {
                shi = area.areaName;
                break;
            }
        }
        
        cell.rightLabel.text = [NSString stringWithFormat:@"%@-%@",sheng,shi];
        [self.commitData setObject:[self.myBaseInfo objectForKey:@"provinceid"] forKey:@"provinceid"];
        [self.commitData setObject:[self.myBaseInfo objectForKey:@"cityid"] forKey:@"cityid"];
        cell.delegate = self;
        cell.key = @"provinceid";
    }else if (indexPath.section == 0 && indexPath.row == 11) {
        cell.leftLabel.text = @"交友类型";
        cell.rightLabel.text = [self stringFormat:@"lovekind"];
        [self.commitData setObject:[self.myBaseInfo objectForKey:@"lovekind"] forKey:@"lovekind"];
        cell.key = @"lovekind";
    }else if (indexPath.section == 0 && indexPath.row == 12) {
        cell.leftLabel.text = @"个性";
        cell.rightLabel.text = [self stringFormat:@"personality"];
        [self.commitData setObject:[self.myBaseInfo objectForKey:@"personality"] forKey:@"personality"];
        cell.key = @"personality";
    }else if (indexPath.section == 0 && indexPath.row == 13) {
        cell.leftLabel.text = @"民族";
        cell.rightLabel.text = [self stringFormat:@"national"];
        [self.commitData setObject:[self.myBaseInfo objectForKey:@"national"] forKey:@"national"];
        cell.key = @"national";
    }else if (indexPath.section == 0 && indexPath.row == 14) {
        cell.leftLabel.text = @"所在行业";
        cell.rightLabel.text = [self stringFormat:@"jobs"];
        [self.commitData setObject:[self.myBaseInfo objectForKey:@"jobs"] forKey:@"jobs"];
        cell.key = @"jobs";
    }else if (indexPath.section == 0 && indexPath.row == 15) {
        cell.leftLabel.text = @"月薪";
        cell.rightLabel.text = [self stringFormat:@"salary"];
        [self.commitData setObject:[self.myBaseInfo objectForKey:@"salary"] forKey:@"salary"];
        cell.key = @"salary";
    }else if (indexPath.section == 0 && indexPath.row == 16) {
        cell.leftLabel.text = @"居住情况";
        cell.rightLabel.text = [self stringFormat:@"housing"];
        [self.commitData setObject:[self.myBaseInfo objectForKey:@"housing"] forKey:@"housing"];
        cell.key = @"housing";
    }else if (indexPath.section == 0 && indexPath.row == 17) {
        cell.leftLabel.text = @"购车情况";
        cell.rightLabel.text = [self stringFormat:@"caring"];
        [self.commitData setObject:[self.myBaseInfo objectForKey:@"caring"] forKey:@"caring"];
        cell.key = @"caring";
    }else if (indexPath.section == 0 && indexPath.row == 18) {
        cell.leftLabel.text = @"体重";
        cell.rightLabel.text = [self stringFormat:@"weight"];
        [self.commitData setObject:[self.myBaseInfo objectForKey:@"weight"] forKey:@"weight"];
        cell.key = @"weight";
    }else if (indexPath.section == 0 && indexPath.row == 19) {
        cell.leftLabel.text = @"外貌自评";
        cell.rightLabel.text = [self stringFormat:@"profile"];
        [self.commitData setObject:[self.myBaseInfo objectForKey:@"profile"] forKey:@"profile"];
        cell.key = @"profile";
    }else if (indexPath.section == 0 && indexPath.row == 20) {
        cell.leftLabel.text = @"魅力部位";
        cell.rightLabel.text = [self stringFormat:@"charmparts"];
        [self.commitData setObject:[self.myBaseInfo objectForKey:@"charmparts"] forKey:@"charmparts"];
        cell.key = @"charmparts";
    }else if (indexPath.section == 0 && indexPath.row == 21) {
        cell.leftLabel.text = @"发型";
        cell.rightLabel.text = [self stringFormat:@"hairstyle"];
        [self.commitData setObject:[self.myBaseInfo objectForKey:@"hairstyle"] forKey:@"hairstyle"];
        cell.key = @"hairstyle";
    }else if (indexPath.section == 0 && indexPath.row == 22) {
        cell.leftLabel.text = @"发色";
        cell.rightLabel.text = [self stringFormat:@"haircolor"];
        [self.commitData setObject:[self.myBaseInfo objectForKey:@"haircolor"] forKey:@"haircolor"];
        cell.key = @"haircolor";
    }else if (indexPath.section == 0 && indexPath.row == 23) {
        cell.leftLabel.text = @"脸型";
        cell.rightLabel.text = [self stringFormat:@"facestyle"];
        [self.commitData setObject:[self.myBaseInfo objectForKey:@"facestyle"] forKey:@"facestyle"];
        cell.key = @"facestyle";
    }else if (indexPath.section == 0 && indexPath.row == 24) {
        cell.leftLabel.text = @"体型";
        cell.rightLabel.text = [self stringFormat:@"bodystyle"];
        [self.commitData setObject:[self.myBaseInfo objectForKey:@"bodystyle"] forKey:@"bodystyle"];
        cell.key = @"bodystyle";
    }else if (indexPath.section == 0 && indexPath.row == 25) {
        cell.leftLabel.text = @"教育程度";
        cell.rightLabel.text = [self stringFormat:@"education"];
        [self.commitData setObject:[self.myBaseInfo objectForKey:@"education"] forKey:@"education"];
        cell.key = @"education";
    }
    
    
    return cell;
}

- (NSString *)stringFormat:(NSString *)key{
    NSArray * infoArray = [DataParseUtil myInfoData:key];

    NSDictionary *infoDesDic = [infoArray objectAtIndex:1];
    
    NSString *content = [infoDesDic objectForKey:[self.myBaseInfo objectForKey:key]];
    
    content = [content isEqualToString:@""] || content == nil ? @"无" : content;
    
    return content;
    
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    BaseInfoTableViewCell_iPhone *cell = (BaseInfoTableViewCell_iPhone *)[tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell.key isEqualToString:@"email"] || [cell.key isEqualToString:@"sex"] || [cell.key isEqualToString:@"age"]) return;//此行不可编辑
    
    if ([cell.key isEqualToString:@"username"]) {//用户名
        [self.usernameTextField becomeFirstResponder];
        return;
    }
    if ([cell.key isEqualToString:@"nationalprovinceid"]) {//户籍
        self.tempWorkArea1 = [[[WorkAreaPickerViewDelegate alloc] init] autorelease];
        [ActionSheetCustomPicker showPickerWithTitle:@"户籍" delegate:self.tempWorkArea1 showCancelButton:NO origin:cell];
        return;
    }
    if ([cell.key isEqualToString:@"provinceid"]) {//所在地
        self.tempWorkArea2 = [[[WorkAreaPickerViewDelegate alloc] init] autorelease];
        [ActionSheetCustomPicker showPickerWithTitle:@"所在地" delegate:self.tempWorkArea2 showCancelButton:NO origin:cell];
        return;
    }
    
    [self cellAction:cell];
    //用户名键盘失去焦点
    [self.usernameTextField resignFirstResponder];
    
}

- (void)cellAction:(BaseInfoTableViewCell_iPhone *)cell {
    
    
    NSString *key = cell.key;
    
    NSArray * infoArray = [DataParseUtil myInfoData:key];
    //赋值用户信息
    NSString *title = [infoArray objectAtIndex:0];
    
    NSDictionary *infoDesDic = [infoArray objectAtIndex:1];
    
    //排序
    NSMutableArray *keyArray = [NSMutableArray arrayWithArray:[infoDesDic allKeys]];
    [keyArray sortUsingSelector:@selector(compare:)];
    NSMutableArray *dataArray = [[NSMutableArray alloc] initWithCapacity:keyArray.count];
    for (NSString *key in  [keyArray objectEnumerator]) {
        [dataArray addObject:[infoDesDic objectForKey:key]];
    }
    
    
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        cell.rightLabel.text = [NSString stringWithFormat:@"%@",selectedValue];
        NSString *tempValue = [keyArray objectAtIndex:selectedIndex];
        [self.commitData setObject:tempValue forKey:key];//要提交的数据
        [self.myBaseInfo setObject:tempValue forKey:key];//表格刷新的时候使用
    };
    

    
    [ActionSheetStringPicker showPickerWithTitle:title rows:dataArray initialSelection:dataArray.count/2 doneBlock:done cancelBlock:nil origin:cell];
    [dataArray release];
}
- (void)commitChange{
    NSString *username = self.usernameTextField.text;
    if (username==nil || [username isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"请输入用户名" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    [self.commitData setObject:username forKey:@"username"];
    

    
    [progressHUD show:YES];
    ChangeBaseInfoRequestVo *vo = [[ChangeBaseInfoRequestVo alloc] initWithData:self.commitData];
    [[BSContainer instance].serviceAgent callServletWithObject:self
                                                   requestDict:vo.mReqDic
                                                        target:self
                                               successCallBack:@selector(requestCommitSucceess:data:)
                                                  failCallBack:@selector(requestCommitFailed:data:)];
    
    [vo release];
}
#pragma mark - 回调方法

- (void)requestCommitSucceess:(id)sender data:(NSDictionary *)dic {
    
    ChangeBaseInfoResponseVo *vo = [[ChangeBaseInfoResponseVo alloc] initWithDic:dic];
    

    if (vo.status == 0) {
        [self.myTableView reloadData];
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:vo.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    [progressHUD hide:YES];

    [vo release];
    
}


- (void)requestCommitFailed:(id)sender data:(NSDictionary *)dic {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"网络异常，请检查网络连接后重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    [progressHUD hide:YES];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self.myBaseInfo setObject:textField.text forKey:@"username"];
}
@end
