//
//  MyTableViewCell.m
//  ContactDocFilesManage
//
//  Created by Sophie Sun on 12-4-26.
//  Copyright (c) 2012年 baosight. All rights reserved.
//

#import "BSPublicTableCell_iPhone.h"

@implementation BSPublicTableCell_iPhone

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    self.bgImage.image = [UIImage imageNamed:self.selectedBgImageName];
    self.leftImage.image = [UIImage imageNamed:self.selectedLeftImageName];
    self.menuLabel.textColor = [UIColor colorWithRed:223.f/255 green:42.f/255 blue:106.f/255 alpha:1.f];
    //调用父类的touch方法是为了继续调用tableView的回调方法
    [super touchesBegan:touches withEvent:event];
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    self.bgImage.image = [UIImage imageNamed:self.noSelectedBgImageName];
    self.leftImage.image = [UIImage imageNamed:self.noSelectedLeftImageName];
    self.menuLabel.textColor = [UIColor blackColor];
    [super touchesEnded:touches withEvent:event];
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    self.bgImage.image = [UIImage imageNamed:self.noSelectedBgImageName];
    self.leftImage.image = [UIImage imageNamed:self.noSelectedLeftImageName];
    self.menuLabel.textColor = [UIColor blackColor];
    [super touchesCancelled:touches withEvent:event];
}
- (void)dealloc {
    [_selectedLeftImageName release];
    [_noSelectedLeftImageName release];
    [_selectedBgImageName release];
    [_noSelectedBgImageName release];
    [_leftImage release];
    [_menuLabel release];
    [_bgImage release];
    [super dealloc];
}
@end
