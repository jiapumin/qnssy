//
//  BSGreetingsViewController.m
//  qnssy
//
//  Created by jpm on 13-5-27.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSGreetingsViewController_iPhone.h"
#import "SendMailRequestVo.h"
#import "SendMailResponseVo.h"

#import "BSGreetingsTableViewCell_iPhone.h"


@interface BSGreetingsViewController_iPhone (){
     MBProgressHUD *progressHUD;
     NSInteger currentIndex;
}

@end

@implementation BSGreetingsViewController_iPhone

- (id)initWithNibName:(NSString *)nibNameOrNil userid:(NSString *)userid
{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if (self) {
        // Custom initialization
        self.userid = userid;
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Greetings" ofType:@"plist"];
        NSArray *array = [[NSArray alloc] initWithContentsOfFile:plistPath];
//        NSDictionary *data = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        self.dataArray = array;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"问候";
    
    currentIndex = -1;
    
    [self initHUDView];
    
//    self.titleLabel.text = [NSString stringWithFormat:@"给 %@ 写信",self.username];
//    UIColor *color1 = [UIColor colorWithRed:198/255.f green:21/255.f blue:73/277.f alpha:1.f];
//    self.titleLabel.textColor = color1;
    
    //右上角发送按钮
    UIButton *topRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect btnFrame = CGRectMake(0.0, 0.0, 40.0, 27.0);
    topRightButton.frame =btnFrame;
    [topRightButton setImage:[UIImage imageNamed:@"28设置按钮"]
                    forState:UIControlStateNormal];
    [topRightButton addTarget:self
                       action:@selector(clickSubmitButton:)
             forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:topRightButton] autorelease];

   
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_contentText release];
    [_dataArray release];
    [_userid release];
    [_myTableView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setContentText:nil];
    [self setDataArray:nil];
    [self setUserid:nil];
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
    
    
    if ([self.contentText isEqualToString:@""] || self.contentText == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请选择问候语" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    
    [progressHUD show:YES];
    SendMailRequestVo *vo = [[SendMailRequestVo alloc] initWithUserId:self.userid content:self.contentText];
    [[BSContainer instance].serviceAgent callServletWithObject:self
                                                   requestDict:vo.mReqDic
                                                        target:self
                                               successCallBack:@selector(requestSucceess:data:)
                                                  failCallBack:@selector(requestFailed:data:)];
    
    [vo release];
}
#pragma mark - 回调方法

- (void)requestSucceess:(id)sender data:(NSDictionary *)dic {
    
    SendMailResponseVo *vo = [[SendMailResponseVo alloc] initWithDic:dic];
    
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

- (IBAction)clickSubmitButton:(id)sender {
    [self loadServiceData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *title = [self.dataArray objectAtIndex:indexPath.row];
    
    CGSize textSize = [title
                       sizeWithFont:[UIFont systemFontOfSize:14.f]
                       constrainedToSize:CGSizeMake(280, CGFLOAT_MAX)
                       lineBreakMode:UILineBreakModeCharacterWrap];
    return textSize.height + 20;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([self.contentText isEqualToString:@""]||self.contentText == nil) {
        return 44;
    }
    CGSize textSize = [self.contentText
                       sizeWithFont:[UIFont systemFontOfSize:14.f]
                       constrainedToSize:CGSizeMake(280, CGFLOAT_MAX)
                       lineBreakMode:UILineBreakModeCharacterWrap];
    return textSize.height + 20;

}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *title = @"";
    if ([self.contentText isEqualToString:@""]||self.contentText == nil) {
        title = @"请选择问候语";
    }else{
        title = self.contentText;
    }
    CGSize textSize = [title
                       sizeWithFont:[UIFont systemFontOfSize:14.f]
                       constrainedToSize:CGSizeMake(280, CGFLOAT_MAX)
                       lineBreakMode:UILineBreakModeCharacterWrap];
    NSInteger hight = textSize.height;
    
    UIView *headView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, hight + 20)] autorelease];
    headView.backgroundColor = [UIColor clearColor];
    UIImageView *headBgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"7标题背景"]];
    headBgImageView.frame = CGRectMake(10, 3, 300, hight + 15);
    [headView addSubview:headBgImageView];
    [headBgImageView release];
    
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(23, 3, 280, hight+10)];
    headLabel.lineBreakMode = NSLineBreakByCharWrapping;
    headLabel.numberOfLines = 0;
    headLabel.backgroundColor = [UIColor clearColor];
    UIColor *color1 = [UIColor colorWithRed:198/255.f green:21/255.f blue:73/277.f alpha:1.f];
    headLabel.textColor = color1;
    headLabel.font = [UIFont systemFontOfSize:14.f];
    headLabel.text = title;
    [headView addSubview:headLabel];
    [headLabel release];
    
    return headView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
////    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    if (cell == nil) {
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
//    }
//    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
//    cell.textLabel.font = [UIFont systemFontOfSize:14.f];
//    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    if (indexPath.row != currentIndex){
//        [cell setAccessoryType:UITableViewCellAccessoryNone];
//        cell.textLabel.textColor=[UIColor blackColor];
//    }else{
//        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
//        UIColor *color1 = [UIColor colorWithRed:198/255.f green:21/255.f blue:73/277.f alpha:1.f];
//        cell.textLabel.textColor =color1;
//    }
//    
    NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"BSGreetingsTableViewCell_iPhone" owner:tableView options:nil];
    BSGreetingsTableViewCell_iPhone *cell = [nib objectAtIndex:0];
    

    NSString *title = [self.dataArray objectAtIndex:indexPath.row];
    CGSize textSize = [title
                       sizeWithFont:[UIFont systemFontOfSize:14.f]
                       constrainedToSize:CGSizeMake(cell.myInfoLabel.frame.size.width, CGFLOAT_MAX)
                       lineBreakMode:UILineBreakModeCharacterWrap];
    NSInteger hight = textSize.height;
    cell.myInfoLabel.text = title;
    cell.myInfoLabel.frame = CGRectMake(cell.myInfoLabel.frame.origin.x,cell.myInfoLabel.frame.origin.y, cell.myInfoLabel.frame.size.width, hight);
    cell.myInfoLabel.font = [UIFont systemFontOfSize:14.f];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if (indexPath.row != currentIndex){
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        cell.myInfoLabel.textColor=[UIColor blackColor];
    }else{
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        UIColor *color1 = [UIColor colorWithRed:198/255.f green:21/255.f blue:73/277.f alpha:1.f];
        cell.myInfoLabel.textColor =color1;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(indexPath.row==currentIndex ){
        return;
    }
    NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:currentIndex
                                                   inSection:0];
    UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
    if (newCell.accessoryType == UITableViewCellAccessoryNone) {
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
         UIColor *color1 = [UIColor colorWithRed:198/255.f green:21/255.f blue:73/277.f alpha:1.f];
        newCell.textLabel.textColor =color1;
    }
    UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:oldIndexPath];
    if (oldCell.accessoryType == UITableViewCellAccessoryCheckmark) {
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        oldCell.textLabel.textColor=[UIColor blackColor];
    }
    currentIndex=indexPath.row;
    
    self.contentText = [self.dataArray objectAtIndex:indexPath.row];
    [self.myTableView reloadData];

}
@end
