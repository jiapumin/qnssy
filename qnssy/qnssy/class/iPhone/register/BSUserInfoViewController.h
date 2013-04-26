//
//  BSUserInfoViewController.h
//  qnssy
//
//  Created by juchen on 13-3-19.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "QuickDialogController.h"

#define kPleaseSelect @"请选择"

@interface BSUserInfoViewController : QuickDialogController <QuickDialogStyleProvider, QuickDialogEntryElementDelegate>{
    NSDictionary *areaDic;
    NSArray *province;
    NSArray *city;
    NSArray *district;
    
    NSString *selectedProvince;
}

// params begin
@property (retain, nonatomic) NSString *userName;
@property (retain, nonatomic) NSString *mobile;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *sex;
@property (nonatomic, retain) NSString *height;
@property (nonatomic, retain) NSString *year;
@property (nonatomic, retain) NSString *month;
@property (nonatomic, retain) NSString *day;
@property (nonatomic, retain) NSString *marrystatus;
@property (nonatomic, retain) NSString *lovekind;
@property (nonatomic, retain) NSString *education;
@property (nonatomic, retain) NSString *salary;
@property (nonatomic, retain) NSString *provinceid;
@property (nonatomic, retain) NSString *cityid;
// params end
@property (nonatomic, retain) QRootElement * root;
@property (nonatomic, retain) QuickDialogTableView *quickDialogTableView;
//@property (retain, nonatomic) IBOutlet UINavigationBar *myNavigationBar;

@end
