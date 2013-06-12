//
//  CWRefreshTableView.h
//  BSNews
//
//  Created by jpm on 12-5-17.
//  Copyright (c) 2012年 Baosight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyEGORefreshTableHeaderView.h"


//pull direction

typedef enum {
    
    CWRefreshTableViewDirectionUp,
    
    CWRefreshTableViewDirectionDown,
    
    CWRefreshTableViewDirectionAll
    
}CWRefreshTableViewDirection;

//pull type

typedef enum {
    
    CWRefreshTableViewPullTypeReload,           //从新加载
    
    CWRefreshTableViewPullTypeLoadMore,         //加载更多
    
}CWRefreshTableViewPullType;

@protocol CWRefreshTableViewDelegate;

@interface CWRefreshTableView : NSObject<MyEGORefreshTableHeaderDelegate,UIScrollViewDelegate>
{
    
    BOOL                        _reloading;
    
    MyEGORefreshTableHeaderView  *_headView;
    
    MyEGORefreshTableHeaderView  *_footerView;
    
    CWRefreshTableViewDirection    _direction;
    
}
@property (nonatomic, assign) UITableView  *pullTableView;

@property (nonatomic, assign) id<CWRefreshTableViewDelegate> delegate;

@property (nonatomic, retain) MyEGORefreshTableHeaderView  *_headView;

@property (nonatomic, retain) MyEGORefreshTableHeaderView  *_footerView;

//方向
- (id) initWithTableView:(UITableView *) tView
           pullDirection:(CWRefreshTableViewDirection) cwDirection;
//加载完成调用
- (void) DataSourceDidFinishedLoading;
@end
//

@protocol CWRefreshTableViewDelegate <NSObject>

//从新加载

- (BOOL) CWRefreshTableViewReloadTableViewDataSource:(CWRefreshTableViewPullType) refreshType;

@end
