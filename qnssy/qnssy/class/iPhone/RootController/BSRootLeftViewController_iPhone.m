//
//  BSRootLeftViewController_iPhone.m
//  BSChartNet
//
//  Created by jpm on 13-2-22.
//  Copyright (c) 2013年 baosight. All rights reserved.
//

#import "BSRootLeftViewController_iPhone.h"

@interface BSRootLeftViewController_iPhone ()
{
    
}
@end

@implementation BSRootLeftViewController_iPhone

- (void)dealloc {
    [_vcArrays release];
    [_leftTableView release];
    [_vcNameArrays release];
    [_navBar release];
    [_toolBar release];
    [_navItem release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setVcArrays:nil];
    [self setVcNameArrays:nil];
    [self setLeftTableView:nil];
    [self setNavBar:nil];
    [self setToolBar:nil];
    [self setNavItem:nil];
    [super viewDidUnload];
}

- (id)initWithNibName:(NSString *)nibNameOrNil vcs:(NSMutableArray *)vcs vcName:(NSMutableArray *)vcName
{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if (self) {
        // Custom initialization
        self.vcArrays = vcs;
        self.vcNameArrays = vcName;
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
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    cell.textLabel.text = [self.vcNameArrays objectAtIndex:indexPath.row];
    
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"left_ht_noselected"];
    }else if(indexPath.row == 1){
        cell.imageView.image = [UIImage imageNamed:@"left_wl_noselected"];
    }else if(indexPath.row == 2){
        cell.imageView.image = [UIImage imageNamed:@"left_zj_noselected"];
    }
    
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [self.vcArrays objectAtIndex:indexPath.row];
    
    [self.revealSideViewController popViewControllerWithNewCenterController:vc
                                                                   animated:YES];

}

@end
