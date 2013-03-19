//
//  BSOtherCell.h
//  qnssy
//
//  Created by juchen on 13-3-19.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kBirthdayIndentifier        @"Birthday"
#define kWorkAreaIndentifier        @"WorkArea"
#define kMatrimonyIndentifier       @"Matrimony"
#define kEducationIndentifier       @"Education"
#define kMonthlyProfitIndentifier   @"MonthlyProfit"
#define kHeightIndentifier          @"Height"

#define kYearComponent      0
#define kMonthComponent     1

@interface BSOtherCell : UITableViewCell <UIPickerViewDelegate, UIPickerViewDataSource>

@property (retain, nonatomic) UILabel *detailsLabel;
@property (retain, nonatomic) UILabel *lableName;
@property (retain, nonatomic) NSString *identifier;
@property (retain, nonatomic) UIPickerView *birthdayPicker;

- (void) setSelectedItemIdentifier:(NSString *) indentifier;

@end
