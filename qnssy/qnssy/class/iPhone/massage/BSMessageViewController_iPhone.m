//
//  BSMessageViewController_iPhone.m
//  qnssy
//
//  Created by jpm on 13-3-12.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSMessageViewController_iPhone.h"

#import "MessageUnreadRequestVo.h"
#import "MessageUnreadResponseVo.h"

@interface BSMessageViewController_iPhone (){
        MBProgressHUD *progressHUD;
}

@end

@implementation BSMessageViewController_iPhone

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


    self.topSegmented.tintColor = [UIColor colorWithRed:243/255.f green:77/255.f blue:134/255.f alpha:1.0];
    [self.topSegmented setTitle:@"未读邮件" forSegmentAtIndex:0];
    [self.topSegmented setTitle:@"发件箱" forSegmentAtIndex:1];
    [self.topSegmented setTitle:@"收件箱" forSegmentAtIndex:2];
    [self.topSegmented setTitle:@"聊天" forSegmentAtIndex:3];
    [self.topSegmented setTitle:@"系统" forSegmentAtIndex:4];
    
    [self loadServiceData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_mailArray release];
    [_myTableView release];
    [_topSegmented release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMailArray:nil];
    [self setMyTableView:nil];
    [self setTopSegmented:nil];
    [super viewDidUnload];
}


- (IBAction)clickTopSegmented:(UISegmentedControl *)segmented {
    
    if (segmented.selectedSegmentIndex == 0) {
        [self loadServiceData];
    }
    
}
- (void)initHUDView{
    //-------加载框
    progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:progressHUD];
    
    progressHUD.labelText = @"数据加载中...";
    
}
- (void)loadServiceData{
    [progressHUD show:YES];
    MessageUnreadRequestVo *vo = [[MessageUnreadRequestVo alloc] init];
    [[BSContainer instance].serviceAgent callServletWithObject:self
                                                   requestDict:vo.mReqDic
                                                        target:self
                                               successCallBack:@selector(requestSucceess:data:)
                                                  failCallBack:@selector(requestFailed:data:)];
    
    [vo release];
}
#pragma mark - 回调方法

- (void)requestSucceess:(id)sender data:(NSDictionary *)dic {
    
    MessageUnreadResponseVo *vo = [[MessageUnreadResponseVo alloc] initWithDic:dic];
    
  
    
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
    int num = [self.mailArray count];
    return num;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.f;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    static NSString *CellIdentifier = @"Cell";
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
//    NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"BaseInfoTableViewCell_iPhone" owner:tableView options:nil];
//    BaseInfoTableViewCell_iPhone *cell = [nib objectAtIndex:0];
//    
//    NSString *key = [self.myBaseInfoKey objectAtIndex:indexPath.row];
//    
//    if ([key isEqualToString:@"cityname"]) {
//        cell.leftLabel.text = @"所在地";
//        cell.rightLabel.text = [self.myBaseInfo objectForKey:key];
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
//        cell.rightLabel.text = [content isEqualToString:@""] ? @"无" : content;
//    }else{
//        
//        cell.rightLabel.text = [self.myBaseInfo objectForKey:key];
//    }
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
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
