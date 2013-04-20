//
//  BSMyAttentionViewController_iPhone.m
//  qnssy
//
//  Created by jpm on 13-4-14.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSMyAttentionViewController_iPhone.h"

#import "BSMyAttentionTableViewCell_iPhone.h"

#import "BSUserDetailInfoViewController.h"

#import "MyAttentionRequestVo.h"
#import "MyAttentionResponseVo.h"

@interface BSMyAttentionViewController_iPhone (){
    MBProgressHUD *progressHUD;
}

@end

@implementation BSMyAttentionViewController_iPhone

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
    self.title = @"我的关注";
    
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
    MyAttentionRequestVo *vo = [[MyAttentionRequestVo alloc] init];
    [[BSContainer instance].serviceAgent callServletWithObject:self
                                                   requestDict:vo.mReqDic
                                                        target:self
                                               successCallBack:@selector(requestSucceess:data:)
                                                  failCallBack:@selector(requestFailed:data:)];
    
    [vo release];
}
#pragma mark - 回调方法

- (void)requestSucceess:(id)sender data:(NSDictionary *)dic {
    
    MyAttentionResponseVo *vo = [[MyAttentionResponseVo alloc] initWithDic:dic];
    
    self.dataArray = vo.userList;
    
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:vo.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
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
    
    return 62.f;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"BSMyAttentionTableViewCell_iPhone" owner:tableView options:nil];
    BSMyAttentionTableViewCell_iPhone *cell = [nib objectAtIndex:0];
    
    
    //赋值用户信息
    [cell reloadData:[self.dataArray objectAtIndex:indexPath.row]];
    

    
    return cell;
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
    
    
    BSUserDetailInfoViewController *udivc = [[BSUserDetailInfoViewController alloc] initWithNibName:@"BSUserDetailInfoViewController" bundle:nil];
    [self.navigationController pushViewController:udivc animated:YES];
    [udivc release];
    
    
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

@end
