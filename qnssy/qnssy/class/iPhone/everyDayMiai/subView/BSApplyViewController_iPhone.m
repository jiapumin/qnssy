//
//  BSApplyViewController_iPhone.m
//  qnssy
//
//  Created by jpm on 13-4-23.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSApplyViewController_iPhone.h"

#import "MiaiApplyRequestVo.h"
#import "MiaiApplyResponseVo.h"

@interface BSApplyViewController_iPhone (){
     MBProgressHUD *progressHUD;
}

@end

@implementation BSApplyViewController_iPhone

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
    
    self.title = @"我要报名";
    
    [self initHUDView];
    
    self.titleLabel.text = self.subject;
    UIColor *color1 = [UIColor colorWithRed:198/255.f green:21/255.f blue:73/277.f alpha:1.f];
    self.titleLabel.textColor = color1;
    
//    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
////    rightButton.frame = CGRectMake(0, 0, 73, 25);
//    rightButton.frame = CGRectMake(0, 0, 89, 41);
////    [rightButton setImage:[UIImage imageNamed:@"1登录背景"] forState:UIControlStateNormal];
//    [rightButton setBackgroundImage:[UIImage imageNamed:@"1登录背景"] forState:UIControlStateNormal];
//    [rightButton setTitle:@"报名" forState:UIControlStateNormal];
//    [rightButton addTarget:self action:@selector(loadServiceData) forControlEvents:UIControlEventTouchUpInside];
//    
//    self.navigationItem.rightBarButtonItem =
//    [[[UIBarButtonItem alloc] initWithCustomView:rightButton] autorelease];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_subject release];
    [_datingid release];
    [_myTableView release];
    [_titleLabel release];
    [_phoneText release];
    [_contentText release];
    [_hideLabel release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setSubject:nil];
    [self setDatingid:nil];
    [self setMyTableView:nil];
    [self setTitleLabel:nil];
    [self setPhoneText:nil];
    [self setContentText:nil];
    [self setHideLabel:nil];
    [super viewDidUnload];
}

- (void)initHUDView{
    //-------加载框
    progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:progressHUD];
    
    progressHUD.labelText = @"数据加载中...";
    
}
- (void)loadServiceData{
    
    [self.contentText resignFirstResponder];
    [self.phoneText resignFirstResponder];
    
    if ([self.contentText.text isEqualToString:@""] ||[self.phoneText.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"输入信息不完整" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    
    [progressHUD show:YES];
    MiaiApplyRequestVo *vo = [[MiaiApplyRequestVo alloc] initWithId:self.datingid contact:self.contentText.text message:self.phoneText.text];
    [[BSContainer instance].serviceAgent callServletWithObject:self
                                                   requestDict:vo.mReqDic
                                                        target:self
                                               successCallBack:@selector(requestSucceess:data:)
                                                  failCallBack:@selector(requestFailed:data:)];
    
    [vo release];
}
#pragma mark - 回调方法

- (void)requestSucceess:(id)sender data:(NSDictionary *)dic {
    
    MiaiApplyResponseVo *vo = [[MiaiApplyResponseVo alloc] initWithDic:dic];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:vo.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    
    [progressHUD hide:YES];
    
    [vo release];
    
    [self.navigationController popViewControllerAnimated:YES];

}


- (void)requestFailed:(id)sender data:(NSDictionary *)dic {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"网络异常，请检查网络连接后重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    [progressHUD hide:YES];
}

- (IBAction)clickSubmitButton:(id)sender {
    [self loadServiceData];
}
-(void)textViewDidChange:(UITextView *)textView
{
    self.contentText.text =  textView.text;
    if (textView.text.length == 0) {
        self.hideLabel.text = @"请输入留言内容...";
    }else{
        self.hideLabel.text = @"";
    }
}
@end
