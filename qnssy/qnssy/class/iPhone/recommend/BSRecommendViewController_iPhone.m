//
//  BSRecommendViewController_iPhone.m
//  qnssy
//
//  Created by jpm on 13-3-12.
//  Copyright (c) 2013年 jpm. All rights reserved.
//
#import "BSRecommendViewController_iPhone.h"
#import "BSRecommendImageViewController_iPhone.h"

#import "RecommendImageListRequestVo.h"
#import "RecommendImageListResponseVo.h"

@interface BSRecommendViewController_iPhone ()<DMLazyScrollViewDelegate,BSRecommendImageDelegate>{
    DMLazyScrollView* lazyScrollView;
    NSMutableArray *viewControllerArray;

    MBProgressHUD *progressHUD;
}

@property (retain, nonatomic)   NSMutableArray *imageArray;

@end


@implementation BSRecommendViewController_iPhone


- (void)dealloc{
    [_imageArray release];
    [super dealloc];
}

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
    
    //初始化加载框
    [self initHUDView];
    [self loadServiceData];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}
- (void)initHUDView{
    //-------加载框
    progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:progressHUD];
    
    progressHUD.labelText = @"数据加载中...";
    
}
- (void)loadServiceData{
    [progressHUD show:YES];
    RecommendImageListRequestVo *vo = [[RecommendImageListRequestVo alloc] init];
    [[BSContainer instance].serviceAgent callServletWithObject:self
                                                   requestDict:vo.mReqDic
                                                        target:self
                                               successCallBack:@selector(requestSucceess:data:)
                                                  failCallBack:@selector(requestFailed:data:)];
    
    [vo release];
}
#pragma mark - 回调方法

- (void)requestSucceess:(id)sender data:(NSDictionary *)dic {
    
    RecommendImageListResponseVo *vo = [[RecommendImageListResponseVo alloc] initWithDic:dic];
    self.imageArray = vo.imageUrlList;
    
    [self initLazyScroll];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:vo.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    
    [progressHUD hide:YES];
    
    [vo release];
}


- (void)requestFailed:(id)sender data:(NSDictionary *)dic {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"网络异常，请检查网络连接后重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    [progressHUD hide:YES];
}
#pragma mark - 滚动图片

- (void)initLazyScroll{
    // PREPARE PAGES
    NSUInteger numberOfPages = [self.imageArray count];
    viewControllerArray = [[NSMutableArray alloc] initWithCapacity:numberOfPages];
    for (NSUInteger k = 0; k < numberOfPages; ++k) {
        [viewControllerArray addObject:[NSNull null]];
    }
    
    // PREPARE LAZY VIEW
    CGRect rect = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    lazyScrollView = [[DMLazyScrollView alloc] initWithFrame:rect];
    lazyScrollView.dataSource = ^(NSUInteger index) {
        return [self controllerAtIndex:index];
    };
    lazyScrollView.numberOfPages = numberOfPages;
    [lazyScrollView setBounces:NO];
    
    //    lazyScrollView.controlDelegate = self;
    [self.view addSubview:lazyScrollView];
}
- (UIViewController *) controllerAtIndex:(NSInteger) index {
    if (index > viewControllerArray.count || index < 0) return nil;
    id res = [viewControllerArray objectAtIndex:index];
    if (res == [NSNull null]) {
        BSRecommendImageViewController_iPhone *vc = [[BSRecommendImageViewController_iPhone alloc] initWithNibName:@"BSRecommendImageViewController_iPhone" bundle:nil];
        vc.delegate = self;
        vc.imageVo = [self.imageArray objectAtIndex:index];
        [viewControllerArray replaceObjectAtIndex:index withObject:vc];
        return vc;
    }
    return res;
}
- (void)pushViewController:(UIViewController *)vc{
    [self.navigationController pushViewController:vc animated:YES];
}
@end
