//
//  BSRootLeftViewController_iPhone.m
//  BSChartNet
//
//  Created by jpm on 13-2-22.
//  Copyright (c) 2013年 baosight. All rights reserved.
//

#import "BSRootLeftViewController_iPhone.h"
#import "BSRootLeftTableCell_iPhone.h"
#import "BSMyInfoViewController_iPhone.h"

@interface BSRootLeftViewController_iPhone ()
{
    
}
@property (retain, nonatomic) UINavigationController *myInfoVcNav;
@end

@implementation BSRootLeftViewController_iPhone

- (void)dealloc {
    [_myInfoVcNav release];
    [_selectedLeftImageArrays release];
    [_noSelectedLeftImageArrays release];
    [_vcArrays release];
    [_leftTableView release];
    [_vcNameArrays release];
    [_navBar release];
    [_toolBar release];
    [_navItem release];
    [_myTopPhoto release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMyInfoVcNav:nil];
    [self setSelectedLeftImageArrays:nil];
    [self setNoSelectedLeftImageArrays:nil];
    [self setVcArrays:nil];
    [self setVcNameArrays:nil];
    [self setLeftTableView:nil];
    [self setNavBar:nil];
    [self setToolBar:nil];
    [self setNavItem:nil];
    [self setMyTopPhoto:nil];
    [super viewDidUnload];
}

- (id)initWithNibName:(NSString *)nibNameOrNil
                  vcs:(NSMutableArray *)vcs
               vcName:(NSMutableArray *)vcName
selectedLeftImageArray:(NSMutableArray *)select
noSelectedLeftImageArray:(NSMutableArray *)noSelected
{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if (self) {
        // Custom initialization
        self.vcArrays = vcs;
        self.vcNameArrays = vcName;
        self.selectedLeftImageArrays = select;
        self.noSelectedLeftImageArrays = noSelected;
    }
    return self;
}

- (IBAction)clickTopMyInfo:(id)sender {
    if (self.myInfoVcNav == nil){
        BSMyInfoViewController_iPhone *myInfoVc = [[[BSMyInfoViewController_iPhone alloc] initWithNibName:@"BSMyInfoViewController_iPhone" bundle:nil] autorelease];
        self.myInfoVcNav = [[[UINavigationController alloc] initWithRootViewController:myInfoVc] autorelease];
    }
    
    [self.revealSideViewController popViewControllerWithNewCenterController:self.myInfoVcNav
                                                                   animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:247.f/255 green:232.f/255 blue:232.f/255 alpha:1.f];
    //加载头像图片
    NSString *imageUrl = [BSContainer instance].userInfo.imageUrl;
    [self requestMyImage:imageUrl imageId:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];

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
    return [self.vcArrays count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"BSRootLeftTableCell_iPhone" owner:tableView options:nil];
    BSRootLeftTableCell_iPhone *cell = [nib objectAtIndex:0];
    
    cell.menuLabel.text = [self.vcNameArrays objectAtIndex:indexPath.row];
    
    cell.noSelectedLeftImageName = [self.noSelectedLeftImageArrays objectAtIndex:indexPath.row];
    
    cell.selectedLeftImageName =[self.selectedLeftImageArrays objectAtIndex:indexPath.row];
    
    cell.noSelectedBgImageName = @"5其他选项未选中背景";
    
    cell.selectedBgImageName = @"5其他选项选中背景";
    
    cell.leftImage.image = [UIImage imageNamed:cell.noSelectedLeftImageName];
    
    cell.bgImage.image = [UIImage imageNamed:cell.noSelectedBgImageName];
    
    return cell;
}

#pragma mark - Table view delegate
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BSRootLeftTableCell_iPhone *cell = (BSRootLeftTableCell_iPhone *)[tableView cellForRowAtIndexPath:indexPath];
    cell.bgImage.image = [UIImage imageNamed:cell.selectedBgImageName];
    cell.leftImage.image = [UIImage imageNamed:cell.selectedLeftImageName];
    cell.menuLabel.textColor = [UIColor colorWithRed:223.f/255 green:42.f/255 blue:106.f/255 alpha:1.f];
    
    return indexPath;
    
}
- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    BSRootLeftTableCell_iPhone *cell = (BSRootLeftTableCell_iPhone *)[tableView cellForRowAtIndexPath:indexPath];
    cell.bgImage.image = [UIImage imageNamed:cell.noSelectedBgImageName];
    cell.leftImage.image = [UIImage imageNamed:cell.noSelectedLeftImageName];
    cell.menuLabel.textColor = [UIColor blackColor];
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [self.vcArrays objectAtIndex:indexPath.row];
    
    [self.revealSideViewController popViewControllerWithNewCenterController:vc
                                                                   animated:YES];

}

#pragma mark - 请求图片
- (void)requestMyImage:(NSString *)imageUrl imageId:(NSString *)imageId{
    
    if ([imageUrl isEqualToString:@""] || imageUrl == nil) {
        return;
    }
    
    NSArray *tempArray = [imageUrl componentsSeparatedByString:@"/"];
//    NSString *imageName = [tempArray lastObject];
    NSString *imageName = [NSString stringWithFormat:@"%@_%@",[tempArray objectAtIndex:(tempArray.count -2)],[tempArray lastObject]];
    
    NSString *filePath = [[[KBBreakpointTransmission instance] getTargetFloderPath:IMAGE_PATH] stringByAppendingPathComponent:imageName];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    
    if (image != nil){
        //当前显示那张图片
        [self.myTopPhoto setImage:image forState:UIControlStateNormal];
    }else{
        //先设置默认图就是加载中的图片
        UIImage *loadingImage = [UIImage imageNamed:@"5暂无照片头像"];
        [self.myTopPhoto setImage:loadingImage forState:UIControlStateNormal];
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

#pragma mark - 异步请求数据成功

- (void)imageDownloadFinish:(KBBTFileInfoVo *)vo{
    //获取本地已经下载完成图片的路径
    NSString *filePath = [[[KBBreakpointTransmission instance] getTargetFloderPath:vo.filePath] stringByAppendingPathComponent:vo.fileName];
    NSLog(@"加载路径图片目录：%@",filePath);
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    
    if (image == nil) return;
    
    [self.myTopPhoto setImage:image forState:UIControlStateNormal];
}
@end
