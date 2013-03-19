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

@interface BSUserBasicInfoViewController (){
    NSMutableArray *yearArray;
    NSMutableArray *monthArray;
}

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
            [otherCell setSelectedItemIdentifier:kBirthdayIndentifier];
            cell = otherCell;
            break;
        case 3:
            otherCell = [[BSOtherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            otherCell.lableName.text = @"工作地区";
            [otherCell setSelectedItemIdentifier:kWorkAreaIndentifier];
            cell = otherCell;
            break;
        case 4:
            otherCell = [[BSOtherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            otherCell.lableName.text = @"婚姻状况";
            [otherCell setSelectedItemIdentifier:kMatrimonyIndentifier];
            cell = otherCell;
            break;
        case 5:
            otherCell = [[BSOtherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            otherCell.lableName.text = @"学历";
            [otherCell setSelectedItemIdentifier:kEducationIndentifier];
            cell = otherCell;
            break;
        case 6:
            otherCell = [[BSOtherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            otherCell.lableName.text = @"月收入";
            [otherCell setSelectedItemIdentifier:kMonthlyProfitIndentifier];
            cell = otherCell;
            break;
        case 7:
            otherCell = [[BSOtherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            otherCell.lableName.text = @"身高";
            [otherCell setSelectedItemIdentifier:kHeightIndentifier];
            cell = otherCell;
            break;
        default:
            break;
    }
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        BSOtherCell *otherCell = [[BSOtherCell alloc] init];
        [otherCell setSelectedItemIdentifier:kBirthdayIndentifier];
    }
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
