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
@property (nonatomic, retain) NSArray *provinceArray;
@property (nonatomic, retain) NSArray *cityArray;

@property (nonatomic, retain) NSString *provinceId;
@property (nonatomic, retain) NSString *cityId;

@property (nonatomic, retain) NSString *provinceName;
@property (nonatomic, retain) NSString *cityName;

@end
