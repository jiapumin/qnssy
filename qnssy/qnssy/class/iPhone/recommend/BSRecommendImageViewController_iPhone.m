//
//  BSRecommendImageViewController_iPhone.m
//  qnssy
//
//  Created by jpm on 13-3-31.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSRecommendImageViewController_iPhone.h"
#import "BSUserDetailInfoViewController.h"

@interface BSRecommendImageViewController_iPhone ()

@end

@implementation BSRecommendImageViewController_iPhone

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
    
    
    [self requestMyImage:[self.imageVo objectForKey:@"userimg"] imageId:[self.imageVo objectForKey:@"imageId"]];
    
    self.nickNameLabel.text = [self.imageVo objectForKey:@"username"];
    
    self.spaceLabel.text = [self.imageVo objectForKey:@"city"];
    
    self.neixindubaiLabel.text = [self.imageVo objectForKey:@"infelt"];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_imageVo release];
    [_nickNameLabel release];
    [_spaceLabel release];
    [_neixindubaiLabel release];
    [_bgImageView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setImageVo:nil];
    [self setNickNameLabel:nil];
    [self setSpaceLabel:nil];
    [self setNeixindubaiLabel:nil];
    [self setBgImageView:nil];
    [super viewDidUnload];
}
- (IBAction)clickInfoButton:(id)sender {
    
    
    if ([self.delegate respondsToSelector:@selector(pushViewController:)]) {
        BSUserDetailInfoViewController *vc = [[[BSUserDetailInfoViewController alloc] init] autorelease];
         [self.delegate pushViewController:vc];
    }
   
}
#pragma mark - 请求图片
- (void)requestMyImage:(NSString *)imageUrl imageId:(NSString *)imageId{
    NSArray *tempArray = [imageUrl componentsSeparatedByString:@"/"];
    NSString *imageName = [NSString stringWithFormat:@"%@_%@",[tempArray objectAtIndex:(tempArray.count -2)],[tempArray lastObject]];
    
    NSString *filePath = [[[KBBreakpointTransmission instance] getTargetFloderPath:IMAGE_PATH] stringByAppendingPathComponent:imageName];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    
    if (image != nil){
        //当前显示那张图片
        self.bgImageView.image = image;
    }else{
        //先设置默认图就是加载中的图片
        UIImage *loadingImage = [UIImage imageNamed:@"5暂无照片头像"];
        
        [self.bgImageView setImage:loadingImage];
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
    
    [self.bgImageView setImage:image];
}
@end
