//
//  KTThumbView.h
//  KTPhotoBrowser
//
//  Created by Kirby Turner on 2/3/10.
//  Copyright 2010 White Peak Software Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KTThumbsViewController;

@interface KTThumbView : UIButton 
{
@private
   KTThumbsViewController *controller_;
}

@property (nonatomic, assign) KTThumbsViewController *controller;

//@property (retain, nonatomic) UIImageView *deleteView;

- (id)initWithFrame:(CGRect)frame;
- (void)setThumbImage:(UIImage *)newImage;
- (void)setHasBorder:(BOOL)hasBorder;
//- (void)setIsEdit:(BOOL)isEdit;



@end

