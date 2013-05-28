//
//  BSMessageViewController_iPhone.m
//  qnssy
//
//  Created by jpm on 13-3-12.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSMessageViewController_iPhone.h"

#import "BSMyMailRequestVo.h"
#import "BSMySendedMailRequestVo.h"
#import "BSMySendedMailResponseVo.h"
#import "BSMyMailResponseVo.h"

#import "MessageReadedRequestVo.h"
#import "MessageReadedResponseVo.h"

#import "BSSysMailResponseVo.h"
#import "BSSysMailRequestVo.h"

#import "BSMessageDetailsViewController_iPhone.h"
#import "BSMessageCell.h"

@interface BSMessageViewController_iPhone (){
    MBProgressHUD *progressHUD;
    int mailType;
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

    [self initHUDView];

    self.topSegmented.tintColor = [UIColor colorWithRed:243/255.f green:77/255.f blue:134/255.f alpha:1.0];
    [self.topSegmented setTitle:@"未读邮件" forSegmentAtIndex:0];
    [self.topSegmented setTitle:@"发件箱" forSegmentAtIndex:1];
    [self.topSegmented setTitle:@"收件箱" forSegmentAtIndex:2];
    [self.topSegmented setTitle:@"聊天" forSegmentAtIndex:3];
    [self.topSegmented setTitle:@"系统" forSegmentAtIndex:4];
    
    [self loadServiceDataType:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_mySendedArray release];
    [_unReadArray release];
    [_myMailArray release];
    [_sysMailArray release];
    [_myTableView release];
    [_topSegmented release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMySendedArray:nil];
    [self setUnReadArray:nil];
    [self setMyMailArray:nil];
    [self setMyTableView:nil];
    [self setSysMailArray:nil];
    [self setTopSegmented:nil];
    [super viewDidUnload];
}


- (IBAction)clickTopSegmented:(UISegmentedControl *)segmented {
    
    if (segmented.selectedSegmentIndex == 0) {
        mailType = 0;
        if (self.unReadArray == nil) {
             [self loadServiceDataType:mailType];
        }
    
    } else if (segmented.selectedSegmentIndex == 1){
        mailType = 1;
        if (self.mySendedArray == nil) {
             [self loadServiceDataType:mailType];
        }
    
    } else if (segmented.selectedSegmentIndex == 2){
        mailType = 2;
        if (self.myMailArray == nil) {
            [self loadServiceDataType:mailType];
        }
    
    }else if(segmented.selectedSegmentIndex == 3){
        mailType = 3;
        
    }else if(segmented.selectedSegmentIndex == 4){
        mailType = 4;
        if (self.sysMailArray == nil) {
            [self loadServiceDataType:mailType];
        }
        //系统邮件
        //???
    }
    [self.myTableView reloadData];
    
}
- (void)initHUDView{
    //-------加载框
    progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:progressHUD];
    
    progressHUD.labelText = @"数据加载中...";
    
}
- (void)loadServiceDataType:(int)type{
    [progressHUD show:YES];
    SuperRequestVo *vo;
    if (type == 1) {
        vo = [[BSMyMailRequestVo alloc] init];
    }else if(type ==0 ||type == 2){
        vo = [[BSMySendedMailRequestVo alloc] init];
    }else if(type == 4){
        vo = [[BSSysMailRequestVo alloc] init];
    }
    [[BSContainer instance].serviceAgent callServletWithObject:[NSString stringWithFormat:@"%d",type]
                                                   requestDict:vo.mReqDic
                                                        target:self
                                               successCallBack:@selector(requestSucceess:data:)
                                                  failCallBack:@selector(requestFailed:data:)];
    
    [vo release];
}
#pragma mark - 回调方法

- (void)requestSucceess:(id)sender data:(NSDictionary *)dic {
    NSString *requestType = (NSString *)sender;
    if ([requestType isEqualToString:@"1"]) {
        BSMySendedMailResponseVo *vo = [[[BSMySendedMailResponseVo alloc] initWithDic:dic] autorelease];
        self.mySendedArray = vo.mailList;
        if (vo.status != 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:vo.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
    }else if([requestType isEqualToString:@"0"] || [requestType isEqualToString:@"2"]){
        BSMyMailResponseVo *vo = [[[BSMyMailResponseVo alloc] initWithDic:dic] autorelease];
        self.unReadArray = vo.unReadMailList;
        self.myMailArray = vo.myMailList;
        if (vo.status != 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:vo.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
    }else if([requestType isEqualToString:@"4"]){
        BSSysMailResponseVo *vo = [[[BSSysMailResponseVo alloc] initWithDic:dic] autorelease];
        self.sysMailArray = vo.mailList;
        if (vo.status != 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:vo.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
    }
    
    
    [progressHUD hide:YES];
    
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

    int num = 0;
    if (mailType == 0) {
        num = [self.unReadArray count];
    }else if(mailType == 1)
    {
        num = [self.mySendedArray count];
    }else if(mailType == 2){
        num = [self.myMailArray count];
    }else if(mailType == 4){
        num = [self.sysMailArray count];
    }else{
        num = 0;
    }
    return num;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80.f;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MessageIdentifier";
    BSMessageCell *cell = (BSMessageCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"BSMessageCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSMutableArray *tempArray;
    if (mailType == 0) {
        tempArray = self.unReadArray;
    }else if(mailType == 1)
    {
        tempArray = self.mySendedArray;
    }else if(mailType == 2){
        tempArray = self.myMailArray;
    }else if(mailType == 4){
        tempArray = self.sysMailArray;
    }else{
        tempArray = [NSMutableArray array];
    }
    
    NSString *sendName = [[[tempArray objectAtIndex:indexPath.row] objectForKey:@"sendname"] isEqual:[NSNull null]]?@"匿名":[[tempArray objectAtIndex:indexPath.row] objectForKey:@"sendname"];
    cell.messageTitleLabel.text = sendName;

    cell.messageDetailsLabel.text = [[tempArray objectAtIndex:indexPath.row] objectForKey:@"emailcontent"];
    
    NSString *readStatus = [[tempArray objectAtIndex:indexPath.row] objectForKey:@"readstatus"];
    if (mailType == 0) {
        cell.messageImageView.image = [UIImage imageNamed:@"10未读邮件ico"];
    }else if (mailType == 1) {
        cell.messageImageView.image = [UIImage imageNamed:@"12发件箱ico"];
    }else if (mailType == 2 || mailType == 4) {
        if ([readStatus isEqualToString:@"1"]) {
            cell.messageImageView.image = [UIImage imageNamed:@"9邮件为空时显示图片"];
        } else {
            cell.messageImageView.image = [UIImage imageNamed:@"10未读邮件ico"];
        }

    } 
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *tempArray;
    if (mailType == 0) {
        tempArray = self.unReadArray;
    }else if(mailType == 1)
    {
        tempArray = self.mySendedArray;
    }else if(mailType == 2){
        tempArray = self.myMailArray;
    }else{
        tempArray = [NSMutableArray array];
    }
    
    BSMessageDetailsViewController_iPhone *messageDetailsViewController = [[BSMessageDetailsViewController_iPhone alloc] initWithNibName:@"BSMessageDetailsViewController_iPhone" bundle:nil];
    NSString *sender = [[tempArray objectAtIndex:indexPath.row] objectForKey:@"sendname"];
    messageDetailsViewController.senderLabel.text = [sender isEqual:[NSNull null]]?@"匿名":sender;
    NSString *sendDate = [[tempArray objectAtIndex:indexPath.row] objectForKey:@"emaildate"];
    messageDetailsViewController.dateLabel.text = sendDate;
    NSString *sendContent = [[tempArray objectAtIndex:indexPath.row] objectForKey:@"emailcontent"];
    messageDetailsViewController.textView.text = sendContent;
    [self.navigationController pushViewController:messageDetailsViewController animated:YES];
    [messageDetailsViewController release];
    

    //如果邮件是未读的邮件则向服务器发送请求告诉服务器设置成已读状态
    //同时将本地的未读重置为已读状态
    NSString *messageId = [[tempArray objectAtIndex:indexPath.row] objectForKey:@"msgid"];
    MessageReadedRequestVo *vo = [[MessageReadedRequestVo alloc] initWithMessageId:messageId];
    [[BSContainer instance].serviceAgent callServletWithObject:messageId
                                                   requestDict:vo.mReqDic
                                                        target:self
                                               successCallBack:@selector(readRequestSucceess:data:)
                                                  failCallBack:@selector(readRequestFailed:data:)];
   
    [vo release];
    
    NSMutableDictionary *tempMailDic = [tempArray objectAtIndex:indexPath.row];
    [tempMailDic setObject:@"1" forKey:@"readstatus"];
    
    if (mailType == 0) {//未读
        [self.myMailArray addObject:tempMailDic];
        [self.unReadArray removeObjectAtIndex:indexPath.row];
        
    }
        
}

- (void)readRequestSucceess:(id)sender data:(NSDictionary *)dic {
    
    [_myTableView reloadData];
}

-(void)readRequestFailed:(id)sender data:(NSDictionary *)dic {
    NSLog(@"set had readed message faild.");
}
@end
