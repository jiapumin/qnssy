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
    
    //初始化加载框
    [self initHUDView];
    [self loadServiceData];
    
}
- (void)dealloc{
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
    [self.myBaseInfoKey removeObject:@"areaname"];
    [self.myBaseInfoKey removeObject:@"cityid"];
    [self.myBaseInfoKey removeObject:@"nationalprovincename"];
    [self.myBaseInfoKey removeObject:@"provinceid"];
    [self.myBaseInfoKey removeObject:@"userimg"];
    [self.myBaseInfoKey removeObject:@"username"];
    
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
    int num = [self.myBaseInfoKey count];
    return num;
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

    NSString *key = [self.myBaseInfoKey objectAtIndex:indexPath.row];
    
    if ([key isEqualToString:@"cityname"]) {
        cell.leftLabel.text = @"所在地";
        cell.rightLabel.text = [self.myBaseInfo objectForKey:key];
        return cell;
    }

    NSArray * infoArray = [DataParseUtil myInfoData:key];
    //赋值用户信息
    cell.leftLabel.text = [infoArray objectAtIndex:0];
    
    NSDictionary *infoDesDic = [infoArray objectAtIndex:1];
    
    if (infoDesDic && infoDesDic.count != 0) {
        NSString *content = [infoDesDic objectForKey:[self.myBaseInfo objectForKey:key]];
        cell.rightLabel.text = [content isEqualToString:@""] ? @"无" : content;
    }else{
        
        cell.rightLabel.text = [self.myBaseInfo objectForKey:key];
    }
    
    
    
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
    
    
//    BSUserDetailInfoViewController *udivc = [[BSUserDetailInfoViewController alloc] initWithNibName:@"BSUserDetailInfoViewController" bundle:nil];
//    [self.navigationController pushViewController:udivc animated:YES];
//    [udivc release];
    
    
}
@end
