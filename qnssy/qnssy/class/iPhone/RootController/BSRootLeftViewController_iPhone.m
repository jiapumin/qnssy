//
//  BSRootLeftViewController_iPhone.m
//  BSChartNet
//
//  Created by jpm on 13-2-22.
//  Copyright (c) 2013年 baosight. All rights reserved.
//

#import "BSRootLeftViewController_iPhone.h"
#import "BSRootLeftTableCell_iPhone.h"

@interface BSRootLeftViewController_iPhone ()
{
    
}
@end

@implementation BSRootLeftViewController_iPhone

- (void)dealloc {
    [_selectedLeftImageArrays release];
    [_noSelectedLeftImageArrays release];
    [_vcArrays release];
    [_leftTableView release];
    [_vcNameArrays release];
    [_navBar release];
    [_toolBar release];
    [_navItem release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setSelectedLeftImageArrays:nil];
    [self setNoSelectedLeftImageArrays:nil];
    [self setVcArrays:nil];
    [self setVcNameArrays:nil];
    [self setLeftTableView:nil];
    [self setNavBar:nil];
    [self setToolBar:nil];
    [self setNavItem:nil];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
