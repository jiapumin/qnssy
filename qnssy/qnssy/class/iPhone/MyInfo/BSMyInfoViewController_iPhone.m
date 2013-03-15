//
//  BSMyInfoViewController_iPhone.m
//  qnssy
//
//  Created by jpm on 13-3-12.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSMyInfoViewController_iPhone.h"

@interface BSMyInfoViewController_iPhone ()

@end

@implementation BSMyInfoViewController_iPhone

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
    //开始加载图片
    //图片名字这个名字是从服务器获得
    NSString *imageName = [NSString stringWithFormat:@"%@",@"index2.jpg"];
    NSString *servieURL = @"http://www.qnssy.com/app/static/images/";
    //此处获得图片本地路径
    NSString *filePath = [[[KBBreakpointTransmission instance] getTargetFloderPath:@"image"] stringByAppendingPathComponent:imageName];
    
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    //如果本地存在图片就加载本地录图片
    if (image != nil) {
        
        [self.testImgeView setImage:image];
        
    }else{
        //先设置默认图就是加载中的图片
        UIImage *loadingImage = [UIImage imageNamed:@"zsk_img_loading.png"];
        
        [self.testImgeView setImage:loadingImage];
        //异步加载图片 并保存到本地
        NSString *urlStr = [NSString stringWithFormat:@"%@index2.jpg",servieURL];
        //创建一个要下载数据的vo
        KBBTFileInfoVo *vo = [[[KBBTFileInfoVo alloc] init] autorelease];
        
        NSLog(@"urlStr==%@",urlStr);
        //下载后要保存的文件名字
        vo.fileName = imageName;
        //下载文件的完整url地址
        vo.fileURL = urlStr;
        //下载文件的大小，默认随便写个数字
        vo.fileSize = @"123";
        //下载文件的唯一id,下载完成图片时使用
        vo.fileID = imageName;
        //文件要下载到哪个路径下
        vo.filePath = @"image";
        //开始下载，finishedDownload是完成下载后的回调函数
        [[KBBreakpointTransmission instance] loadDataWithDelegate:self
                                                          success:@selector(finishedDownload:)
                                                             fail:nil
                                                            start:nil
                                                         progress:nil
                                                         fileInfo:vo];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_testImgeView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTestImgeView:nil];
    [super viewDidUnload];
}
#pragma mark - 异步请求数据成功

- (void)finishedDownload:(KBBTFileInfoVo *)vo{
    //获取本地已经下载完成图片的路径
    NSString *filePath = [[[KBBreakpointTransmission instance] getTargetFloderPath:vo.filePath] stringByAppendingPathComponent:vo.fileName];
    NSLog(@"加载路径图片目录：%@",filePath);
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    
    if (image == nil) return;
    
    [self.testImgeView setImage:image];
}
@end
