//
//  BSUserDetailInfoTableViewCell1_iPhone.m
//  qnssy
//
//  Created by jpm on 13-4-19.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSUserDetailInfoTableViewCell4_iPhone.h"

@implementation BSUserDetailInfoTableViewCell4_iPhone

- (void)reloadData:(NSDictionary *)dic{
    
    self.userVo = dic;
    
    self.locationLabel.text = [dic objectForKey:@"usercity"];
    
    
    self.myInfoLabel.text = [NSString stringWithFormat:@"%@岁 | %@厘米 | %@",[dic objectForKey:@"age"],[dic objectForKey:@"height"],[dic objectForKey:@"userprovice"]];
    
    [self requestMyImage:[self.userVo objectForKey:@"imageurl"]];
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
    [_myInfoLabel release];
    [_locationLabel release];
    [super dealloc];
}
@end
