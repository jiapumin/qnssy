//
//  BSSettingViewController_iPhone.m
//  qnssy
//
//  Created by jpm on 13-3-26.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSSettingViewController_iPhone.h"

#import "BSPublicTableCell_iPhone.h"

@interface BSSettingViewController_iPhone ()

@end

@implementation BSSettingViewController_iPhone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initData];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = publicColor;
    
    UIButton *topLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //按钮大小
    CGRect btnFrame = CGRectMake(0.0, 4.0, 29.0, 25.0);
    topLeftButton.frame =btnFrame;

    //设置返回按钮图片和方法
    [topLeftButton setImage:[UIImage imageNamed:@"2向左返回箭头"]
                   forState:UIControlStateNormal];
    
    [topLeftButton addTarget:self
                      action:@selector(popViewContoller)
            forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem * topLeftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:topLeftButton];
    self.navigationItem.leftBarButtonItem = topLeftBarButtonItem;
    [topLeftBarButtonItem release];
    
    self.title = @"设置";
    
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
    [_myTableView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMyTableView:nil];
    [super viewDidUnload];
}
#pragma mark - 初始化数据
- (void)initData{
    self.textNameArrays = [NSArray arrayWithObjects:
                           [NSArray arrayWithObjects:@"修改密码",@"关于千千",@"注销登录", nil], nil];
    self.selectedLeftImageArrays =  [NSArray arrayWithObjects:
                                     [NSArray arrayWithObjects:@"test",@"test",@"test", nil], nil];
    self.noSelectedLeftImageArrays = [NSArray arrayWithObjects:
                                      [NSArray arrayWithObjects:@"test",@"test",@"test", nil], nil];
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
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"BSPublicTableCell_iPhone" owner:tableView options:nil];
    BSPublicTableCell_iPhone *cell = [nib objectAtIndex:0];
    
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
    BSPublicTableCell_iPhone *cell = (BSPublicTableCell_iPhone *)[tableView cellForRowAtIndexPath:indexPath];
    cell.bgImage.image = [UIImage imageNamed:cell.selectedBgImageName];
    cell.leftImage.image = [UIImage imageNamed:cell.selectedLeftImageName];
    cell.menuLabel.textColor = [UIColor colorWithRed:223.f/255 green:42.f/255 blue:106.f/255 alpha:1.f];
    
    return indexPath;
    
}
- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    BSPublicTableCell_iPhone *cell = (BSPublicTableCell_iPhone *)[tableView cellForRowAtIndexPath:indexPath];
    cell.bgImage.image = [UIImage imageNamed:cell.noSelectedBgImageName];
    cell.leftImage.image = [UIImage imageNamed:cell.noSelectedLeftImageName];
    cell.menuLabel.textColor = [UIColor blackColor];
    return indexPath;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != 0) return;
    if (indexPath.row == 0) {
        //进入修改密码页面
    }else if (indexPath.row == 1) {
        //进入关于千千页面
    }else if (indexPath.row == 2) {
        //退出登录，返回登录界面
        app.window.rootViewController = app.loginNav;
    }
    
}
#pragma mark - pop
- (void)popViewContoller{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
