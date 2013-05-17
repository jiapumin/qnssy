//
//  BSUserDetailInfoViewController.m
//  qnssy
//
//  Created by jpm on 13-3-31.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSUserDetailInfoViewController.h"

#import "BSUserDetailInfoTableViewCell1_iPhone.h"
#import "BSUserDetailInfoTableViewCell2_iPhone.h"
#import "BSUserDetailInfoTableViewCell3_iPhone.h"
#import "BSUserDetailInfoTableViewCell4_iPhone.h"
#import "BSUserDetailInfoTableViewCell5_iPhone.h"

#import "RecommendInfoResponseVo.h"
#import "RecommendInfoRequestVo.h"

@interface BSUserDetailInfoViewController (){
    MBProgressHUD *progressHUD;
}
@end

@implementation BSUserDetailInfoViewController

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
    
    [self initHUDView];
    
    [self loadServiceData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_userInfoDic release];
    [_userId release];
    [_myTableView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setUserInfoDic:nil];
    [self setUserId:nil];
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
    RecommendInfoRequestVo *vo = [[RecommendInfoRequestVo alloc] initWithForId:self.userId];
    [[BSContainer instance].serviceAgent callServletWithObject:self
                                                   requestDict:vo.mReqDic
                                                        target:self
                                               successCallBack:@selector(requestSucceess:data:)
                                                  failCallBack:@selector(requestFailed:data:)];
    
    [vo release];
}
#pragma mark - 回调方法

- (void)requestSucceess:(id)sender data:(NSDictionary *)dic {
    
    RecommendInfoResponseVo *vo = [[RecommendInfoResponseVo alloc] initWithDic:dic];
    
    self.userInfoDic = vo.infoDic;
    
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
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 75.f;
        }else if (indexPath.row == 1){
            return 100.f;
        }else if (indexPath.row == 2){
            return 75.f;
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            NSString *title = [self.userInfoDic objectForKey:@"infelt"];
            CGSize textSize = [title
                               sizeWithFont:[UIFont systemFontOfSize:14.f]
                               constrainedToSize:CGSizeMake(280, CGFLOAT_MAX)
                               lineBreakMode:UILineBreakModeCharacterWrap];
            return textSize.height + 20;
        }
        
    }else if (indexPath.section == 2 ||indexPath.section == 3){
        return 44.f;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else if (section == 1){
        return 36;
        
    }else if (section == 2){
        return 36;
    }
    else if (section == 3){
        return 36;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *title = @"";
    if (section == 0) {
        UIView *headView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)] autorelease];
        headView.backgroundColor = [UIColor redColor];
        return headView;
    }else if (section == 1){
        title = @"内心独白";
        
    }else if (section == 2){
        title = @"基本资料";
    }
    else if (section == 3){
        title = @"择偶条件";
    }

    UIView *headView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 36)] autorelease];
    headView.backgroundColor = [UIColor clearColor];
    UIImageView *headBgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"7标题背景"]];
    headBgImageView.frame = CGRectMake(10, 3, 300, 30);
    [headView addSubview:headBgImageView];
    [headBgImageView release];
    
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(23, 3, 280, 30)];
    headLabel.backgroundColor = [UIColor clearColor];
    UIColor *color1 = [UIColor colorWithRed:198/255.f green:21/255.f blue:73/277.f alpha:1.f];
    headLabel.textColor = color1;
    headLabel.font = [UIFont systemFontOfSize:16.f];
    headLabel.text = title;
     [headView addSubview:headLabel];
    [headLabel release];
    
    return headView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        return 5;
    }else if (section == 3){
        return 4;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"BSUserDetailInfoTableViewCell1_iPhone" owner:tableView options:nil];
            BSUserDetailInfoTableViewCell1_iPhone *cell = [nib objectAtIndex:0];
            
            [cell reloadData:self.userInfoDic];
            
            
            return cell;
        }else if(indexPath.row == 1){
            NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"BSUserDetailInfoTableViewCell2_iPhone" owner:tableView options:nil];
            BSUserDetailInfoTableViewCell2_iPhone *cell = [nib objectAtIndex:0];
            
            [cell reloadData:self.userInfoDic];
            
            
            return cell;
        }else if(indexPath.row == 2){
            NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"BSUserDetailInfoTableViewCell3_iPhone" owner:tableView options:nil];
            BSUserDetailInfoTableViewCell3_iPhone *cell = [nib objectAtIndex:0];
            
            cell.userVo = self.userInfoDic;
            
            return cell;
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"BSUserDetailInfoTableViewCell4_iPhone" owner:tableView options:nil];
            BSUserDetailInfoTableViewCell4_iPhone *cell = [nib objectAtIndex:0];
            
            cell.myInfoLabel.text = [self.userInfoDic objectForKey:@"infelt"];
            CGSize textSize = [cell.myInfoLabel.text
                               sizeWithFont:cell.myInfoLabel.font
                               constrainedToSize:CGSizeMake(cell.myInfoLabel.frame.size.width, CGFLOAT_MAX)
                               lineBreakMode:UILineBreakModeCharacterWrap];
            [cell.myInfoLabel setFrame:CGRectMake(cell.myInfoLabel.frame.origin.x, cell.myInfoLabel.frame.origin.y, cell.myInfoLabel.frame.size.width, textSize.height)];
            
            return cell;
        }
    }else if (indexPath.section == 2){
        
        NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"BSUserDetailInfoTableViewCell5_iPhone" owner:tableView options:nil];
        BSUserDetailInfoTableViewCell5_iPhone *cell = [nib objectAtIndex:0];
        UIColor *color1 = [UIColor colorWithRed:198/255.f green:21/255.f blue:73/277.f alpha:1.f];
        cell.rightLabel.textColor = color1;
        NSDictionary *baseinfoDic = [self.userInfoDic objectForKey:@"baseinfo"];
        if (indexPath.row == 0) {
            cell.leftLabel.text = @"佳缘ID";
            cell.rightLabel.text = [baseinfoDic objectForKey:@"userid"];
        }else if(indexPath.row == 1){
            cell.leftLabel.text = @"学历";
            NSString *str = [self valueDicForKey:@"education" key:[baseinfoDic objectForKey:@"education"]];
            cell.rightLabel.text = str;
        }else if(indexPath.row == 2){
            cell.leftLabel.text = @"婚姻状况";
            NSString *str = [self valueDicForKey:@"marriageState" key:[baseinfoDic objectForKey:@"marriageState"]];
            cell.rightLabel.text = str;
            
        }else if(indexPath.row == 3){
            cell.leftLabel.text = @"月薪";
            NSString *str = [self valueDicForKey:@"wages" key:[baseinfoDic objectForKey:@"wages"]];
            cell.rightLabel.text = str;
        }else if(indexPath.row == 4){
            cell.leftLabel.text = @"住房情况";
            NSString *str = [self valueDicForKey:@"house" key:[baseinfoDic objectForKey:@"house"]];
            cell.rightLabel.text = str;
        }else if(indexPath.row == 5){
            cell.leftLabel.text = @"买车情况";
            NSString *str = [self valueDicForKey:@"car" key:[baseinfoDic objectForKey:@"car"]];
            cell.rightLabel.text = str;
        }
        
        
        return cell;

    }else if (indexPath.section == 3){
        
        NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"BSUserDetailInfoTableViewCell5_iPhone" owner:tableView options:nil];
        BSUserDetailInfoTableViewCell5_iPhone *cell = [nib objectAtIndex:0];
        UIColor *color1 = [UIColor colorWithRed:198/255.f green:21/255.f blue:73/277.f alpha:1.f];
        cell.rightLabel.textColor = color1;
        NSDictionary *spouseDic = [self.userInfoDic objectForKey:@"spouse"];
        if (indexPath.row == 0) {
            cell.leftLabel.text = @"年龄范围";
            NSString *str = [NSString stringWithFormat:@"%@岁-%@岁",[spouseDic objectForKey:@"startage"],[spouseDic objectForKey:@"endage"]];
            cell.rightLabel.text = str;
        }else if(indexPath.row == 1){
            cell.leftLabel.text = @"身高范围";
            NSString *str = [NSString stringWithFormat:@"%@厘米-%@厘米",[spouseDic objectForKey:@"startheight"],[spouseDic objectForKey:@"endheight"]];
            cell.rightLabel.text = str;
        }else if(indexPath.row == 2){
            cell.leftLabel.text = @"学历";
            NSString *str = [self valueDicForKey:@"education" key:[spouseDic objectForKey:@"education"]];
            cell.rightLabel.text = str;
            
        }else if(indexPath.row == 3){
            cell.leftLabel.text = @"所在地";
            NSString *str = [NSString stringWithFormat:@"%@ %@",[spouseDic objectForKey:@"taprovice"],[spouseDic objectForKey:@"tacity"]];
            cell.rightLabel.text = str;
        }
        
        return cell;
        
    }
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    return cell;
    
}

- (NSString *)valueDicForKey:(NSString *)key key:(NSString *)key1{
    NSDictionary *educationDic = [[DataParseUtil myInfoData:@"key"] objectAtIndex:1];
    NSString *str = [educationDic objectForKey:@"key1"];
    str = (str||[str isEqualToString:@""]) ? str : @"无";
    return str;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}


@end
