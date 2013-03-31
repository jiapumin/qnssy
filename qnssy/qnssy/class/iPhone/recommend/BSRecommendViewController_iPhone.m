//
//  BSRecommendViewController_iPhone.m
//  qnssy
//
//  Created by jpm on 13-3-12.
//  Copyright (c) 2013年 jpm. All rights reserved.
//
#define ARC4RANDOM_MAX	0x100000000
#import "BSRecommendViewController_iPhone.h"
#import "BSRecommendImageViewController_iPhone.h"

@interface BSRecommendViewController_iPhone ()<DMLazyScrollViewDelegate>{
    DMLazyScrollView* lazyScrollView;
    NSMutableArray*    viewControllerArray;
}

@end

@implementation BSRecommendViewController_iPhone

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
    // PREPARE PAGES
    NSUInteger numberOfPages = 10;
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
    
    // lazyScrollView.controlDelegate = self;
    [self.view addSubview:lazyScrollView];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

- (UIViewController *) controllerAtIndex:(NSInteger) index {
    if (index > viewControllerArray.count || index < 0) return nil;
    id res = [viewControllerArray objectAtIndex:index];
    if (res == [NSNull null]) {
        BSRecommendImageViewController_iPhone *vc = [[BSRecommendImageViewController_iPhone alloc] initWithNibName:@"BSRecommendImageViewController_iPhone" bundle:nil];
        [viewControllerArray replaceObjectAtIndex:index withObject:vc];
        return vc;
    }
    return res;
}

@end
