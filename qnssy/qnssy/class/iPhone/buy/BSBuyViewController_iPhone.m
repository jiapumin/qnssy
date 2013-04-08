//
//  BSBuyViewController_iPhone.m
//  qnssy
//
//  Created by jpm on 13-3-12.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSBuyViewController_iPhone.h"

#import "LoginRequestVo.h"
#import "LoginResponseVo.h"

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
    
    LoginRequestVo *vo = [[LoginRequestVo alloc] initWithUsername:@"jiapumin@163.com" password:@"jiapumin"];
    
    [[BSContainer instance].serviceAgent callServletWithObject:self
                                                   requestDict:vo.mReqDic
                                                        target:self
                                               successCallBack:@selector(loginSucceess:data:)
                                                  failCallBack:@selector(loginFailed:data:)];
    
    [vo release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loginSucceess:(id)sender data:(NSDictionary *)dic {
    LoginResponseVo *vo = [[LoginResponseVo alloc] initWithDic:dic];
    
    
    NSLog(@"用户id:%@--登录消息:%@",vo.userInfo.userId,vo.message);
}

- (void)loginFailed:(id)sender data:(NSDictionary *)dic {
    NSLog(@"%@",dic);
}
@end
