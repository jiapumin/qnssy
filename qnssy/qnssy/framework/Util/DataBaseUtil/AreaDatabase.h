//
//  AreaDatabase.h
//  qnssy
//
//  Created by juchen on 13-4-29.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface AreaDatabase : NSObject {
    sqlite3 *_database;
}

+(AreaDatabase *) database;

-(NSArray *) getProvince;

-(NSArray *) getCityWithProvinceId:(int) provinceId;

@end
