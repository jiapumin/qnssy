//
//  BSMessageDetailsViewController_iPhone.m
//  qnssy
//
//  Created by juchen on 13-5-8.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSMessageDetailsViewController_iPhone.h"

@interface BSMessageDetailsViewController_iPhone ()

@end

@implementation BSMessageDetailsViewController_iPhone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UILabel *sender = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 75, 21)];
        sender.text = @"发送人：";
        sender.textColor = [UIColor colorWithRed:214./255 green:6./255 blue:40./255 alpha:1];
        sender.backgroundColor = [UIColor clearColor];
        [self.view addSubview:sender];
        [sender release];
        self.senderLabel = [[UILabel alloc] initWithFrame:CGRectMake(103, 20, 197, 21)];
        self.senderLabel.textColor = [UIColor colorWithRed:61./255 green:59./255 blue:55./255 alpha:1];
        self.senderLabel.backgroundColor = [UIColor clearColor];
        [self.view addSubview:self.senderLabel];
        [self.senderLabel release];
        
        UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(20, 49, 85, 21)];
        date.text = @"发送日期：";
        date.textColor = [UIColor colorWithRed:214./255 green:6./255 blue:40./255 alpha:1];
        date.backgroundColor = [UIColor clearColor];
        [self.view addSubview:date];
        [date release];
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(103, 49, 197, 21)];
        self.dateLabel.textColor = [UIColor colorWithRed:61./255 green:59./255 blue:55./255 alpha:1];
        self.dateLabel.backgroundColor = [UIColor clearColor];
        [self.view addSubview:self.dateLabel];
        [self.dateLabel release];
        
        self.textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 78, 280, 450)];
        self.textView.textColor = [UIColor colorWithRed:61./255 green:59./255 blue:55./255 alpha:1];
        self.textView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:self.textView];
        [self.textView release];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:247.f/255 green:232.f/255 blue:232.f/255 alpha:1.f];
    
    UIButton *topLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //按钮大小
    CGRect btnFrame = CGRectMake(0.0, 4.0, 29.0, 25.0);
    topLeftButton.frame =btnFrame;
    
    //设置返回按钮图片和方法
    [topLeftButton setImage:[UIImage imageNamed:@"2向左返回箭头"]
                   forState:UIControlStateNormal];
    
    [topLeftButton addTarget:self
                      action:@selector(popViewContoller)
            forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * topLeftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:topLeftButton];
    self.navigationItem.leftBarButtonItem = topLeftBarButtonItem;
    [topLeftBarButtonItem release];
}

- (void)popViewContoller{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [super dealloc];
}
- (void)viewDidUnload {
    [super viewDidUnload];
}
@end
