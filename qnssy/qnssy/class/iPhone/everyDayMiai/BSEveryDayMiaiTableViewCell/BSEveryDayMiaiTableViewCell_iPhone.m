//
//  MyTableViewCell.m
//  ContactDocFilesManage
//
//  Created by Sophie Sun on 12-4-26.
//  Copyright (c) 2012年 baosight. All rights reserved.
//

#import "BSEveryDayMiaiTableViewCell_iPhone.h"

@implementation BSEveryDayMiaiTableViewCell_iPhone

- (IBAction)clickBaoMingButton:(id)sender{
    
}

- (void)reloadData:(NSDictionary *)dic{
    
    self.userVo = dic;
    
    self.title.text = [dic objectForKey:@"subject"];
    
    UIColor *color1 = [UIColor colorWithRed:198/255.f green:21/255.f blue:73/277.f alpha:1.f];
    
    UIColor *color2 = [UIColor colorWithRed:78/255.f green:77/255.f blue:80/277.f alpha:1.f];
    
    self.title.textColor = color1;
    
    self.time.text = [dic objectForKey:@"datingdate"];//[NSString stringWithFormat:@"%@岁 | %@cm",[self.userVo objectForKey:@"age"],[self.userVo objectForKey:@"height"]];
    self.time.textColor = color2;
    
    self.place.text = [NSString stringWithFormat:@"%@ %@",[dic objectForKey:@"pr"],[dic objectForKey:@"city"]];
    self.place.textColor = color2;
    
    self.personNum.text = [NSString stringWithFormat:@"当前报名%@人",[dic objectForKey:@"datingnum"]];
    self.personNum.textColor = color1;
    
    BOOL status = YES;
    NSString *dataStr = [dic objectForKey:@"datingdate"];
//    dataStr = @"2013.04.23";
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy.MM.dd"];//设定时间格式,这里可以设置成自己需要的格式
    NSDate *date =[dateFormat dateFromString:dataStr];
    NSDate *newDate = [NSDate date];
    if ([newDate laterDate:date]) {
        status = NO;
    }
    
    
    self.status.text = status ? @"进行中" : @"已结束";
    self.status.textColor = color1;

    if (status) {
        [self.baoMingButton setImage:[UIImage imageNamed:@"24报名按钮"] forState:UIControlStateNormal];
    }else{
        [self.baoMingButton setImage:[UIImage imageNamed:@"24报名按钮"] forState:UIControlStateNormal];
        self.baoMingButton.enabled = NO;
    }
    
    
    [self requestMyImage:[self.userVo objectForKey:@"imgageurl"]];
}

#pragma mark - 请求图片
- (void)requestMyImage:(NSString *)imageUrl{
    @try {
    
        NSArray *tempArray = [imageUrl componentsSeparatedByString:@"/"];
        NSString *imageName = [NSString stringWithFormat:@"%@_%@",[tempArray objectAtIndex:(tempArray.count -2)],[tempArray lastObject]];
        
        NSString *filePath = [[[KBBreakpointTransmission instance] getTargetFloderPath:IMAGE_PATH] stringByAppendingPathComponent:imageName];
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        
        if (image != nil){
            //当前显示那张图片
            self.leftImageView.image = image;
        }else{
            //先设置默认图就是加载中的图片
            UIImage *loadingImage = [UIImage imageNamed:@"5暂无照片头像"];
            
            [self.leftImageView setImage:loadingImage];
            //异步加载图片 并保存到本地
            KBBTFileInfoVo *vo = [[[KBBTFileInfoVo alloc] init] autorelease];
            NSLog(@"urlStr==%@",imageUrl);
            //主键作为文件名保存
            vo.fileName = imageName;
            vo.fileURL = imageUrl;
            vo.fileSize = @"123";
            vo.sender = @"image";
            vo.filePath = IMAGE_PATH;
            [[KBBreakpointTransmission instance] loadDataWithDelegate:self
                                                              success:@selector(imageDownloadFinish:)
                                                                 fail:nil
                                                                start:nil
                                                             progress:nil
                                                             fileInfo:vo];
        }
    
    }
    @catch (NSException *exception) {
        NSLog(@"图片路径不对");
    }
}

#pragma mark - 异步请求数据成功

- (void)imageDownloadFinish:(KBBTFileInfoVo *)vo{
    //获取本地已经下载完成图片的路径
    NSString *filePath = [[[KBBreakpointTransmission instance] getTargetFloderPath:vo.filePath] stringByAppendingPathComponent:vo.fileName];
    NSLog(@"加载路径图片目录：%@",filePath);
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    
    if (image == nil) return;
    
    [self.leftImageView setImage:image];
}

- (void)dealloc {
    [_baoMingButton release];
    [_userVo release];
    [_leftImageView release];
    [_time release];
    [_personNum release];
    [_place release];
    [_status release];
    [_personNum release];
    [super dealloc];
}
@end
