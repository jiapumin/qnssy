//
//  BSUserBasicInfoViewController.m
//  qnssy
//
//  Created by juchen on 13-3-17.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSUserBasicInfoViewController.h"
#import "BSNickNameCell.h"
#import "BSUserSexCell.h"
#import "BSOtherCell.h"

enum {
	NickNameRowIndex,
	UserSexRowIndex,
	OtherRowIndex,
} InformationSectionRowIndicies;

@interface BSUserBasicInfoViewController ()

@end

@implementation BSUserBasicInfoViewController

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
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    BSOtherCell *otherCell = nil;
    switch (indexPath.row) {
        case 0:
            cell = [[BSNickNameCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            break;
        case 1:
            cell = [[BSUserSexCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            break;
        case 2:
            otherCell = [[BSOtherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            otherCell.lableName.text = @"生日";
            cell = otherCell;
            break;
        case 3:
            otherCell = [[BSOtherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            otherCell.lableName.text = @"工作地区";
            cell = otherCell;
            break;
        case 4:
            otherCell = [[BSOtherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            otherCell.lableName.text = @"婚姻状况";
            cell = otherCell;
            break;
        case 5:
            otherCell = [[BSOtherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            otherCell.lableName.text = @"学历";
            cell = otherCell;
            break;
        case 6:
            otherCell = [[BSOtherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            otherCell.lableName.text = @"月收入";
            cell = otherCell;
            break;
        case 7:
            otherCell = [[BSOtherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            otherCell.lableName.text = @"身高";
            cell = otherCell;
            break;
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
