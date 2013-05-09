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
#import "MessageReadedRequestVo.h"
#import "BSMessageDetailsViewController_iPhone.h"
#import "BSMessageCell.h"

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
    
    [self loadServiceData:@"0"];
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
        [self loadServiceData:@"0"];
    } else if (segmented.selectedSegmentIndex == 1){
        [self loadServiceData:@"1"];
    }
    
}
- (void)initHUDView{
    //-------加载框
    progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:progressHUD];
    
    progressHUD.labelText = @"数据加载中...";
    
}
- (void)loadServiceData:(NSString *)mailType{
    [progressHUD show:YES];
    MessageUnreadRequestVo *vo = [[MessageUnreadRequestVo alloc] initWithMailType:mailType];
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
    
    self.mailArray = vo.mailList;
    
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
    
    NSString *sendName = [[[self.mailArray objectAtIndex:indexPath.row] objectForKey:@"sendname"] isEqual:[NSNull null]]?@"匿名":[[self.mailArray objectAtIndex:indexPath.row] objectForKey:@"sendname"];
    cell.messageTitleLabel.text = sendName;

    cell.messageDetailsLabel.text = [[self.mailArray objectAtIndex:indexPath.row] objectForKey:@"emailcontent"];
    
    NSString *readStatus = [[self.mailArray objectAtIndex:indexPath.row] objectForKey:@"readstatus"];
    if ([readStatus isEqualToString:@"1"]) {
        cell.messageImageView.image = [UIImage imageNamed:@"9邮件为空时显示图片@2x.png"];
    } else {
        cell.messageImageView.image = [UIImage imageNamed:@"10未读邮件ico@2x.png"];
    }

    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BSMessageDetailsViewController_iPhone *messageDetailsViewController = [[BSMessageDetailsViewController_iPhone alloc] initWithNibName:@"BSMessageDetailsViewController_iPhone" bundle:nil];
    NSString *sender = [[self.mailArray objectAtIndex:indexPath.row] objectForKey:@"sendname"];
    messageDetailsViewController.senderLabel.text = [sender isEqual:[NSNull null]]?@"匿名":sender;
    NSString *sendDate = [[self.mailArray objectAtIndex:indexPath.row] objectForKey:@"emaildate"];
    messageDetailsViewController.dateLabel.text = sendDate;
    NSString *sendContent = [[self.mailArray objectAtIndex:indexPath.row] objectForKey:@"emailcontent"];
    messageDetailsViewController.textView.text = sendContent;
    [self.navigationController pushViewController:messageDetailsViewController animated:YES];
    [messageDetailsViewController release];
    
    NSString *messageId = [[self.mailArray objectAtIndex:indexPath.row] objectForKey:@"msgid"];
    MessageReadedRequestVo *vo = [[MessageReadedRequestVo alloc] initWithMessageId:messageId];
    [[BSContainer instance].serviceAgent callServletWithObject:self
                                                   requestDict:vo.mReqDic
                                                        target:self
                                               successCallBack:@selector(readRequestSucceess:data:)
                                                  failCallBack:@selector(readRequestFailed:data:)];
    
    [vo release];
}

- (void)readRequestSucceess:(id)sender data:(NSDictionary *)dic {
    [_myTableView reloadData];
}

-(void)readRequestFailed:(id)sender data:(NSDictionary *)dic {
    NSLog(@"set had readed message faild.");
}
@end
