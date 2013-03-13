//
//  DataParseUtil.m
//  BSChartNet
//
//  Created by Sophie on 12-12-6.
//  Copyright (c) 2012年 baosight. All rights reserved.
//

#import "DataParseUtil.h"

@implementation DataParseUtil

+ (NSArray *)getArrayBySemicolon:(NSString *)string {
	NSArray *tempArray = [string componentsSeparatedByString:@";"];
	return tempArray;
}

+ (NSArray *)getArrayByComma:(NSString *)string {
	NSArray *tempArray = [string componentsSeparatedByString:@","];
	return tempArray;
}

+ (NSComparisonResult)compare: (NSDictionary *)otherDictionary
{
    NSDictionary *tempDictionary = (NSDictionary *)self;
	
    NSNumber *number1 = [[tempDictionary allKeys] objectAtIndex:0];
    NSNumber *number2 = [[otherDictionary allKeys] objectAtIndex:0];
	
    NSComparisonResult result = [number1 compare:number2];
	
    return result == NSOrderedDescending; // 升序
	//    return result == NSOrderedAscending;  // 降序
}




@end
