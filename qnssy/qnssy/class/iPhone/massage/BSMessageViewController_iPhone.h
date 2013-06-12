//
//  BSMessageViewController_iPhone.h
//  qnssy
//  我的邮件
//  Created by jpm on 13-3-12.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSSuperCentreViewController_iPhone.h"
#import "CWRefreshTableView.h"

@interface BSMessageViewController_iPhone : BSSuperCentreViewController_iPhone<CWRefreshTableViewDelegate>{
        CWRefreshTableView *_refreshView;
}

@property (retain, nonatomic) IBOutlet UISegmentedControl *topSegmented;

@property (retain, nonatomic) NSMutableArray *mySendedArray;
@property (retain, nonatomic) NSMutableArray *unReadArray;
@property (retain, nonatomic) NSMutableArray *myMailArray;
@property (retain, nonatomic) NSMutableArray *sysMailArray;

@property (retain, nonatomic) IBOutlet UITableView *myTableView;


@property(nonatomic) int  page;//当前第几页，貌似现在没有用
@property(nonatomic) BOOL isFirstLoad;//是否是第一次加载
@property (nonatomic) BOOL isMore;//是否有更多

- (IBAction)clickTopSegmented:(id)sender;
@end
