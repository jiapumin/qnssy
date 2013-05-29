//
//  UserAgePickerViewDelegate.h
//  qnssy
//
//  Created by juchen on 13-5-29.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "ActionSheetPicker.h"

@interface UserAgePickerViewDelegate : NSObject <ActionSheetCustomPickerDelegate>

@property (nonatomic, retain) NSMutableArray *startAgeArray;
@property (nonatomic, retain) NSMutableArray *endAgeArray;

@property (nonatomic, retain) NSString *startAge;
@property (nonatomic, retain) NSString *endAge;

@end
