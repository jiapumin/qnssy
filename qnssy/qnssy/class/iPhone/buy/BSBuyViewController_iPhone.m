//
//  BSBuyViewController_iPhone.m
//  qnssy
//
//  Created by jpm on 13-3-12.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSBuyViewController_iPhone.h"

@interface BSBuyViewController_iPhone ()

@end

@implementation BSBuyViewController_iPhone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //请求网络数据
    NSMutableDictionary *requestData = [[[NSMutableDictionary alloc] init] autorelease];
//    [requestData setObject:APPOINTMENT_SUBITEM_SERVICE_NAME forKey:@"wsName"];
//    [requestData setObject:WEBSERVICE_NAMESPACE forKey:@"xmlNS"];
//    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    [data setObject:@"jiapumin@163.com" forKey:@"username"];
    [data setObject:@"jiapumin" forKey:@"password"];
    
    [requestData setObject:data forKey:@"data"];
    
    [[BSContainer instance].serviceAgent callWebServiceWithObject:self
                                                      requestDict:requestData
                                                           target:self
                                                  successCallBack:@selector(loginSucceess: data:)
                                                     failCallBack:@selector(loginFailed: data:)];
    
    
    [data release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loginSucceess:(id)sender data:(NSDictionary *)dic {
    NSLog(@"%@",dic);
}

- (void)loginFailed:(id)sender data:(NSDictionary *)dic {
    NSLog(@"%@",dic);
}
@end
