//
//  BSUserDetailInfoTableViewCell1_iPhone.m
//  qnssy
//
//  Created by jpm on 13-4-19.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSUserDetailInfoTableViewCell2_iPhone.h"

#import "BSRecommendUserInfoImageListRequestVo.h"
#import "BSRecommendUserInfoImageListResponseVo.h"


@implementation BSUserDetailInfoTableViewCell2_iPhone{
}

- (void)reloadData:(NSDictionary *)dic{
    
    self.userVo = dic;
    
    BSRecommendUserInfoImageListRequestVo *vo =
    [[BSRecommendUserInfoImageListRequestVo alloc] initWithUserId:[self.userVo objectForKey:@"userid"]
                                                          pagenum:@"1"
                                                        pagecount:@"40"];
    [[BSContainer instance].serviceAgent callServletWithObject:self
                                                   requestDict:vo.mReqDic
                                                        target:self
                                               successCallBack:@selector(requestSucceess:data:)
                                                  failCallBack:@selector(requestFailed:data:)];
    
    [vo release];
    
}

- (void)dealloc {
    [_imageList release];
    [_userVo release];
    [_myScrollView release];
    [super dealloc];
}
#pragma mark - 回调方法

- (void)requestSucceess:(id)sender data:(NSDictionary *)dic {
    
    BSRecommendUserInfoImageListResponseVo *vo = [[BSRecommendUserInfoImageListResponseVo alloc] initWithDic:dic];
    self.imageList = vo.imageList;
    if (vo.status == 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:vo.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    
    [self initScrollSubView];
    
    [vo release];
}


- (void)requestFailed:(id)sender data:(NSDictionary *)dic {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"网络异常，请检查网络连接后重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}
#pragma mark - 滚动图片
- (void)initScrollSubView{
    int imageWidth = 68;
    int imageNum = [self.imageList count];
    int scrollWidth = (imageWidth + 4) * imageNum;
    
    self.myScrollView.contentSize = CGSizeMake(scrollWidth, self.myScrollView.frame.size.height);
    for (int i = 0; i<imageNum; i++) {
        
        CGRect imageViewFrame = CGRectMake(i * (imageWidth + 4), 0, imageWidth, 83);
        UIImageView *imageView = [[[UIImageView alloc] initWithFrame:imageViewFrame] autorelease];
        [self.myScrollView addSubview:imageView];
        
        NSString *url =  [[self.imageList objectAtIndex:i] objectForKey:@"imageurl"];
        [self requestMyImage:url imageView:imageView];
        
    }

}

#pragma mark - 请求图片
- (void)requestMyImage:(NSString *)imageUrl imageView:(UIImageView *)imageView{
    
    @try {
        NSArray *tempArray = [imageUrl componentsSeparatedByString:@"/"];
        NSString *imageName = [NSString stringWithFormat:@"%@_%@",[tempArray objectAtIndex:(tempArray.count -2)],[tempArray lastObject]];
        
        NSString *filePath = [[[KBBreakpointTransmission instance] getTargetFloderPath:IMAGE_PATH] stringByAppendingPathComponent:imageName];
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        
        if (image != nil){
            //当前显示那张图片
            imageView.image = image;
        }else{
            //先设置默认图就是加载中的图片
            UIImage *loadingImage = [UIImage imageNamed:@"图片加载中"];
            
            [imageView setImage:loadingImage];
            //异步加载图片 并保存到本地
            KBBTFileInfoVo *vo = [[[KBBTFileInfoVo alloc] init] autorelease];
            NSLog(@"urlStr==%@",imageUrl);
            //主键作为文件名保存
            vo.fileName = imageName;
            vo.fileURL = imageUrl;
            vo.fileSize = @"123";
            vo.sender = imageView;
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
    
    UIImageView *imageView = (UIImageView *)vo.sender;
    [imageView setImage:image];
}
@end
