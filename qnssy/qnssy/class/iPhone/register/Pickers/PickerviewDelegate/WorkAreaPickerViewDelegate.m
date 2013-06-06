//
//  WorkAreaPickerViewDelegate.m
//  qnssy
//
//  Created by juchen on 13-5-25.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "WorkAreaPickerViewDelegate.h"
#import "AreaDatabase.h"
#import "AreaInfo.h"

#import "BaseInfoTableViewCell_iPhone.h"

@implementation WorkAreaPickerViewDelegate

- (id)init
{
    if (self = [super init]) {
        //  read provence and city datas from sqlite file
        //  init provenceArray and cityArray with datas
        self.provinceArray = [NSMutableArray array];
        NSArray *tempProvinceArray = [NSArray array];
        tempProvinceArray = [[AreaDatabase database] getProvince];
        AreaInfo *provinceInfo = [[AreaInfo alloc] initWithAreaId:0 areaName:@"请选择"];
        [self.provinceArray addObject:provinceInfo];
        [provinceInfo release];
        [self.provinceArray addObjectsFromArray:tempProvinceArray];
        
        self.cityArray = [NSMutableArray array];
        AreaInfo *cityInfo = [[AreaInfo alloc] initWithAreaId:0 areaName:@"请选择"];
        [self.cityArray addObject:cityInfo];
        [cityInfo release];
        self.provinceId = @"";
        self.cityId = @"";
        self.provinceName = @"请选择";
        self.cityName = @"请选择";
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
    [self.cityArray addObject:@"请选择"];
    [self.cityArray removeAllObjects];
    if ([[origin class] isSubclassOfClass:[UIButton class]]) {
        [origin setTitle:[NSString stringWithFormat:@"%@ - %@",self.provinceName, self.cityName] forState:UIControlStateNormal];
    }else if([[origin class] isSubclassOfClass:[UITableViewCell class]]){
        BaseInfoTableViewCell_iPhone *cell = (BaseInfoTableViewCell_iPhone *)origin;
        cell.rightLabel.text = [NSString stringWithFormat:@"%@-%@",self.provinceName, self.cityName];

        self.provinceId = self.provinceId == nil || [self.provinceId isEqualToString:@""] ? @"1" :self.provinceId;
        self.cityId = self.cityId == nil || [self.cityId isEqualToString:@""] ? @"1" :self.cityId;
        if ([cell.key isEqualToString:@"nationalprovinceid"]) {
            [cell.delegate.commitData setObject:self.provinceId forKey:@"nationalprovinceid"];
            [cell.delegate.commitData setObject:self.cityId forKey:@"nationalcityid"];
            [cell.delegate.myBaseInfo setObject:self.provinceId forKey:@"nationalprovinceid"];//表格刷新的时候使用
            [cell.delegate.myBaseInfo setObject:self.cityId forKey:@"nationalcityid"];//表格刷新的时候使用
        }else if([cell.key isEqualToString:@"provinceid"]){
            [cell.delegate.commitData setObject:self.provinceId forKey:@"provinceid"];
            [cell.delegate.commitData setObject:self.cityId forKey:@"cityid"];
            [cell.delegate.commitData  setObject:@"1" forKey:@"areaid"];
            [cell.delegate.myBaseInfo setObject:self.provinceId forKey:@"provinceid"];//表格刷新的时候使用
            [cell.delegate.myBaseInfo setObject:self.cityId forKey:@"cityid"];//表格刷新的时候使用
        }
        
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
            return self.provinceArray.count;
            break;
        case 1:
            return self.cityArray.count;
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
            return [[self.provinceArray objectAtIndex:row] areaName];
            break;
        case 1:
            return [[self.cityArray objectAtIndex:row] areaName];
            break;
        default:
            break;
    }
    return nil;
}

/////////////////////////////////////////////////////////////////////////

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    int areaid;
    switch (component) {
        case 0:
            areaid = [[self.provinceArray objectAtIndex:row] areaId];
            if (areaid == 0) {
                [self.cityArray removeAllObjects];
                AreaInfo *cityInfo = [[AreaInfo alloc] initWithAreaId:0 areaName:@"请选择"];
                [self.cityArray addObject:cityInfo];
                [cityInfo release];
                self.provinceId = @"";
                self.cityId = @"";
                self.provinceName = @"请选择";
                self.cityName = @"请选择";
            } else {
                [self.cityArray removeAllObjects];
                self.provinceId = [NSString stringWithFormat:@"%d",areaid];
                NSArray *tempCityArray = [[AreaDatabase database] getCityWithProvinceId:areaid];
                [self.cityArray addObjectsFromArray:tempCityArray];
                self.provinceName = [[self.provinceArray objectAtIndex:row] areaName];
                self.cityName = [[self.cityArray objectAtIndex:0] areaName];
                self.cityId = [NSString stringWithFormat:@"%d",[[self.cityArray objectAtIndex:0] areaId]];
            }
            [pickerView reloadComponent:1];
            break;
        case 1:
            self.cityId = [NSString stringWithFormat:@"%d",[[self.cityArray objectAtIndex:row] areaId]];
            self.cityName = [[self.cityArray objectAtIndex:row] areaName];
            break;
        default:
            break;
    }
}

-(void)dealloc{
    [_provinceArray release];
    [_provinceId release];
    [_provinceName release];
    [_cityArray release];
    [_cityId release];
    [_cityName release];
    [super dealloc];
}

@end
