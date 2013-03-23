//
//  BSUserInfoViewController.h
//  qnssy
//
//  Created by juchen on 13-3-19.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "QuickDialogController.h"

#define kPleaseSelect @"请选择"

@interface BSUserInfoViewController : QuickDialogController <QuickDialogStyleProvider, QuickDialogEntryElementDelegate, QuickDialogStyleProvider>{
    NSDictionary *areaDic;
    NSArray *province;
    NSArray *city;
    NSArray *district;
    
    NSString *selectedProvince;
}

@property (nonatomic, retain) QRootElement * root;
@property (nonatomic, retain) QuickDialogTableView *quickDialogTableView;
@property (retain, nonatomic) IBOutlet UINavigationBar *myNavigationBar;

- (IBAction)clickBackButton:(id)sender;
@end
