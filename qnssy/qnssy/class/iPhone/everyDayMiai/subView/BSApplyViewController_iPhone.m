//
//  BSApplyViewController_iPhone.m
//  qnssy
//
//  Created by jpm on 13-4-23.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSApplyViewController_iPhone.h"

#import "MiaiApplyRequestVo.h"
#import "MiaiApplyResponseVo.h"

@interface BSApplyViewController_iPhone (){
     MBProgressHUD *progressHUD;
}

@end

@implementation BSApplyViewController_iPhone

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
    
    self.title = @"我要报名";
    
    [self initHUDView];
    
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"24报名按钮"]
                                     style:UIBarButtonItemStyleDone
                                    target:self
                                    action:@selector(loadServiceData)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_datingid release];
    [_myTableView release];
    [_titleLabel release];
    [_phoneText release];
    [_contentText release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setDatingid:nil];
    [self setMyTableView:nil];
    [self setTitleLabel:nil];
    [self setPhoneText:nil];
    [self setContentText:nil];
    [super viewDidUnload];
}

- (void)initHUDView{
    //-------加载框
    progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:progressHUD];
    
    progressHUD.labelText = @"数据加载中...";
    
}
- (void)loadServiceData{
    
    [self.contentText resignFirstResponder];
    [self.phoneText resignFirstResponder];
    
    if ([self.contentText.text isEqualToString:@""] ||[self.phoneText.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"输入信息不完整" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    
    [progressHUD show:YES];
    MiaiApplyRequestVo *vo = [[MiaiApplyRequestVo alloc] initWithId:self.datingid contact:self.contentText.text message:self.phoneText.text];
    [[BSContainer instance].serviceAgent callServletWithObject:self
                                                   requestDict:vo.mReqDic
                                                        target:self
                                               successCallBack:@selector(requestSucceess:data:)
                                                  failCallBack:@selector(requestFailed:data:)];
    
    [vo release];
}
#pragma mark - 回调方法

- (void)requestSucceess:(id)sender data:(NSDictionary *)dic {
    
    MiaiApplyResponseVo *vo = [[MiaiApplyResponseVo alloc] initWithDic:dic];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:vo.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    
    [progressHUD hide:YES];
    
    [vo release];
    
    [self.navigationController popViewControllerAnimated:YES];

}


- (void)requestFailed:(id)sender data:(NSDictionary *)dic {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"网络异常，请检查网络连接后重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    [progressHUD hide:YES];
}
//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    // Return the number of sections.
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    // Return the number of rows in the section.
//    return 3;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    return 113.f;
//    
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
//    }
//    
//    return cell;
//}
//
//
//#pragma mark - Table view delegate
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}

@end
