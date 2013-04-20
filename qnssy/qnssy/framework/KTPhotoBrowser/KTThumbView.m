//
//  KTThumbView.m
//  KTPhotoBrowser
//
//  Created by Kirby Turner on 2/3/10.
//  Copyright 2010 White Peak Software Inc. All rights reserved.
//

#import "KTThumbView.h"
#import "KTThumbsViewController.h"
#import <QuartzCore/QuartzCore.h>


@implementation KTThumbView

@synthesize controller = controller_;

- (void)dealloc 
{
//    [_deleteView release];
   [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
   if (self = [super initWithFrame:frame]) {

      [self addTarget:self
               action:@selector(didTouch:)
     forControlEvents:UIControlEventTouchUpInside];
      
      [self setClipsToBounds:YES];

      // If the thumbnail needs to be scaled, it should mantain its aspect
      // ratio.
      [[self imageView] setContentMode:UIViewContentModeScaleAspectFill];

   }
   return self;
}

- (void)didTouch:(id)sender 
{
   if (controller_) {
      [controller_ didSelectThumbAtIndex:[self tag]];
   }
}

- (void)setThumbImage:(UIImage *)newImage 
{
  [self setImage:newImage forState:UIControlStateNormal];
}

- (void)setHasBorder:(BOOL)hasBorder
{
   if (hasBorder) {
      self.layer.borderColor = [UIColor colorWithWhite:0.85 alpha:1.0].CGColor;
      self.layer.borderWidth = 1;
   } else {
//      self.layer.borderColor = nil;
       
       self.layer.borderColor = [UIColor redColor].CGColor;
       self.layer.borderWidth = 3;
   }
}
//- (void)setIsEdit:(BOOL)isEdit
//{
//    if (isEdit){
////        self.deleteView.hidden = NO;
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"delete"]];
//        //       imageView.frame = CGRectMake(self.frame.size.width-10, -10, 30, 30);
//        [self addSubview:self.deleteView];
//        self.deleteView = imageView;
//        //       self.deleteView.hidden = YES;
//        [[self imageView] addSubview:imageView];
//        [imageView release];
//
////        [self.deleteView setNeedsLayout];
//    } else {
////        self.deleteView.hidden = YES;
//    }
//}
//- (void)drawRect:(CGRect)rect{
//    
//    [super drawRect:rect];
//    
//    
//}
@end
