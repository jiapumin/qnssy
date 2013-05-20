//
//  BSSearchResultViewController.m
//  qnssy
//
//  Created by juchen on 13-5-2.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSSearchResultViewController.h"
#import "UserCell.h"

@interface BSSearchResultViewController ()

@end

@implementation BSSearchResultViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.userInfoArray = [[[[self.userInfoDict objectForKey:@"data"] objectForKey:@"ResData"] objectForKey:@"ResData"] objectForKey:@"userinfo"];
    NSLog(@"%d",self.userInfoArray.count);

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
}

#pragma mark - pop
- (void)popViewContoller{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userInfoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"UserCellIdentifiler";
    
    UserCell *userCell = (UserCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (userCell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"UserCell" owner:self options:nil];
        userCell = [array objectAtIndex:0];
        [userCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    userCell.userImageView.image = [UIImage imageNamed:[[self.userInfoArray objectAtIndex:indexPath.row] objectForKey:@"imageurl"]];
    userCell.userNameLabel.text = [[self.userInfoArray objectAtIndex:indexPath.row] objectForKey:@"username"];
    userCell.ageAndHeightLabel.text = [NSString stringWithFormat:@"%@岁,%@CM",[[self.userInfoArray objectAtIndex:indexPath.row] objectForKey:@"age"],[[self.userInfoArray objectAtIndex:indexPath.row] objectForKey:@"height"] ];
    userCell.userOtherInfoLabel.text = [NSString stringWithFormat:@"%@,%@,%@",[[self.userInfoArray objectAtIndex:indexPath.row] objectForKey:@"province"],[[self.userInfoArray objectAtIndex:indexPath.row] objectForKey:@"marrystatus"],[[self.userInfoArray objectAtIndex:indexPath.row] objectForKey:@"salary"]];
    
    return userCell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_userInfoDict release];
    [super dealloc];
}

@end
