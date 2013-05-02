//
//  AreaDatabase.m
//  qnssy
//
//  Created by juchen on 13-4-29.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "AreaDatabase.h"
#import "AreaInfo.h"

@implementation AreaDatabase

static AreaDatabase *_database;

+(AreaDatabase *) database {
    if (_database == nil) {
        _database = [[AreaDatabase alloc] init];
    }
    return _database;
}

- (id)init {
    if ((self = [super init])) {
        NSString *sqLiteDb = [[NSBundle mainBundle] pathForResource:@"area"
                                                             ofType:@"sqlite"];
        
        if (sqlite3_open([sqLiteDb UTF8String], &_database) != SQLITE_OK) {
            NSLog(@"Failed to open database!");
        }
    }
    return self;
}

-(NSArray *) getProvince {
    NSMutableArray *retval = [[[NSMutableArray alloc] init] autorelease];
    NSString *query = @"SELECT areaid, areaname FROM area where rootid=0 order by orders ASC";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil)
        == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int areaid = sqlite3_column_int(statement, 0);
            char *areaname = (char *) sqlite3_column_text(statement, 1);
            NSString *name = [[NSString alloc] initWithUTF8String:areaname];
            AreaInfo *areaInfo = [[AreaInfo alloc] initWithAreaId:areaid areaName:name];
            [retval addObject:areaInfo];
            [name release];
            [areaInfo release];
        }
        sqlite3_finalize(statement);
    }
    return retval;
}

-(NSArray *) getCityWithProvinceId:(int) provinceId {
    NSMutableArray *retval = [[[NSMutableArray alloc] init] autorelease];
    NSString *query = [NSString stringWithFormat:@"SELECT areaid, areaname FROM area where rootid=%d order by orders ASC",provinceId];
    //@"SELECT areaid, areaname FROM area where rootid=0 order by orders ASC";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil)
        == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int areaid = sqlite3_column_int(statement, 0);
            char *areaname = (char *) sqlite3_column_text(statement, 1);
            NSString *name = [[NSString alloc] initWithUTF8String:areaname];
            AreaInfo *areaInfo = [[AreaInfo alloc] initWithAreaId:areaid areaName:name];
            [retval addObject:areaInfo];
            [name release];
            [areaInfo release];
        }
        sqlite3_finalize(statement);
    }
    return retval;
}

- (void)dealloc {
    sqlite3_close(_database);
    [super dealloc];
}

@end
