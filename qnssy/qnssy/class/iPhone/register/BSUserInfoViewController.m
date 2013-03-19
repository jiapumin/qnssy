//
//  BSUserInfoViewController.m
//  qnssy
//
//  Created by juchen on 13-3-19.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSUserInfoViewController.h"

@interface BSUserInfoViewController ()

@end

@implementation BSUserInfoViewController

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
}

- (void)setQuickDialogTableView:(QuickDialogTableView *)aQuickDialogTableView {
    [super setQuickDialogTableView:aQuickDialogTableView];
    
    self.quickDialogTableView.backgroundView = nil;
    self.quickDialogTableView.backgroundColor = [UIColor colorWithRed:0.968 green:0.878 blue:0.909 alpha:1];
    self.quickDialogTableView.bounces = NO;
    self.quickDialogTableView.styleProvider = self;
    
    ((QEntryElement *)[self.root elementWithKey:@"login"]).delegate = self;
}

-(void) cell:(UITableViewCell *)cell willAppearForElement:(QElement *)element atIndexPath:(NSIndexPath *)indexPath{
    cell.textLabel.textColor = [UIColor grayColor];
}

- (QuickDialogController *) initWithRoot:(QRootElement *)rootElement {
    self = [super init];
    if (self) {
        self.root = rootElement;
        self.resizeWhenKeyboardPresented =YES;
        self.root.title = @"注册";
        self.root.grouped = YES;
        QSection *section = [[QSection alloc] init];
        QSection *section2 = [[QSection alloc] init];
        QSection *section3 = [[QSection alloc] init];
        QSection *section4 = [[QSection alloc] init];
        QSection *section5 = [[QSection alloc] init];
        QSection *section6 = [[QSection alloc] init];
        QSection *section7 = [[QSection alloc] init];
        QSection *section8 = [[QSection alloc] init];
        
        QEntryElement *nickEntry = [[QEntryElement alloc] initWithTitle:@"昵称" Value:nil Placeholder:@"请输入昵称"];
//        QEntryElement *sexEntry = [[QEntryElement alloc] initWithTitle:@"性别" Value:nil Placeholder:@"请输入性别"];
        QSegmentedElement *sexEntry = [[QSegmentedElement alloc] init];
        sexEntry.items = [[NSArray alloc] initWithObjects:@"男", @"女", nil];
        sexEntry.title = @"性别";
        sexEntry.image = nil;

        NSArray *yearArray = [NSArray arrayWithObjects:@"1990",@"1991", nil];
        NSArray *monthArray = [NSArray arrayWithObjects:@"01",@"02", nil];
        QPickerElement *birthdayPicker = [[QPickerElement alloc] initWithTitle:@"生日" items:@[yearArray, monthArray] value:nil];
        
        
        [section addElement:nickEntry];
        [section2 addElement:sexEntry];
        [section3 addElement:birthdayPicker];
        
        [self.root addSection:section];
        [self.root addSection:section2];
        [self.root addSection:section3];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
