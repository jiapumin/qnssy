//
//  BSUserInfoViewController.h
//  qnssy
//
//  Created by juchen on 13-3-19.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "QuickDialogController.h"

@interface BSUserInfoViewController : QuickDialogController <QuickDialogStyleProvider, QuickDialogEntryElementDelegate>

@property (nonatomic, retain) QRootElement * root;
@property (nonatomic, retain) QuickDialogTableView *quickDialogTableView;

@end
