//
//  BSOtherCell.m
//  qnssy
//
//  Created by juchen on 13-3-19.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSOtherCell.h"

@interface BSOtherCell() {
    NSMutableArray *yearArray;
    NSMutableArray *monthArray;
}

@end

@implementation BSOtherCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 280, 44)];
        [backgroundView setBackgroundColor:[UIColor whiteColor]];
        
        CALayer *layer = backgroundView.layer;
        layer.cornerRadius = 8.0;
        UIColor *color = [UIColor colorWithRed:0.603 green:0.603 blue:0.603 alpha:1];
        CGColorRef colorref = [color CGColor];
        layer.borderColor = colorref;
        layer.borderWidth = 1.0;
        
        [self setBackgroundView:backgroundView];
        
        [backgroundView release];
        
        self.lableName = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 44)];
        self.lableName.backgroundColor = [UIColor clearColor];
        self.lableName.text = @"性别";
        UIColor *labelColor = [UIColor colorWithRed:0.333 green:0.333 blue:0.333 alpha:1];
        self.lableName.textColor = labelColor;
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        self.detailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(backgroundView.frame.size.width-65, 0, 80, 44)];
        self.detailsLabel.backgroundColor = [UIColor clearColor];
        self.detailsLabel.text = @"请选择";
        self.detailsLabel.textColor = [UIColor colorWithRed:0.803 green:0.113 blue:0.364 alpha:1];
        [self.contentView addSubview:self.lableName];
        [self.contentView addSubview:self.detailsLabel];
        [self.detailsLabel release];
    }
    return self;
}

- (void) setSelectedItemIdentifier:(NSString *) indentifier {
    
    if ([indentifier isEqualToString:kBirthdayIndentifier]) {
        NSLog(@"%@",kBirthdayIndentifier);
    } else if ([indentifier isEqualToString:kWorkAreaIndentifier]) {
        NSLog(@"%@",kWorkAreaIndentifier);
    } else if ([indentifier isEqualToString:kMatrimonyIndentifier]) {
        NSLog(@"%@",kMatrimonyIndentifier);
    } else if ([indentifier isEqualToString:kEducationIndentifier]) {
        NSLog(@"%@",kEducationIndentifier);
    } else if ([indentifier isEqualToString:kMonthlyProfitIndentifier]) {
        NSLog(@"%@",kMonthlyProfitIndentifier);
    } else if ([indentifier isEqualToString:kHeightIndentifier]) {
        NSLog(@"%@",kHeightIndentifier);
    }
}

- (void) configBirthdayData {
    yearArray = [[NSMutableArray alloc] init];
    for (int i=1980; i < 1995; i++) {
        [yearArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    monthArray = [[NSMutableArray alloc] init];
    for (int i=1; i<=12; i++) {
        if (i < 10) {
            [monthArray addObject:[NSString stringWithFormat:@"0%d",i]];
        } else {
            [monthArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
}

- (id) init {
    self = [super init];
    if (self) {
        [self configBirthdayData];
        self.birthdayPicker = [[UIPickerView alloc] init];
        self.birthdayPicker.delegate = self;
        self.birthdayPicker.dataSource = self;
        self.birthdayPicker.showsSelectionIndicator = YES;
        [self.contentView addSubview:self.birthdayPicker];
    }
    return self;
}

#pragma mark - picker view datasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == kYearComponent) {
        return [yearArray count];
    } else {
        return [monthArray count];
    }
}

#pragma mark picker view delegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == kYearComponent) {
        return [yearArray objectAtIndex:row];
    } else {
        return [monthArray objectAtIndex:row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == kYearComponent) {
        return 150;
    } else {
        return 100;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    selected = NO;
    [super setSelected:selected animated:animated];
}

- (void) setFrame:(CGRect)frame {
    frame.origin.x = 10;
    frame.origin.y += 10;
    frame.size.width = 300;
    frame.size.height = 44;
    [super setFrame:frame];
}

- (void) dealloc {
    [_lableName release];
    [_detailsLabel release];
    [super dealloc];
}

@end
