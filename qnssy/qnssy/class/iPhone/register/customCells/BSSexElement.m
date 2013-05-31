//
//  BSSexElement.m
//  qnssy
//
//  Created by juchen on 13-3-20.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSSexElement.h"

@implementation BSSexElement{
    QuickDialogController *_controller;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    _controller = controller;
    QTableViewCell *cell = [[[QTableViewCell alloc] init] autorelease];
    cell.backgroundView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)] autorelease];
    cell.backgroundColor = [UIColor clearColor];
    
    NSMutableArray * item = [NSMutableArray arrayWithArray:_items];
//    [item addObject:@""];
//    [item insertObject:@"" atIndex:0];
    CGRect frame = cell.contentView.bounds;
    frame.origin.x -=1;
    frame.size.width += 2;
    frame.size.height += 1;
    UIView * container = [[UIView alloc] initWithFrame: frame];
    container.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    container.clipsToBounds = YES;
    container.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:container];
    CALayer *layer = container.layer;
    layer.cornerRadius = 8.0;
    UIColor *color = [UIColor colorWithRed:0.603 green:0.603 blue:0.603 alpha:1];
    CGColorRef colorref = [color CGColor];
    layer.borderColor = colorref;
    layer.borderWidth = 1.0;
    
    UILabel *title = [[UILabel alloc] init];
    title.frame = CGRectMake(9, 0, 80, frame.size.height);
    title.text = @"性别";
    title.textColor = [UIColor colorWithRed:0.294 green:0.294 blue:0.294 alpha:1];;
    title.backgroundColor = [UIColor clearColor];
    
    UISegmentedControl *control = [[UISegmentedControl alloc] initWithItems:item];
    [control addTarget:self action:@selector(handleSegmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    frame.origin.x = frame.size.width - 90 - 10;
    frame.size.width = 90;
    frame.origin.y = 8;
    frame.size.height -= 14;
    control.frame = frame;
    control.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    control.segmentedControlStyle = UISegmentedControlStylePlain;
    control.selectedSegmentIndex = _selected;
    control.tag = 4321;
    [container addSubview:title];
    [container addSubview:control];
    [title release];
    [control release];
    [container release];
    return cell;
}

@end
