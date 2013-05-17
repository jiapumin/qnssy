//
//  BSEveryDayMiaiDetailViewController_iPhone.m
//  qnssy
//
//  Created by jpm on 13-4-23.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSEveryDayMiaiDetailViewController_iPhone.h"

#import "EveryDayMiaiDetailRequestVo.h"
#import "EveryDayMiaiDetailResponseVo.h"

#import "BSEveryDayMiaiTableViewCell_iPhone.h"
#import "BSEveryDayMiaiDetailTableViewCell_iPhone.h"
#import "BSApplyViewController_iPhone.h"

@interface BSEveryDayMiaiDetailViewController_iPhone (){
    MBProgressHUD *progressHUD;
}

@end

@implementation BSEveryDayMiaiDetailViewController_iPhone

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
    self.title = @"天天相亲";
    
    //初始化加载框
    [self initHUDView];
    [self loadServiceData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initHUDView{
    //-------加载框
    progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:progressHUD];
    
    progressHUD.labelText = @"数据加载中...";
    
}
- (void)loadServiceData{
    [progressHUD show:YES];
    EveryDayMiaiDetailRequestVo *vo = [[EveryDayMiaiDetailRequestVo alloc] initWithId:[self.topDataDic objectForKey:@"datingid"]];
    [[BSContainer instance].serviceAgent callServletWithObject:self
                                                   requestDict:vo.mReqDic
                                                        target:self
                                               successCallBack:@selector(requestSucceess:data:)
                                                  failCallBack:@selector(requestFailed:data:)];
    
    [vo release];
}
#pragma mark - 回调方法

- (void)requestSucceess:(id)sender data:(NSDictionary *)dic {
    
    EveryDayMiaiDetailResponseVo *vo = [[EveryDayMiaiDetailResponseVo alloc] initWithDic:dic];
    
    self.dataDic = vo.dataDic;
    
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
    return 3;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return @"基本信息";
    }else if (section == 2){
        return @"约会安排";
    }else{
        return @"";
    }
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    
//    
//    return <#expression#>
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 3;
    }else if (section == 2){
        return 1;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 113.f;
    }else if (indexPath.section ==1){
        if (indexPath.row == 2) {
            NSString *content = [self yueHuiDuiXiang];
            
            CGSize textSize = [content
                               sizeWithFont:[UIFont systemFontOfSize:14.f]
                               constrainedToSize:CGSizeMake(206, CGFLOAT_MAX)
                               lineBreakMode:UILineBreakModeCharacterWrap];
            return textSize.height + 20.f;
        }
        return 44.f;
    }else if (indexPath.section ==2){
        
        NSString *content = [NSString stringWithFormat:@"%@",[self.dataDic objectForKey:@"content"]];

        CGSize textSize = [content
                           sizeWithFont:[UIFont systemFontOfSize:14.f]
                           constrainedToSize:CGSizeMake(206, CGFLOAT_MAX)
                           lineBreakMode:UILineBreakModeCharacterWrap];
        return textSize.height + 20.f;
    }
    
    return 44;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {
        NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"BSEveryDayMiaiTableViewCell_iPhone" owner:tableView options:nil];
        BSEveryDayMiaiTableViewCell_iPhone *cell = [nib objectAtIndex:0];

        cell.delegate = self;
        
        //赋值用户信息
        [cell reloadData:self.topDataDic];
        
        return cell;

    }else if(indexPath.section == 1){

        
        NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"BSEveryDayMiaiDetailTableViewCell_iPhone" owner:tableView options:nil];
        BSEveryDayMiaiDetailTableViewCell_iPhone *cell = [nib objectAtIndex:0];
        
        UIColor *color1 = [UIColor colorWithRed:198/255.f green:21/255.f blue:73/277.f alpha:1.f];
        cell.leftLabel.textColor = color1;
        
        if (indexPath.row == 0) {
            cell.leftLabel.text = @"发起人：";
            
            NSDictionary *sexDic = [[DataParseUtil myInfoData:@"sex"] objectAtIndex:1];
            NSString *sexStr = [sexDic objectForKey:[self.dataDic objectForKey:@"sex"]];
            
            cell.rightLabel.text = [NSString stringWithFormat:@"%@ | %@",[self.dataDic objectForKey:@"username"],sexStr];
            
        }else if(indexPath.row == 1){
            cell.leftLabel.text = @"费用预算：";
            
            NSDictionary *feeDic = [[DataParseUtil myInfoData:@"fee"] objectAtIndex:1];
            NSString *feeStr = [feeDic objectForKey:[self.dataDic objectForKey:@"fee"]];
            
            NSDictionary *whopayDic = [[DataParseUtil myInfoData:@"whopay"] objectAtIndex:1];
            NSString *whopayStr = [whopayDic objectForKey:[self.dataDic objectForKey:@"whopay"]];
            
            cell.rightLabel.text = [NSString stringWithFormat:@"%@ | %@",feeStr,whopayStr];
            
        }else if(indexPath.row == 2){
            cell.leftLabel.text = @"约会对象：";
            
            cell.rightLabel.text = [self yueHuiDuiXiang];
            
            CGSize textSize = [cell.rightLabel.text
                               sizeWithFont:cell.rightLabel.font
                               constrainedToSize:CGSizeMake(cell.rightLabel.frame.size.width, CGFLOAT_MAX)
                               lineBreakMode:UILineBreakModeCharacterWrap];
            [cell.rightLabel setFrame:CGRectMake(cell.rightLabel.frame.origin.x, cell.rightLabel.frame.origin.y, cell.rightLabel.frame.size.width, textSize.height)];
        }
        
        return cell;
        
    }else if (indexPath.section == 2){
        NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"BSEveryDayMiaiDetailTableViewCell_iPhone" owner:tableView options:nil];
        BSEveryDayMiaiDetailTableViewCell_iPhone *cell = [nib objectAtIndex:0];
        
        UIColor *color1 = [UIColor colorWithRed:198/255.f green:21/255.f blue:73/277.f alpha:1.f];
        cell.leftLabel.textColor = color1;
        
        if (indexPath.row == 0) {
            cell.leftLabel.text = @"详细内容：";
            
            cell.rightLabel.text = [NSString stringWithFormat:@"%@",[self.dataDic objectForKey:@"content"]];
            

            CGSize textSize = [cell.rightLabel.text
                               sizeWithFont:cell.rightLabel.font
                               constrainedToSize:CGSizeMake(cell.rightLabel.frame.size.width, CGFLOAT_MAX)
                               lineBreakMode:UILineBreakModeCharacterWrap];
            [cell.rightLabel setFrame:CGRectMake(cell.rightLabel.frame.origin.x, cell.rightLabel.frame.origin.y, cell.rightLabel.frame.size.width, textSize.height)];
            

        }
        
        return cell;
    }else{
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        
        return cell;
    }
    
}

- (NSString *)yueHuiDuiXiang{
    NSDictionary *dasexDic = [[DataParseUtil myInfoData:@"sex"] objectAtIndex:1];
    NSString *dasexKey = [self.dataDic objectForKey:@"dasex"];
    NSString *dasexStr = [dasexDic objectForKey:dasexKey];
    dasexStr = (dasexStr||[dasexStr isEqualToString:@""]) ? dasexStr : @"不限";
    
    NSString *dastartage = [[self.dataDic objectForKey:@"dastartage"] isEqualToString:@"0"] ? @"不限" : [self.dataDic objectForKey:@"dastartage"];
    
    NSString *daendage = [[self.dataDic objectForKey:@"daendage"] isEqualToString:@"0"] ? @"不限" : [self.dataDic objectForKey:@"daendage"];
    
    NSString *dastartheight = [[self.dataDic objectForKey:@"dastartheight"] isEqualToString:@"0"] ? @"不限" : [self.dataDic objectForKey:@"dastartheight"];
    
    NSString *daendheight = [[self.dataDic objectForKey:@"daendheight"] isEqualToString:@"0"] ? @"不限" : [self.dataDic objectForKey:@"daendheight"];
    
    NSDictionary *damarrystatusDic = [[DataParseUtil myInfoData:@"marrystatus"] objectAtIndex:1];
    NSString *damarrystatus = [damarrystatusDic objectForKey:[self.dataDic objectForKey:@"damarrystatus"]];
    damarrystatus = (damarrystatus||[damarrystatus isEqualToString:@""])  ? damarrystatus : @"不限";
    
    NSDictionary *daeducationDic = [[DataParseUtil myInfoData:@"education"] objectAtIndex:1];
    NSString *daeducation = [daeducationDic objectForKey:[self.dataDic objectForKey:@"daeducation"]];
    daeducation = (daeducation||[daeducation isEqualToString:@""])  ? daeducation : @"不限";
    
    NSDictionary *prDic = [[DataParseUtil myInfoData:@"pr"] objectAtIndex:1];
    NSString *pr = [prDic objectForKey:[self.dataDic objectForKey:@"pr"]];
    pr = (pr||[pr isEqualToString:@""])  ? pr : @"不限";
    
    NSDictionary *cityDic = [[DataParseUtil myInfoData:@"city"] objectAtIndex:1];
    NSString *city = [cityDic objectForKey:[self.dataDic objectForKey:@"city"]];
    city = (city||[city isEqualToString:@""])  ? city : @"不限";
    
    return  [NSString stringWithFormat:@"性别：%@ | 年龄：%@-%@ | 身高：%@-%@ | 婚姻状况：%@ | 学历：%@ | 所在地区：%@ %@",dasexStr, dastartage, daendage, dastartheight, daendheight,damarrystatus,@"",pr,city];
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}


- (void)pushViewControllerForId:(NSString *)id subject:(NSString *)subject{
    BSApplyViewController_iPhone *avc = [[BSApplyViewController_iPhone alloc] initWithNibName:@"BSApplyViewController_iPhone" bundle:nil];
    avc.datingid = id;
    avc.subject = subject;
    [self.navigationController pushViewController:avc animated:YES];
    [avc release];
}

- (void)dealloc {
    [_dataDic release];
    [_topDataDic release];
    [_myTableView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTopDataDic:nil];
    [self setMyTableView:nil];
    [self setDataDic:nil];
    [super viewDidUnload];
}

@end
