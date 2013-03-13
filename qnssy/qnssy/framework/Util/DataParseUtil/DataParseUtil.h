//
//  DataParseUtil.h
//  BSChartNet
//
//  Created by Sophie on 12-12-6.
//  Copyright (c) 2012年 baosight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataParseUtil : NSObject

+ (NSArray *)getArrayBySemicolon:(NSString *)string;
+ (NSArray *)getArrayByComma:(NSString *)string;

@end
