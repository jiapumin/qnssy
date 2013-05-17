//
//  BSMyInfoViewController_iPhone.m
//  qnssy
//
//  Created by jpm on 13-3-12.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSMyInfoViewController_iPhone.h"
#import "UserInfo.h"
#import "SignInRequestVo.h"
#import "BSMyInfoTableCell_iPhone.h"
#import "BSSettingViewController_iPhone.h"

#import "SDWebImageRootViewController.h"
#import "BSMyAttentionViewController_iPhone.h"
#import "BSLookedMeViewController_iPhone.h"


#import "BSBaseInfoViewController_iPhone.h"

#import "SignInResponseVo.h"

@interface BSMyInfoViewController_iPhone ()

@end

@implementation BSMyInfoViewController_iPhone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initData];
        self.title = @"我的资料";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    //加载个人信息
    UserInfo *myUserInfo = [BSContainer instance].userInfo;
    if ( myUserInfo != nil) {
        self.nickname.text = myUserInfo.nickName;
        self.myInfo.text = [NSString stringWithFormat:@"%@岁，%@，ID%@",myUserInfo.age,myUserInfo.address,myUserInfo.userId];
        [self requestMyImage:myUserInfo.imageUrl];
    }
    
    //右上角设置按钮
    UIButton *topRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect btnFrame = CGRectMake(0.0, 0.0, 40.0, 27.0);
    topRightButton.frame =btnFrame;
    [topRightButton setImage:[UIImage imageNamed:@"28设置按钮"]
                   forState:UIControlStateNormal];
    [topRightButton addTarget:self
                      action:@selector(rightSetting)
            forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:topRightButton] autorelease];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_textNameArrays release];
    [_noSelectedLeftImageArrays release];
    [_selectedLeftImageArrays release];
    [_testImgeView release];
    [_headImage release];
    [_nickname release];
    [_myInfo release];
    [_contextTableView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTestImgeView:nil];
    [self setHeadImage:nil];
    [self setNickname:nil];
    [self setMyInfo:nil];
    [self setContextTableView:nil];
    [super viewDidUnload];
}
#pragma mark - 初始化数据
- (void)initData{
    self.textNameArrays = [NSArray arrayWithObjects:
                           [NSArray arrayWithObjects:@"我的说说",@"我的照片",@"我的关注",@"看过我的",@"基本资料", nil],nil];
                           
//                           ,[NSArray arrayWithObjects:@"基本资料",@"高级资料",@"择偶条件",@"自我介绍", nil], 
    self.selectedLeftImageArrays =  [NSArray arrayWithObjects:
                                    [NSArray arrayWithObjects:@"28我的说说",@"28我的照片",@"28我的关注",@"28看过我的",@"28基本资料", nil], nil];
                           
//                           ,[NSArray arrayWithObjects:@"28基本资料",@"28高级资料",@"28择偶条件",@"28自我介绍", nil]
    self.noSelectedLeftImageArrays = [NSArray arrayWithObjects:
                                      [NSArray arrayWithObjects:@"28我的说说",@"28我的照片",@"28我的关注",@"28看过我的",@"28基本资料", nil], nil];
//                           ,[NSArray arrayWithObjects:,@"28高级资料",@"28择偶条件",@"28自我介绍", nil]
}
#pragma mark - 请求图片
- (void)requestMyImage:(NSString *)imageUrl{
    NSArray *tempArray = [imageUrl componentsSeparatedByString:@"/"];
    NSString *imageName = [NSString stringWithFormat:@"%@_%@",[tempArray objectAtIndex:(tempArray.count -2)],[tempArray lastObject]];
    
    NSString *filePath = [[[KBBreakpointTransmission instance] getTargetFloderPath:IMAGE_PATH] stringByAppendingPathComponent:imageName];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    
    if (image != nil){
        //当前显示那张图片
        self.headImage.image = image;
    }else{
        //先设置默认图就是加载中的图片
        UIImage *loadingImage = [UIImage imageNamed:@"5暂无照片头像"];

        [self.testImgeView setImage:loadingImage];
        //异步加载图片 并保存到本地
        KBBTFileInfoVo *vo = [[[KBBTFileInfoVo alloc] init] autorelease];
        NSLog(@"urlStr==%@",imageUrl);
        //主键作为文件名保存
        vo.fileName = imageName;
        vo.fileURL = imageUrl;
        vo.fileSize = @"123";
        vo.sender = @"image";
        vo.filePath = IMAGE_PATH;
        [[KBBreakpointTransmission instance] loadDataWithDelegate:self
                                                          success:@selector(imageDownloadFinish:)
                                                             fail:nil
                                                            start:nil
                                                         progress:nil
                                                         fileInfo:vo];
    }


}
- (IBAction)clickRegister:(id)sender {
    SignInRequestVo *vo = [[SignInRequestVo alloc] init];
    [[BSContainer instance].serviceAgent callServletWithObject:self
                                                   requestDict:vo.mReqDic
                                                        target:self
                                               successCallBack:@selector(signInSucceess:data:)
                                                  failCallBack:@selector(signInFailed:data:)];
    
    [vo release];
    
}
- (void)rightSetting{
    
    BSSettingViewController_iPhone *svc = [[[BSSettingViewController_iPhone alloc] initWithNibName:@"BSSettingViewController_iPhone" bundle:nil] autorelease];
    [self.navigationController pushViewController:svc animated:YES];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.textNameArrays count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[self.textNameArrays objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"BSMyInfoTableCell_iPhone" owner:tableView options:nil];
    BSMyInfoTableCell_iPhone *cell = [nib objectAtIndex:0];
    
    cell.menuLabel.text = [[self.textNameArrays objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.noSelectedLeftImageName = [[self.noSelectedLeftImageArrays objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.selectedLeftImageName =[[self.selectedLeftImageArrays objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
//    cell.noSelectedBgImageName = @"5其他选项未选中背景";
//    
//    cell.selectedBgImageName = @"5其他选项选中背景";
    
    cell.noSelectedBgImageName = @"";
    
    cell.selectedBgImageName =  @"";
    
    cell.leftImage.image = [UIImage imageNamed:cell.noSelectedLeftImageName];
    
    cell.bgImage.image = [UIImage imageNamed:cell.noSelectedBgImageName];
    
    return cell;
}

#pragma mark - Table view delegate
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BSMyInfoTableCell_iPhone *cell = (BSMyInfoTableCell_iPhone *)[tableView cellForRowAtIndexPath:indexPath];
    cell.bgImage.image = [UIImage imageNamed:cell.selectedBgImageName];
    cell.leftImage.image = [UIImage imageNamed:cell.selectedLeftImageName];
    cell.menuLabel.textColor = [UIColor colorWithRed:223.f/255 green:42.f/255 blue:106.f/255 alpha:1.f];
    
    return indexPath;
    
}
- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    BSMyInfoTableCell_iPhone *cell = (BSMyInfoTableCell_iPhone *)[tableView cellForRowAtIndexPath:indexPath];
    cell.bgImage.image = [UIImage imageNamed:cell.noSelectedBgImageName];
    cell.leftImage.image = [UIImage imageNamed:cell.noSelectedLeftImageName];
    cell.menuLabel.textColor = [UIColor blackColor];
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //我的说说
            BSBaseInfoViewController_iPhone *vc = [[BSBaseInfoViewController_iPhone alloc] initWithNibName:@"BSBaseInfoViewController_iPhone" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
        }else if (indexPath.row == 1) {
            //我的照片
            SDWebImageRootViewController *sdivc = [[SDWebImageRootViewController alloc] initWithNibName:@"SDWebImageRootViewController" bundle:nil];
            [self.navigationController pushViewController:sdivc animated:YES];
            [sdivc release];
        }else if (indexPath.row == 2){
            //我的关注
            BSMyAttentionViewController_iPhone *mavc = [[BSMyAttentionViewController_iPhone alloc] initWithNibName:@"BSMyAttentionViewController_iPhone" bundle:nil];
            [self.navigationController pushViewController:mavc animated:YES];
            [mavc release];
        }else if(indexPath.row == 3){
            //看过我的
            BSLookedMeViewController_iPhone *lmvc = [[BSLookedMeViewController_iPhone alloc] initWithNibName:@"BSLookedMeViewController_iPhone" bundle:nil];
            [self.navigationController pushViewController:lmvc animated:YES];
            [lmvc release];
        }else if (indexPath.row == 4) {
            //基本资料
            BSBaseInfoViewController_iPhone *vc = [[BSBaseInfoViewController_iPhone alloc] initWithNibName:@"BSBaseInfoViewController_iPhone" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
        }
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            //基本资料
            BSBaseInfoViewController_iPhone *vc = [[BSBaseInfoViewController_iPhone alloc] initWithNibName:@"BSBaseInfoViewController_iPhone" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
        }else if (indexPath.row == 1) {
            //我的照片
            SDWebImageRootViewController *sdivc = [[SDWebImageRootViewController alloc] initWithNibName:@"SDWebImageRootViewController" bundle:nil];
            [self.navigationController pushViewController:sdivc animated:YES];
            [sdivc release];
        }else if (indexPath.row == 2){
            //我的关注
            BSMyAttentionViewController_iPhone *mavc = [[BSMyAttentionViewController_iPhone alloc] initWithNibName:@"BSMyAttentionViewController_iPhone" bundle:nil];
            [self.navigationController pushViewController:mavc animated:YES];
            [mavc release];
        }else if(indexPath.row == 3){
            BSLookedMeViewController_iPhone *lmvc = [[BSLookedMeViewController_iPhone alloc] initWithNibName:@"BSLookedMeViewController_iPhone" bundle:nil];
            [self.navigationController pushViewController:lmvc animated:YES];
            [lmvc release];
        }
    }
    
    
}

#pragma mark - 异步请求数据成功

- (void)imageDownloadFinish:(KBBTFileInfoVo *)vo{
    //获取本地已经下载完成图片的路径
    NSString *filePath = [[[KBBreakpointTransmission instance] getTargetFloderPath:vo.filePath] stringByAppendingPathComponent:vo.fileName];
    NSLog(@"加载路径图片目录：%@",filePath);
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    
    if (image == nil) return;
    
    [self.headImage setImage:image];
}

- (void)signInSucceess:(id)sender data:(NSDictionary *)dic {
    
    SignInResponseVo *vo = [[SignInResponseVo alloc] initWithDic:dic];

    if (vo.status == 0) {
        //今天禁用按钮
        //？？
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:vo.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    
}


- (void)signInFailed:(id)sender data:(NSDictionary *)dic {
    NSLog(@"签到失败");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"网络异常，请检查网络连接后重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

@end
