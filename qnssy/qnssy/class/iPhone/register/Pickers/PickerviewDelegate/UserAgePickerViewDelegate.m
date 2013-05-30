//
//  UserAgePickerViewDelegate.m
//  qnssy
//
//  Created by juchen on 13-5-29.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "UserAgePickerViewDelegate.h"

@implementation UserAgePickerViewDelegate

- (id)init
{
    if (self = [super init]) {
        //  read provence and city datas from sqlite file
        //  init provenceArray and cityArray with datas
        self.startAgeArray = [NSMutableArray array];
        self.endAgeArray = [NSMutableArray array];
        
        self.startAge = @"";
        self.endAge = @"";
        
        [self.startAgeArray addObject:@"请选择"];
        [self.endAgeArray addObject:@"请选择"];
        
        for (int i = 18; i <= 99; i++) {
            [self.startAgeArray addObject:[NSString stringWithFormat:@"%d",i]];
            [self.endAgeArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
        
    }
    return self;
}

/////////////////////////////////////////////////////////////////////////
#pragma mark - ActionSheetCustomPickerDelegate Optional's
/////////////////////////////////////////////////////////////////////////
- (void)configurePickerView:(UIPickerView *)pickerView
{
    // Override default and hide selection indicator
    pickerView.showsSelectionIndicator = YES;
}

- (void)actionSheetPickerDidSucceed:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin
{
    //    NSString *resultMessage = [NSString stringWithFormat:@"%@ %@ selected.", self.selectedKey, self.selectedScale, nil];
    //
    //    [[[UIAlertView alloc] initWithTitle:@"Success!" message:resultMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    [origin setTitle:[NSString stringWithFormat:@"%@ - %@",self.startAge, self.endAge] forState:UIControlStateNormal];
    if ([self.startAge isEqualToString:@"请选择"]) {
        self.startAge = @"";
    }
    if([self.endAge isEqualToString:@"请选择"]){
        self.endAge = @"";
    }
}

/////////////////////////////////////////////////////////////////////////
#pragma mark - UIPickerViewDataSource Implementation
/////////////////////////////////////////////////////////////////////////

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.startAgeArray.count;
}

/////////////////////////////////////////////////////////////////////////
#pragma mark UIPickerViewDelegate Implementation
/////////////////////////////////////////////////////////////////////////

// returns width of column and height of row for each component.
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 160;
}
/*- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
 {
 return
 }
 */
// these methods return either a plain UIString, or a view (e.g UILabel) to display the row for the component.
// for the view versions, we cache any hidden and thus unused views and pass them back for reuse.
// If you return back a different object, the old one will be released. the view will be centered in the row rect
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [self.startAgeArray objectAtIndex:row];
            break;
        case 1:
            return [self.endAgeArray objectAtIndex:row];
            break;
        default:
            break;
    }
    return nil;
}

/////////////////////////////////////////////////////////////////////////

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            self.startAge = [self.startAgeArray objectAtIndex:row];
            break;
        case 1:
            self.endAge = [self.endAgeArray objectAtIndex:row];
            break;
        default:
            break;
    }
}

-(void)dealloc{
    [_startAge release];
    [_startAgeArray release];
    [_endAge release];
    [_endAgeArray release];
    [super dealloc];
}

@end
