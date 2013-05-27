//
//  BSApplyViewController_iPhone.m
//  qnssy
//
//  Created by jpm on 13-4-23.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSSendMailViewController_iPhone.h"

@interface BSSendMailViewController_iPhone (){
     MBProgressHUD *progressHUD;
}

@end

@implementation BSSendMailViewController_iPhone

- (id)initWithNibName:(NSString *)nibNameOrNil userid:(NSString *)userid username:(NSString *)username
{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if (self) {
        // Custom initialization
        self.username = username;
        self.userid = userid;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"发邮件";
    
    [self initHUDView];
    
    self.titleLabel.text = [NSString stringWithFormat:@"给 %@ 写信",self.username];
    UIColor *color1 = [UIColor colorWithRed:198/255.f green:21/255.f blue:73/277.f alpha:1.f];
    self.titleLabel.textColor = color1;
    
    //右上角发送按钮
    UIButton *topRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect btnFrame = CGRectMake(0.0, 0.0, 40.0, 27.0);
    topRightButton.frame =btnFrame;
    [topRightButton setImage:[UIImage imageNamed:@"28设置按钮"]
                    forState:UIControlStateNormal];
    [topRightButton addTarget:self
                       action:@selector(clickSubmitButton:)
             forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:topRightButton] autorelease];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_username release];
    [_userid release];
    [_titleLabel release];
    [_contentText release];
    [_hideLabel release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setUsername:nil];
    [self setUserid:nil];
    [self setTitleLabel:nil];
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
    
    if ([self.contentText.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入邮件内容" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    
    [progressHUD show:YES];
    SendMailRequestVo *vo = [[SendMailRequestVo alloc] initWithUserId:self.userid content:self.contentText.text];
    [[BSContainer instance].serviceAgent callServletWithObject:self
                                                   requestDict:vo.mReqDic
                                                        target:self
                                               successCallBack:@selector(requestSucceess:data:)
                                                  failCallBack:@selector(requestFailed:data:)];
    
    [vo release];
}
#pragma mark - 回调方法

- (void)requestSucceess:(id)sender data:(NSDictionary *)dic {
    
    SendMailResponseVo *vo = [[SendMailResponseVo alloc] initWithDic:dic];
    
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
        self.hideLabel.text = @"请输入邮件内容...";
    }else{
        self.hideLabel.text = @"";
    }
}
@end
