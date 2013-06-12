//
//  CWRefreshTableView.m
//  BSNews
//
//  Created by jpm on 12-5-17.
//  Copyright (c) 2012年 Baosight. All rights reserved.
//

#import "CWRefreshTableView.h"

#import "CWRefreshTableView.h"



@interface CWRefreshTableView()

- (void) initControl;
- (void) initPullDownView;
- (void) initPullUpView;
- (void) initPullAllView;
- (void) updatePullViewFrame;
@end

@implementation CWRefreshTableView

@synthesize pullTableView = _pullTableView;
@synthesize delegate = _delegate;
@synthesize _headView;
@synthesize _footerView;

- (void)dealloc{
    [super dealloc];
    [_headView release];
    [_footerView release];
}

- (id) initWithTableView:(UITableView *)tView 
           pullDirection:(CWRefreshTableViewDirection) cwDirection

{
    
    if ((self = [super init])) {
        
        _pullTableView = tView;
        
        _direction = cwDirection;
        
        [self initControl];
    }
    return self;
}

#pragma mark private
- (void) initControl
{
    
    switch (_direction) {
        case CWRefreshTableViewDirectionUp:
            [self initPullUpView];
            break;
        case CWRefreshTableViewDirectionDown:
            [self initPullDownView];
            break;
        case CWRefreshTableViewDirectionAll:
            [self initPullAllView];
            break;
    }
}
- (void) initPullDownView
{
//    CGFloat fWidth = _pullTableView.frame.size.width;
//    CGFloat originY = _pullTableView.contentSize.height;
//    if (originY < _pullTableView.frame.size.height) {
//        originY = _pullTableView.frame.size.height;
//    }
    CGSize size = _pullTableView.frame.size;
    CGRect rect = CGRectMake(0.0f, -size.height, size.width, size.height);
    MyEGORefreshTableHeaderView *view = [[MyEGORefreshTableHeaderView alloc] initWithFrame:rect byDirection:EGOOPullRefreshDown];
    view.delegate = self;
    [_pullTableView addSubview:view];
    view.autoresizingMask = _pullTableView.autoresizingMask;
    _headView = view;
    [view release];
    [_headView refreshLastUpdatedDate];
}

- (void) initPullUpView
{
    CGFloat fWidth = _pullTableView.frame.size.width;
    if (_pullTableView.style == UITableViewStyleGrouped) {
        //        fWidth = fWidth - 40;
    }
    
    NSLog(@"height : % .0f",_pullTableView.contentSize.height);
    CGFloat originY = _pullTableView.contentSize.height;
    CGFloat originX = _pullTableView.contentOffset.x;
    if (originY < _pullTableView.frame.size.height) {
        originY = _pullTableView.frame.size.height;
    }
    
    MyEGORefreshTableHeaderView *view = [[MyEGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(originX, originY, fWidth, 60) byDirection:EGOOPullRefreshUp];
    view.delegate = self;
    [_pullTableView addSubview:view];
    view.autoresizingMask = _pullTableView.autoresizingMask;
    _footerView = view;
    [view release];
    [_footerView refreshLastUpdatedDate];
}

- (void) initPullAllView
{
    [self initPullUpView];
    [self initPullDownView];
}

- (void) updatePullViewFrame
{
    if (_headView != nil) {  
    }
    if (_footerView != nil) {
        CGFloat fWidth = _pullTableView.frame.size.width;
        
        CGFloat originY = _pullTableView.contentSize.height;
        
        CGFloat originX = _pullTableView.contentOffset.x;
        
        if (originY < _pullTableView.frame.size.height) {
            
            originY = _pullTableView.frame.size.height;
            
        }
        
        if (!CGRectEqualToRect(_footerView.frame, CGRectMake(originX, originY, fWidth, 60))) {
            
            _footerView.frame = CGRectMake(originX, originY, fWidth, 60);  
            
        }
        
    }
    
}

#pragma mark -

#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    if (scrollView.contentOffset.y < -60.0f) {
        
        [_headView egoRefreshScrollViewDidScroll:scrollView];  
        
    }
    
    else if (scrollView.contentOffset.y >  60.0f)
    
    {
        
        [_footerView egoRefreshScrollViewDidScroll:scrollView];
        
    }
    
    
    
    [self updatePullViewFrame];
    
}



- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    
    if (scrollView.contentOffset.y < -60.0f) {
        
        [_headView egoRefreshScrollViewDidEndDragging:scrollView];  
        
    }
    
    else if (scrollView.contentOffset.y > 60.0f)
    
    {
        
        [_footerView egoRefreshScrollViewDidEndDragging:scrollView];
        
    }
    
}

#pragma mark -

#pragma mark Data Source Loading / Reloading Methods

- (void) DataSourceDidFinishedLoading

{
    
    _reloading = NO;
    
    [_headView egoRefreshScrollViewDataSourceDidFinishedLoading:_pullTableView];
    
    [_footerView egoRefreshScrollViewDataSourceDidFinishedLoading:_pullTableView];
    
}

#pragma mark -

#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(MyEGORefreshTableHeaderView*)view 
                                     direction:(EGOPullRefreshDirection)direc{
    
    if (_delegate != nil && [_delegate respondsToSelector:@selector(CWRefreshTableViewReloadTableViewDataSource:)]) {
        
        if (direc == EGOOPullRefreshUp) {
            
            _reloading = [_delegate CWRefreshTableViewReloadTableViewDataSource:CWRefreshTableViewPullTypeLoadMore]; 
            
        }
        
        else if (direc == EGOOPullRefreshDown)
        
        {
            
            _reloading = [_delegate CWRefreshTableViewReloadTableViewDataSource:CWRefreshTableViewPullTypeReload];
            
        }
        
    }
    
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(MyEGORefreshTableHeaderView*)view{
    
    
    return _reloading; // should return if data source model is reloading
    
    
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(MyEGORefreshTableHeaderView*)view{
    
    
    return [NSDate date]; // should return date data source was last changed
    
    
}

@end
