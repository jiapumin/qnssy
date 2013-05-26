//
//  BSUserDetailInfoTableViewCell1_iPhone.m
//  qnssy
//
//  Created by jpm on 13-4-19.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSUserDetailInfoTableViewCell3_iPhone.h"

#import "AddAttentionRequestVo.h"
#import "AddAttentionResponseVo.h"

#import "BSSendMailViewController_iPhone.h"

@implementation BSUserDetailInfoTableViewCell3_iPhone


- (void)dealloc {
    [_userVo release];
    [super dealloc];
}
- (IBAction)clickGZButton:(id)sender {
    NSLog(@"添加关注");
    [self loadGZServiceData];
}

- (IBAction)clickXXButton:(id)sender {
    NSLog(@"写信");
    NSString *userid = [self.userVo objectForKey:@"userid"];
    NSString *username = [self.userVo objectForKey:@"username"];
    BSSendMailViewController_iPhone *smvc = [[BSSendMailViewController_iPhone alloc] initWithNibName:@"BSSendMailViewController_iPhone" userid:userid username:username];

    
    [self.delegate.navigationController pushViewController:smvc animated:YES];
}

- (IBAction)clickTJButton:(id)sender {
    NSLog(@"推荐");
}

- (IBAction)clickWHButton:(id)sender {
        NSLog(@"问候");
}

#pragma mark - request
- (void)loadGZServiceData{
    AddAttentionRequestVo *vo = [[AddAttentionRequestVo alloc] initWithUserId:[self.userVo objectForKey:@"userid"]];
    [[BSContainer instance].serviceAgent callServletWithObject:self
                                                   requestDict:vo.mReqDic
                                                        target:self
                                               successCallBack:@selector(requestGZSucceess:data:)
                                                  failCallBack:@selector(requestGZFailed:data:)];
    
    [vo release];
}


#pragma mark - 回调方法

- (void)requestGZSucceess:(id)sender data:(NSDictionary *)dic {
    
    AddAttentionResponseVo *vo = [[AddAttentionResponseVo alloc] initWithDic:dic];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:vo.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    
    [vo release];
}


- (void)requestGZFailed:(id)sender data:(NSDictionary *)dic {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"网络异常，请检查网络连接后重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

@end
