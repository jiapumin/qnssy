//
//  UserHeightPickerViewDelegate.h
//  qnssy
//
//  Created by juchen on 13-5-29.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "ActionSheetPicker.h"

@interface UserHeightPickerViewDelegate : NSObject <ActionSheetCustomPickerDelegate>

@property (nonatomic, retain) NSMutableArray *startHeightArray;
@property (nonatomic, retain) NSMutableArray *endHeightArray;

@property (nonatomic, retain) NSString *startHeight;
@property (nonatomic, retain) NSString *endHeight;

@end
