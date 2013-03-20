//
//  BSUserInfoViewController.m
//  qnssy
//
//  Created by juchen on 13-3-19.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSUserInfoViewController.h"
#import "BSSexElement.h"

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
//        QSection *section6 = [[QSection alloc] init];
//        QSection *section7 = [[QSection alloc] init];
//        QSection *section8 = [[QSection alloc] init];
        
        QAppearance *appearance = [[QAppearance alloc] init];
        [appearance setValueColorEnabled:[UIColor colorWithRed:0.8 green:0.058 blue:0.325 alpha:1]];
        
        QEntryElement *nickEntry = [[QEntryElement alloc] initWithTitle:@"昵称" Value:nil Placeholder:@"请输入昵称"];
        
        BSSexElement *sexEntry = [[BSSexElement alloc] initWithItems:[[NSArray alloc] initWithObjects:@"男", @"女", nil] selected:0 title:@"性别"];

        NSArray *yearArray = [NSArray arrayWithObjects:@"1990",@"1991", nil];
        NSArray *monthArray = [NSArray arrayWithObjects:@"01",@"02", nil];
        QPickerElement *birthdayPicker = [[QPickerElement alloc] initWithTitle:@"生日" items:@[yearArray, monthArray] value:@"请选择"];
        birthdayPicker.appearance = appearance;
        birthdayPicker.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        NSArray *workAreaArray = [[NSArray alloc] initWithObjects:@"北京", @"上海", nil];
        QPickerElement *workAreaElement = [[QPickerElement alloc] initWithTitle:@"婚姻状况" items: @[workAreaArray] value:@"请选择"];
        workAreaElement.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        workAreaElement.appearance = appearance;
        
        NSArray *hunyinArray = [[NSArray alloc] initWithObjects:@"已婚", @"未婚", nil];
        QPickerElement *hunyin = [[QPickerElement alloc] initWithTitle:@"婚姻状况" items: @[hunyinArray] value:@"请选择"];
        hunyin.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        hunyin.appearance = appearance;
        
        [section addElement:nickEntry];
        [section2 addElement:sexEntry];
        [section3 addElement:birthdayPicker];
        [section4 addElement:workAreaElement];
        [section5 addElement:hunyin];
        
        [self.root addSection:section];
        [self.root addSection:section2];
        [self.root addSection:section3];
        [self.root addSection:section4];
        [self.root addSection:section5];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
