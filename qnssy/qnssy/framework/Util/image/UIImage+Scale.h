//
//  UIImage+Scale.h
//  BSChartNew
//
//  Created by jpm on 12-12-4.
//  Copyright (c) 2012年 baosight. All rights reserved.
//

@interface UIImage (scale)

- (UIImage *)scaleToSize:(CGSize)size;

- (UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize;

@end
