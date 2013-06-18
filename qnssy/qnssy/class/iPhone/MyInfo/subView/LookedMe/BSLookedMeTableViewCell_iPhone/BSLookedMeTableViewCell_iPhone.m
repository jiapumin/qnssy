//
//  MyTableViewCell.m
//  ContactDocFilesManage
//
//  Created by Sophie Sun on 12-4-26.
//  Copyright (c) 2012年 baosight. All rights reserved.
//

#import "BSLookedMeTableViewCell_iPhone.h"

@implementation BSLookedMeTableViewCell_iPhone

- (IBAction)clickAskMeButton:(id)sender {
    
}

- (void)reloadData:(NSDictionary *)dic{
    
    self.userVo = dic;
    
    self.nickname.text = [dic objectForKey:@"username"];
    
    self.nickname.textColor = [UIColor colorWithRed:198/255.f green:21/255.f blue:73/277.f alpha:1.f];
    
    self.myInfo.text = [NSString stringWithFormat:@"%@岁 | %@cm",[self.userVo objectForKey:@"age"],[self.userVo objectForKey:@"height"]];
    self.myInfo.textColor = [UIColor colorWithRed:78/255.f green:77/255.f blue:80/277.f alpha:1.f];
    

    
    NSArray * infoArray = [DataParseUtil myInfoData:@"salary"];
    
    NSDictionary *salaryDic = [infoArray objectAtIndex:1];
    //赋值用户信息
    NSString *salary = [salaryDic objectForKey:[self.userVo objectForKey:@"salary"]];

    NSString *marrystatus = [salaryDic objectForKey:[self.userVo objectForKey:@"marrystatus"]];
    
    NSString *city = [self.userVo objectForKey:@"city"];
    
    if (city == nil ) city = @"";
    
    self.myInfo2.text = [NSString stringWithFormat:@"%@ | %@ | %@",city,marrystatus,salary];
    self.myInfo2.textColor = [UIColor colorWithRed:78/255.f green:77/255.f blue:80/277.f alpha:1.f];
    
    [self requestMyImage:[self.userVo objectForKey:@"imageurl"]];
}

#pragma mark - 请求图片
- (void)requestMyImage:(NSString *)imageUrl{
    
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
    [_userVo release];
    [_leftImageView release];
    [_nickname release];
    [_myInfo release];
    [_myInfo2 release];
    [_askMeButton release];
    [super dealloc];
}
@end
