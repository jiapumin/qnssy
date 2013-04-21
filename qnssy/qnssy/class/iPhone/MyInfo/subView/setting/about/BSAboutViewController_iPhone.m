//
//  BSAboutViewController_iphone.m
//  qnssy
//
//  Created by jpm on 13-4-21.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSAboutViewController_iPhone.h"

#import "AboutRequestVo.h"
#import "AboutResponseVo.h"

#import "AboutTableCell_iPhone.h"

@interface BSAboutViewController_iPhone (){
    MBProgressHUD *progressHUD;
}

@end

@implementation BSAboutViewController_iPhone

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
    self.title = @"关于千千";
    
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
    [_aboutStr release];
    [_myTableView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setAboutStr:nil];
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
    AboutRequestVo *vo = [[AboutRequestVo alloc] init];
    [[BSContainer instance].serviceAgent callServletWithObject:self
                                                   requestDict:vo.mReqDic
                                                        target:self
                                               successCallBack:@selector(requestSucceess:data:)
                                                  failCallBack:@selector(requestFailed:data:)];
    
    [vo release];
}
#pragma mark - 回调方法

- (void)requestSucceess:(id)sender data:(NSDictionary *)dic {
    
    AboutResponseVo *vo = [[AboutResponseVo alloc] initWithDic:dic];
    
    self.aboutStr = vo.aboutStr;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:vo.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    
    [progressHUD hide:YES];
    
    [vo release];
    
    [self.myTableView  reloadData];
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
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    CGSize textSize = [self.aboutStr sizeWithFont:[UIFont systemFontOfSize:14.f]
                                         constrainedToSize:CGSizeMake(260, CGFLOAT_MAX)
                                             lineBreakMode:UILineBreakModeCharacterWrap];

    
    
    
    return textSize.height + 40;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"AboutTableCell_iPhone" owner:tableView options:nil];
    AboutTableCell_iPhone *cell = [nib objectAtIndex:0];
    //赋值用户信息
    cell.leftLabel.text = self.aboutStr;
    CGSize textSize = [self.aboutStr sizeWithFont:[UIFont systemFontOfSize:14.f]
                                constrainedToSize:CGSizeMake(260, CGFLOAT_MAX)
                       
                                    lineBreakMode:UILineBreakModeCharacterWrap];
    [cell.leftLabel setFrame:CGRectMake(cell.leftLabel.frame.origin.x, cell.leftLabel.frame.origin.y, cell.leftLabel.frame.size.width, textSize.height)];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
}
@end
