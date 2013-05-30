//
//  UserHeightPickerViewDelegate.m
//  qnssy
//
//  Created by juchen on 13-5-29.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "UserHeightPickerViewDelegate.h"

@implementation UserHeightPickerViewDelegate

- (id)init
{
    if (self = [super init]) {
        //  read provence and city datas from sqlite file
        //  init provenceArray and cityArray with datas
        self.startHeightArray = [NSMutableArray array];
        self.endHeightArray = [NSMutableArray array];
        
        self.startHeight = @"";
        self.endHeight = @"";
        
        [self.startHeightArray addObject:@"请选择"];
        [self.endHeightArray addObject:@"请选择"];
        
        for (int i = 130; i <= 260; i++) {
            [self.startHeightArray addObject:[NSString stringWithFormat:@"%d",i]];
            [self.endHeightArray addObject:[NSString stringWithFormat:@"%d",i]];
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
    [origin setTitle:[NSString stringWithFormat:@"%@ - %@",self.startHeight, self.endHeight] forState:UIControlStateNormal];
    if ([self.startHeight isEqualToString:@"请选择"]) {
        self.startHeight = @"";
    }
    if ([self.endHeight isEqualToString:@"请选择"]) {
        self.endHeight = @"";
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
    switch (component) {
        case 0:
            return self.startHeightArray.count;
            break;
        case 1:
            return self.endHeightArray.count;
            break;
            
        default:
            break;
    }
    return 0;
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
            return [self.startHeightArray objectAtIndex:row];
            break;
        case 1:
            return [self.endHeightArray objectAtIndex:row];
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
            self.startHeight = [self.startHeightArray objectAtIndex:row];
            break;
        case 1:
            self.endHeight = [self.endHeightArray objectAtIndex:row];
            break;
        default:
            break;
    }
}

-(void)dealloc{
    [_startHeight release];
    [_startHeightArray release];
    [_endHeight release];
    [_endHeightArray release];
    [super dealloc];
}

@end
