//
//  BSRecommendImageViewController_iPhone.h
//  qnssy
//
//  Created by jpm on 13-3-31.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BSRecommendImageDelegate <NSObject>
@optional
- (void)pushViewController:(UIViewController *)vc;
@end

@interface BSRecommendImageViewController_iPhone : UIViewController

@property (retain, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (retain, nonatomic) IBOutlet UILabel *spaceLabel;
@property (retain, nonatomic) IBOutlet UILabel *neixindubaiLabel;
@property (nonatomic, assign)   id<BSRecommendImageDelegate>    delegate;
- (IBAction)clickInfoButton:(id)sender;

@end


