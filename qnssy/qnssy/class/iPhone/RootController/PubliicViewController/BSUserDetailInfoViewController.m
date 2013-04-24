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
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 75.f;
        }else if (indexPath.row == 1){
            return 100.f;
        }
    }else if (indexPath.section == 1){
        return 1;
    }else if (indexPath.section == 2){
        return 1;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        return 1;
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
        }else if(indexPath.row == 1){
            NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"BSUserDetailInfoTableViewCell3_iPhone" owner:tableView options:nil];
            BSUserDetailInfoTableViewCell3_iPhone *cell = [nib objectAtIndex:0];
            
            [cell reloadData:self.userInfoDic];
            
            
            return cell;
        }
    }else if (indexPath.section == 1){
        
    }else if (indexPath.section == 2){
        
    }
    

//
//    cell.menuLabel.text = [self.vcNameArrays objectAtIndex:indexPath.row];
//    
//    cell.noSelectedLeftImageName = [self.noSelectedLeftImageArrays objectAtIndex:indexPath.row];
//    
//    cell.selectedLeftImageName =[self.selectedLeftImageArrays objectAtIndex:indexPath.row];
//    
//    cell.noSelectedBgImageName = @"5其他选项未选中背景";
//    
//    cell.selectedBgImageName = @"5其他选项选中背景";
//    
//    cell.leftImage.image = [UIImage imageNamed:cell.noSelectedLeftImageName];
//    
//    cell.bgImage.image = [UIImage imageNamed:cell.noSelectedBgImageName];
    
//    return cell;
}

#pragma mark - Table view delegate
//- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    BSRootLeftTableCell_iPhone *cell = (BSRootLeftTableCell_iPhone *)[tableView cellForRowAtIndexPath:indexPath];
//    cell.bgImage.image = [UIImage imageNamed:cell.selectedBgImageName];
//    cell.leftImage.image = [UIImage imageNamed:cell.selectedLeftImageName];
//    cell.menuLabel.textColor = [UIColor colorWithRed:223.f/255 green:42.f/255 blue:106.f/255 alpha:1.f];
//    
//    return indexPath;
//    
//}
//- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
//    BSRootLeftTableCell_iPhone *cell = (BSRootLeftTableCell_iPhone *)[tableView cellForRowAtIndexPath:indexPath];
//    cell.bgImage.image = [UIImage imageNamed:cell.noSelectedBgImageName];
//    cell.leftImage.image = [UIImage imageNamed:cell.noSelectedLeftImageName];
//    cell.menuLabel.textColor = [UIColor blackColor];
//    return indexPath;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UIViewController *vc = [self.vcArrays objectAtIndex:indexPath.row];
//    
//    [self.revealSideViewController popViewControllerWithNewCenterController:vc
//                                                                   animated:YES];
//    
//}


@end
