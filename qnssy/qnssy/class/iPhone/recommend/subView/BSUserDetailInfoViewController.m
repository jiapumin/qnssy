//
//  BSUserDetailInfoViewController.m
//  qnssy
//
//  Created by jpm on 13-3-31.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSUserDetailInfoViewController.h"

@interface BSUserDetailInfoViewController (){

    UITableView *myTableView;
    
}
@end

@implementation BSUserDetailInfoViewController

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
    [self initMyTableView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initMyTableView{
    myTableView = [[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped] autorelease];
    myTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:myTableView];
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"BSRootLeftTableCell_iPhone" owner:tableView options:nil];
//    BSRootLeftTableCell_iPhone *cell = [nib objectAtIndex:0];
//    
//    cell.menuLabel.text = [self.vcNameArrays objectAtIndex:indexPath.row];
//    
//    cell.noSelectedLeftImageName = [self.noSelectedLeftImageArrays objectAtIndex:indexPath.row];
//    
//    cell.selectedLeftImageName =[self.selectedLeftImageArrays objectAtIndex:indexPath.row];
//    
//    cell.noSelectedBgImageName = @"5其他选项未选中背景";
//    
//    cell.selectedBgImageName = @"5其他选项选中背景";
//    
//    cell.leftImage.image = [UIImage imageNamed:cell.noSelectedLeftImageName];
//    
//    cell.bgImage.image = [UIImage imageNamed:cell.noSelectedBgImageName];
    
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

@end
