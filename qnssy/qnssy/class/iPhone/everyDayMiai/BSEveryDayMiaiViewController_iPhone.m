//
//  BSEveryDayMiaiViewController_iPhone.m
//  qnssy
//
//  Created by jpm on 13-3-12.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSEveryDayMiaiViewController_iPhone.h"

#import "EveryDayMiaiListRequestVo.h"
#import "EveryDayMiaiListrResponseVo.h"

#import "BSEveryDayMiaiDetailViewController_iPhone.h"
#import "BSApplyViewController_iPhone.h"
#import "BSEveryDayMiaiTableViewCell_iPhone.h"

@interface BSEveryDayMiaiViewController_iPhone (){
    MBProgressHUD *progressHUD;
}

@end

@implementation BSEveryDayMiaiViewController_iPhone

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

- (void)dealloc {
    [_dataArray release];
    [_myTableView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setDataArray:nil];
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
    EveryDayMiaiListRequestVo *vo = [[EveryDayMiaiListRequestVo alloc] init];
    [[BSContainer instance].serviceAgent callServletWithObject:self
                                                   requestDict:vo.mReqDic
                                                        target:self
                                               successCallBack:@selector(requestSucceess:data:)
                                                  failCallBack:@selector(requestFailed:data:)];
    
    [vo release];
}
#pragma mark - 回调方法

- (void)requestSucceess:(id)sender data:(NSDictionary *)dic {
    
    EveryDayMiaiListrResponseVo *vo = [[EveryDayMiaiListrResponseVo alloc] initWithDic:dic];
    
    self.dataArray = vo.userList;
    
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
    // Return the number of rows in the section.
    return [self.dataArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 113.f;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    static NSString *CellIdentifier = @"Cell";
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"BSEveryDayMiaiTableViewCell_iPhone" owner:tableView options:nil];
    BSEveryDayMiaiTableViewCell_iPhone *cell = [nib objectAtIndex:0];
    
    cell.delegate = self;
    
    //赋值用户信息
    [cell reloadData:[self.dataArray objectAtIndex:indexPath.row]];
    
    
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    BSEveryDayMiaiDetailViewController_iPhone *edmd = [[BSEveryDayMiaiDetailViewController_iPhone alloc] initWithNibName:@"BSEveryDayMiaiDetailViewController_iPhone" bundle:nil];
    edmd.topDataDic = [self.dataArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:edmd animated:YES];
    [edmd release];
    
    
}
- (void)pushViewController:(NSString *)id{
    BSApplyViewController_iPhone *avc = [[BSApplyViewController_iPhone alloc] initWithNibName:@"BSApplyViewController_iPhone" bundle:nil];
    avc.datingid = id;
    [self.navigationController pushViewController:avc animated:YES];
    [avc release];
}
@end
