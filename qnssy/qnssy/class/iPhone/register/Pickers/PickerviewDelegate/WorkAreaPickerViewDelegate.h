//
//  WorkAreaPickerViewDelegate.h
//  qnssy
//
//  Created by juchen on 13-5-25.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionSheetPicker.h"

@interface WorkAreaPickerViewDelegate : NSObject <ActionSheetCustomPickerDelegate>
@property (nonatomic, retain) NSMutableArray *provinceArray;
@property (nonatomic, retain) NSMutableArray *cityArray;

@property (nonatomic, retain) NSString *provinceId;
@property (nonatomic, retain) NSString *cityId;

@property (nonatomic, retain) NSString *provinceName;
@property (nonatomic, retain) NSString *cityName;

- (id)initWithForOne:(int)rowOne two:(int)rowTwo;

@end
