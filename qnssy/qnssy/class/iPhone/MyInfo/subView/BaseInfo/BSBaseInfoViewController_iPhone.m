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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"基本资料";
    
    self.commitData = [[[NSMutableDictionary alloc] initWithCapacity:25] autorelease];
    
    
    UIButton *topRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //按钮大小
    CGRect btnFrame = CGRectMake(0.0, 4.0, 29.0, 25.0);
    topRightButton.frame = btnFrame;
    
    [topRightButton setImage:[UIImage imageNamed:@"5菜单列表图片"]
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
    
    self.myBaseInfo = vo.myBaseInfo;
    
    self.myBaseInfoKey = [NSMutableArray arrayWithArray:[self.myBaseInfo allKeys]];
    //areaid、areaname、cityname、nationalprovincename、provincename、userimg、username
    [self.myBaseInfoKey removeObject:@"areaid"];
//    [self.myBaseInfoKey removeObject:@"areaname"];
    [self.myBaseInfoKey removeObject:@"cityid"];
//    [self.myBaseInfoKey removeObject:@"nationalprovincename"];
    [self.myBaseInfoKey removeObject:@"provinceid"];
    [self.myBaseInfoKey removeObject:@"userimg"];
//    [self.myBaseInfoKey removeObject:@"username"];
    
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
    // 去掉areaid、areaname、cityname、nationalprovincename、provincename、userimg、username
//    int num = [self.myBaseInfoKey count];
    return 25;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.f;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"BaseInfoTableViewCell_iPhone" owner:tableView options:nil];
    BaseInfoTableViewCell_iPhone *cell = [nib objectAtIndex:0];

    
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.leftLabel.text = @"登录邮箱";
        cell.rightLabel.text = [self.myBaseInfo objectForKey:@"email"];
        cell.key = @"email";
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }else if (indexPath.section == 0 && indexPath.row == 1) {
        cell.leftLabel.text = @"会员名称";
        cell.rightLabel.text = [self.myBaseInfo objectForKey:@"username"];//单独处理
        cell.key = @"username";
    }else if (indexPath.section == 0 && indexPath.row == 2) {
        cell.leftLabel.text = @"性别";
        cell.rightLabel.text = [self stringFormat:@"sex"];
        cell.key = @"sex";
    }else if (indexPath.section == 0 && indexPath.row == 3) {
        cell.leftLabel.text = @"年龄";
        cell.rightLabel.text = [self stringFormat:@"age"];
        cell.key = @"age";
    }else if (indexPath.section == 0 && indexPath.row == 4) {
        cell.leftLabel.text = @"婚姻状态";
        cell.rightLabel.text = [self stringFormat:@"marrystatus"];
        cell.key = @"marrystatus";
    }else if (indexPath.section == 0 && indexPath.row == 5) {
        cell.leftLabel.text = @"身高";
        cell.rightLabel.text = [self stringFormat:@"height"];
        cell.key = @"height";
    }else if (indexPath.section == 0 && indexPath.row == 6) {
        cell.leftLabel.text = @"血型";
        cell.rightLabel.text = [self stringFormat:@"blood"];
        cell.key = @"blood";
    }else if (indexPath.section == 0 && indexPath.row == 7) {
        cell.leftLabel.text = @"有无子女";
        cell.rightLabel.text = [self stringFormat:@"childrenstatus"];
        cell.key = @"childrenstatus";
    }else if (indexPath.section == 0 && indexPath.row == 8) {
        cell.leftLabel.text = @"国籍";
        cell.rightLabel.text = [self stringFormat:@"nationality"];
        cell.key = @"nationality";
    }else if (indexPath.section == 0 && indexPath.row == 9) {
        cell.leftLabel.text = @"户籍";
        cell.rightLabel.text = [NSString stringWithFormat:@"%@-%@",[self stringFormat:@"nationalprovinceid"],[self stringFormat:@"nationalcityid"]];
        cell.key = @"nationalprovinceid";
    }else if (indexPath.section == 0 && indexPath.row == 10) {
        cell.leftLabel.text = @"所在地区";
        cell.rightLabel.text = [NSString stringWithFormat:@"%@-%@-%@",[self stringFormat:@"provinceid"],[self stringFormat:@"cityid"],[self stringFormat:@"areaid"]];
        cell.key = @"provinceid";
    }else if (indexPath.section == 0 && indexPath.row == 11) {
        cell.leftLabel.text = @"交友类型";
        cell.rightLabel.text = [self stringFormat:@"lovekind"];
        cell.key = @"lovekind";
    }else if (indexPath.section == 0 && indexPath.row == 12) {
        cell.leftLabel.text = @"个性";
        cell.rightLabel.text = [self stringFormat:@"personality"];
        cell.key = @"personality";
    }else if (indexPath.section == 0 && indexPath.row == 13) {
        cell.leftLabel.text = @"民族";
        cell.rightLabel.text = [self stringFormat:@"national"];
        cell.key = @"national";
    }else if (indexPath.section == 0 && indexPath.row == 14) {
        cell.leftLabel.text = @"所在行业";
        cell.rightLabel.text = [self stringFormat:@"jobs"];
        cell.key = @"jobs";
    }else if (indexPath.section == 0 && indexPath.row == 15) {
        cell.leftLabel.text = @"月薪";
        cell.rightLabel.text = [self stringFormat:@"salary"];
        cell.key = @"salary";
    }else if (indexPath.section == 0 && indexPath.row == 16) {
        cell.leftLabel.text = @"居住情况";
        cell.rightLabel.text = [self stringFormat:@"housing"];
        cell.key = @"housing";
    }else if (indexPath.section == 0 && indexPath.row == 17) {
        cell.leftLabel.text = @"购车情况";
        cell.rightLabel.text = [self stringFormat:@"caring"];
        cell.key = @"caring";
    }else if (indexPath.section == 0 && indexPath.row == 18) {
        cell.leftLabel.text = @"体重";
        cell.rightLabel.text = [self stringFormat:@"weight"];
        cell.key = @"weight";
    }else if (indexPath.section == 0 && indexPath.row == 19) {
        cell.leftLabel.text = @"外貌自评";
        cell.rightLabel.text = [self stringFormat:@"profile"];
        cell.key = @"profile";
    }else if (indexPath.section == 0 && indexPath.row == 20) {
        cell.leftLabel.text = @"魅力部位";
        cell.rightLabel.text = [self stringFormat:@"charmparts"];
        cell.key = @"charmparts";
    }else if (indexPath.section == 0 && indexPath.row == 21) {
        cell.leftLabel.text = @"发型";
        cell.rightLabel.text = [self stringFormat:@"hairstyle"];
        cell.key = @"hairstyle";
    }else if (indexPath.section == 0 && indexPath.row == 22) {
        cell.leftLabel.text = @"发色";
        cell.rightLabel.text = [self stringFormat:@"haircolor"];
        cell.key = @"haircolor";
    }else if (indexPath.section == 0 && indexPath.row == 23) {
        cell.leftLabel.text = @"脸型";
        cell.rightLabel.text = [self stringFormat:@"facestyle"];
        cell.key = @"facestyle";
    }else if (indexPath.section == 0 && indexPath.row == 24) {
        cell.leftLabel.text = @"体型";
        cell.rightLabel.text = [self stringFormat:@"bodystyle"];
        cell.key = @"bodystyle";
    }

//    NSString *key = [self.myBaseInfoKey objectAtIndex:indexPath.row];
//    
//    cell.key = key;
//    
//    if ([key isEqualToString:@"cityname"] ) {
//        cell.leftLabel.text = @"所在地";
//        cell.rightLabel.text = [self.myBaseInfo objectForKey:key];
//        return cell;
//    }
//    if ( [key isEqualToString:@"email"]) {
//        cell.leftLabel.text = @"邮箱";
//        cell.rightLabel.text = [self.myBaseInfo objectForKey:key];
//        [cell setAccessoryType:UITableViewCellAccessoryNone];
//        //此行不可编辑
//        return cell;
//    }
//
//    NSArray * infoArray = [DataParseUtil myInfoData:key];
//    //赋值用户信息
//    cell.leftLabel.text = [infoArray objectAtIndex:0];
//    
//    NSDictionary *infoDesDic = [infoArray objectAtIndex:1];
//    
//    if (infoDesDic && infoDesDic.count != 0) {
//        NSString *content = [infoDesDic objectForKey:[self.myBaseInfo objectForKey:key]];
//        cell.rightLabel.text = [content isEqualToString:@""] || content == nil ? @"无" : content;
//    }else{
//        
//        cell.rightLabel.text = @"无";
//    }
    
    
    
    return cell;
}

- (NSString *)stringFormat:(NSString *)key{
    NSArray * infoArray = [DataParseUtil myInfoData:key];
//    //赋值用户信息
//    cell.leftLabel.text = [infoArray objectAtIndex:0];

    NSDictionary *infoDesDic = [infoArray objectAtIndex:1];
    
    NSString *content = [infoDesDic objectForKey:[self.myBaseInfo objectForKey:key]];
    
    content = [content isEqualToString:@""] || content == nil ? @"无" : content;
    
    return content;
    
//    NSString *str = [self.myBaseInfo objectForKey:@"email"];
//    return  str ? str : @"";
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    
    
    BaseInfoTableViewCell_iPhone *cell = (BaseInfoTableViewCell_iPhone *)[tableView cellForRowAtIndexPath:indexPath];
    
    if ( [cell.key isEqualToString:@"email"]) return;//此行不可编辑
    
    if ([cell.key isEqualToString:@"username"]) {//用户名
        
        return;
    }
    if ([cell.key isEqualToString:@"nationalprovinceid"]) {//户籍
        
        return;
    }
    if ([cell.key isEqualToString:@"provinceid"]) {//所在地
        
        return;
    }
    
    [self cellAction:cell];
    
    
    
//    NSMutableDictionary *aa = [[NSMutableDictionary alloc] init];
//    for (int i = 18; i<100; i++) {
//       [aa setObject:[NSString stringWithFormat:@"%d",i] forKey:[NSString stringWithFormat:@"%d",i]];
//        
//    }
//    NSLog(@"%@",aa);
}

- (void)cellAction:(BaseInfoTableViewCell_iPhone *)cell {
    
    
    NSString *key = cell.key;
    
    NSArray * infoArray = [DataParseUtil myInfoData:key];
    //赋值用户信息
    NSString *title = [infoArray objectAtIndex:0];
    
    NSDictionary *infoDesDic = [infoArray objectAtIndex:1];
    
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        cell.rightLabel.text = [NSString stringWithFormat:@"%@",selectedValue];
        NSString *tempValue = [NSString stringWithFormat:@"%d",selectedIndex];
        [self.commitData setObject:tempValue forKey:key];
    };
    
    //排序
    NSMutableArray *keyArray = [NSMutableArray arrayWithArray:[infoDesDic allKeys]];
    [keyArray sortUsingSelector:@selector(compare:)];
    NSMutableArray *dataArray = [[NSMutableArray alloc] initWithCapacity:keyArray.count];
    for (NSString *key in  [keyArray objectEnumerator]) {
        [dataArray addObject:[infoDesDic objectForKey:key]];
    }
    
    
    [ActionSheetStringPicker showPickerWithTitle:title rows:dataArray initialSelection:dataArray.count/2 doneBlock:done cancelBlock:nil origin:cell];
    [dataArray release];
}
- (void)commitChange{
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
    

    if (vo.status != 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:vo.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    
    [progressHUD hide:YES];
    
    [vo release];
    [self.myTableView reloadData];
}


- (void)requestCommitFailed:(id)sender data:(NSDictionary *)dic {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"网络异常，请检查网络连接后重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    [progressHUD hide:YES];
}

@end
