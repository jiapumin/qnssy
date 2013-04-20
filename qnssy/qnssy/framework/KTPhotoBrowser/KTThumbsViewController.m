//
//  KTThumbsViewController.m
//  KTPhotoBrowser
//
//  Created by Kirby Turner on 2/3/10.
//  Copyright 2010 White Peak Software Inc. All rights reserved.
//

#import "KTThumbsViewController.h"
#import "KTThumbsView.h"
#import "KTThumbView.h"
#import "KTPhotoScrollViewController.h"

#import "DelMyPhotoRequestVo.h"
#import "DelMyPhotoResponseVo.h"


@interface KTThumbsViewController (Private)
@end


@implementation KTThumbsViewController

@synthesize dataSource = dataSource_;

- (void)dealloc {
    [_scrollView release];
   
   [super dealloc];
}

- (void)loadView {
   // Make sure to set wantsFullScreenLayout or the photo
   // will not display behind the status bar.
   [self setWantsFullScreenLayout:YES];

   KTThumbsView *scrollView = [[KTThumbsView alloc] initWithFrame:CGRectZero];
   [scrollView setDataSource:self];
   [scrollView setController:self];
   [scrollView setScrollsToTop:YES];
   [scrollView setScrollEnabled:YES];
   [scrollView setAlwaysBounceVertical:YES];
   [scrollView setBackgroundColor:[UIColor whiteColor]];
   
   if ([dataSource_ respondsToSelector:@selector(thumbsHaveBorder)]) {
      [scrollView setThumbsHaveBorder:[dataSource_ thumbsHaveBorder]];
   }
   
   if ([dataSource_ respondsToSelector:@selector(thumbSize)]) {
      [scrollView setThumbSize:[dataSource_ thumbSize]];
   }
   
   if ([dataSource_ respondsToSelector:@selector(thumbsPerRow)]) {
      [scrollView setThumbsPerRow:[dataSource_ thumbsPerRow]];
   }
   
   
   // Set main view to the scroll view.
   [self setView:scrollView];
   
   // Retain a reference to the scroll view.
   self.scrollView = scrollView;
    
    [scrollView release];
//   [scrollView_ retain];
//   
//   // Release the local scroll view reference.
//   [scrollView release];
    
    //初始化加载框
    [self initHUDView];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewWillAppear:(BOOL)animated {
  // The first time the view appears, store away the current translucency so we can reset on pop.
  UINavigationBar *navbar = [[self navigationController] navigationBar];
  if (!viewDidAppearOnce_) {
    viewDidAppearOnce_ = YES;
    navbarWasTranslucent_ = [navbar isTranslucent];
  }
  // Then ensure translucency to match the look of Apple's Photos app.
  [navbar setTranslucent:YES];
  [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  // Restore old translucency when we pop this controller.
  UINavigationBar *navbar = [[self navigationController] navigationBar];
  [navbar setTranslucent:navbarWasTranslucent_];
  [super viewWillDisappear:animated];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)willLoadThumbs {
   // Do nothing by default.
}

- (void)didLoadThumbs {
   // Do nothing by default.
}

- (void)reloadThumbs {
   [self willLoadThumbs];
   [self.scrollView reloadData];
   [self didLoadThumbs];
}

- (void)setDataSource:(id <KTPhotoBrowserDataSource>)newDataSource {
   dataSource_ = newDataSource;
   [self reloadThumbs];
}

- (void)didSelectThumbAtIndex:(NSUInteger)index {
    if (self.isEdit) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您确认要删除此照片吗"
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确认", nil];
        [alert show];
        alert.tag = index;
        [alert release];
        
        return;
    }
   KTPhotoScrollViewController *newController = [[KTPhotoScrollViewController alloc] 
                                                        initWithDataSource:dataSource_ 
                                                  andStartWithPhotoAtIndex:index];
  
   [[self navigationController] pushViewController:newController animated:YES];
   [newController release];
}
- (void)initHUDView{
    //-------加载框
    self.progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:self.progressHUD];
    
    self.progressHUD.labelText = @"数据加载中...";
    
}
#pragma mark - 回调方法

- (void)requestDelMyPhotoSucceess:(id)sender data:(NSDictionary *)dic {
    
    DelMyPhotoResponseVo *vo = [[DelMyPhotoResponseVo alloc] initWithDic:dic];
    
    if (vo.status == 0) {
        int index = [sender intValue];
        //删除成功
        [dataSource_ deleteImageAtIndex:index thumbVC:self];
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:vo.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    [self.progressHUD hide:YES];
    
    [vo release];
}


- (void)requestDelMyPhotoFailed:(id)sender data:(NSDictionary *)dic {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"网络异常，请检查网络连接后重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    [self.progressHUD hide:YES];
}


#pragma mark -
#pragma mark KTThumbsViewDataSource

- (NSInteger)thumbsViewNumberOfThumbs:(KTThumbsView *)thumbsView
{
   NSInteger count = [dataSource_ numberOfPhotos];
   return count;
}

- (KTThumbView *)thumbsView:(KTThumbsView *)thumbsView thumbForIndex:(NSInteger)index
{
   KTThumbView *thumbView = [thumbsView dequeueReusableThumbView];
   if (!thumbView) {
      thumbView = [[[KTThumbView alloc] initWithFrame:CGRectZero] autorelease];
      [thumbView setController:self];
   }

   // Set thumbnail image.
   if ([dataSource_ respondsToSelector:@selector(thumbImageAtIndex:thumbView:)] == NO) {
      // Set thumbnail image synchronously.
      UIImage *thumbImage = [dataSource_ thumbImageAtIndex:index];
      [thumbView setThumbImage:thumbImage];
   } else {
      // Set thumbnail image asynchronously.
      [dataSource_ thumbImageAtIndex:index thumbView:thumbView];
   }
   
   return thumbView;
}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        int index = alertView.tag;
        NSString *id = [[[dataSource_ imageList] objectAtIndex:index] objectForKey:@"imageid"];
        DelMyPhotoRequestVo *vo = [[DelMyPhotoRequestVo alloc] initWithPhotoId:id];
        [[BSContainer instance].serviceAgent callServletWithObject:[NSString stringWithFormat:@"%d",index]
                                                       requestDict:vo.mReqDic
                                                            target:self
                                                   successCallBack:@selector(requestDelMyPhotoSucceess:data:)
                                                      failCallBack:@selector(requestDelMyPhotoFailed:data:)];
        
        [vo release];
        

    }
}

@end
