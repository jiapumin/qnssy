//
//  SDWebImageRootViewController.m
//  Sample
//
//  Created by Kirby Turner on 3/18/10.
//  Copyright 2010 White Peak Software Inc. All rights reserved.
//

#import "SDWebImageRootViewController.h"
#import "SDWebImageDataSource.h"


#import "MyPhotoRequestVo.h"
#import "MyPhotoResponseVo.h"

#import "UpdateMyPhotoRequestVo.h"
#import "UpdateMyPhotoResponseVo.h"

@interface SDWebImageRootViewController (){
    UIButton *topRightDelButton;
}
- (void)showActivityIndicator;
- (void)hideActivityIndicator;
@end

@implementation SDWebImageRootViewController

- (void)dealloc 
{
   [activityIndicatorView_ release], activityIndicatorView_ = nil;
   [images_ release], images_ = nil;
   [super dealloc];
}

- (void)viewDidLoad 
{
   [super viewDidLoad];
  
   self.title = @"我的照片";
   
   images_ = [[SDWebImageDataSource alloc] init];
   [self setDataSource:images_];
    
    [self initNavRightBar];
    
    
    //返回按钮
    UIButton *topLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //按钮大小
    CGRect btnFrame = CGRectMake(0.0, 4.0, 29.0, 25.0);
    topLeftButton.frame =btnFrame;
    //设置返回按钮图片和方法
    [topLeftButton setImage:[UIImage imageNamed:@"2向左返回箭头"]
                   forState:UIControlStateNormal];
    [topLeftButton addTarget:self
                      action:@selector(popViewContoller)
            forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * topLeftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:topLeftButton];
    [self.navigationItem setLeftBarButtonItem:topLeftBarButtonItem];
    [topLeftBarButtonItem release];
    
    //设置背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"2顶部条状背景"] forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor = publicColor;
    
    

    [self loadServiceData];
    
}

- (void)initNavRightBar{
    NSMutableArray *itemArray = [[NSMutableArray alloc] init];
    UIButton *topRightButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    //按钮大小
    CGRect btnFrame1 = CGRectMake(0.0, 0.0, 43.0, 29.0);
    topRightButton1.frame =btnFrame1;
    [topRightButton1 setImage:[UIImage imageNamed:@"添加照片"]
                   forState:UIControlStateNormal];
    [topRightButton1 addTarget:self
                      action:@selector(addPhoto)
            forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * topRightBarButtonItem1 = [[UIBarButtonItem alloc] initWithCustomView:topRightButton1];
    [itemArray addObject:topRightBarButtonItem1];
    [topRightBarButtonItem1 release];
    
    topRightDelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //按钮大小
    CGRect btnFrame2 = CGRectMake(0.0, 0.0, 43.0, 29.0);
    topRightDelButton.frame =btnFrame2;
    [topRightDelButton setImage:[UIImage imageNamed:@"删除照片"]
                     forState:UIControlStateNormal];
    [topRightDelButton addTarget:self
                        action:@selector(delPhoto)
              forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * topRightBarButtonItem2 = [[UIBarButtonItem alloc] initWithCustomView:topRightDelButton];
    [itemArray addObject:topRightBarButtonItem2];
    [topRightBarButtonItem2 release];
    

    [self.navigationItem setRightBarButtonItems:itemArray animated:YES];
    [itemArray release];
   
}

- (void)loadServiceData{
    [self.progressHUD show:YES];
    MyPhotoRequestVo *vo = [[MyPhotoRequestVo alloc] initWithPageNum:@"1" pageCount:@"40"];
    [[BSContainer instance].serviceAgent callServletWithObject:self
                                                   requestDict:vo.mReqDic
                                                        target:self
                                               successCallBack:@selector(requestSucceess:data:)
                                                  failCallBack:@selector(requestFailed:data:)];
    
    [vo release];
}
- (void)addPhoto{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择照片来源"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:@"相册"
                                                    otherButtonTitles:@"拍照", nil];
    [actionSheet showInView:self.view];
    [actionSheet release];
    
}
- (void)delPhoto{
    if (self.isEdit) {
        [topRightDelButton setImage:[UIImage imageNamed:@"删除照片"]
                           forState:UIControlStateNormal];
        
    }else{
        [topRightDelButton setImage:[UIImage imageNamed:@"删除照片"]
                           forState:UIControlStateNormal];
        
    }

    self.isEdit = !self.isEdit;

    self.scrollView.thumbsHaveBorder = !self.isEdit;
    
    [self reloadThumbs];
        
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning 
{
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload 
{
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)willLoadThumbs 
{
   [self showActivityIndicator];
}

- (void)didLoadThumbs 
{
   [self hideActivityIndicator];
}


#pragma mark -
#pragma mark Activity Indicator

- (UIActivityIndicatorView *)activityIndicator 
{
   if (activityIndicatorView_) {
      return activityIndicatorView_;
   }

   activityIndicatorView_ = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
   CGPoint center = [[self view] center];
   [activityIndicatorView_ setCenter:center];
   [activityIndicatorView_ setHidesWhenStopped:YES];
   [activityIndicatorView_ startAnimating];
   [[self view] addSubview:activityIndicatorView_];
   
   return activityIndicatorView_;
}

- (void)showActivityIndicator 
{
   [[self activityIndicator] startAnimating];
}

- (void)hideActivityIndicator 
{
   [[self activityIndicator] stopAnimating];
}
#pragma mark - 回调方法

- (void)requestSucceess:(id)sender data:(NSDictionary *)dic {
    
    MyPhotoResponseVo *vo = [[MyPhotoResponseVo alloc] initWithDic:dic];
    
    images_.images_ = vo.imageList;
    
    [self setDataSource:images_];
    
    if (vo.status != 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:vo.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }

    [self.progressHUD hide:YES];
    
    [vo release];
}


- (void)requestFailed:(id)sender data:(NSDictionary *)dic {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"网络异常，请检查网络连接后重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    [self.progressHUD hide:YES];
}
#pragma mark - pop
- (void)popViewContoller{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {//相册
        [self selectPhotoFromLiabary];
    }else if(buttonIndex == 1){//相机
        [self pickerPhoto];
    }
}
#pragma mark - 相机
- (IBAction)selectPhotoFromLiabary{
    //从相册中选取
	UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
		imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
		imagePicker.allowsEditing = YES;
        imagePicker.delegate = self;
        [self presentModalViewController:imagePicker animated:YES];

	}else {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"打开相册异常,请重试"
                                                            message:@""
                                                           delegate:nil
                                                  cancelButtonTitle:@"确认"
                                                  otherButtonTitles:nil];
		[alertView show];
		[alertView release];
	}
	[imagePicker release];
}

- (IBAction)pickerPhoto{
    
    //拍照
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
	if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
		imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
		imagePicker.allowsEditing = YES;
		imagePicker.delegate = self;
		[self presentModalViewController:imagePicker animated:YES];
		
	}else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"相机不可用" message:@""
                                                       delegate:nil
                                              cancelButtonTitle:@"关闭"
                                              otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
    [imagePicker release];
}
#pragma mark -
#pragma mark UIImagePickerControllerDelegate method

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
	[picker dismissModalViewControllerAnimated:YES];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *original_image;
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        //如果是 来自照相机的image，那么先保存
        original_image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        UIImageWriteToSavedPhotosAlbum(original_image,
                                       self,
                                       @selector(image:didFinishSavingWithError:contextInfo:),
                                       nil);
        
    }else if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        //来自相册图片 当需要提交服务器原图时取消此注释
        //        original_image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    }
    //获得编辑过的图片
    UIImage* image = [info objectForKey: @"UIImagePickerControllerEditedImage"];

    //保存编辑过的图片
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath  = [[KBBreakpointTransmission instance] getTargetFloderPath:IMAGE_PATH];
    NSData *data;
    if (UIImagePNGRepresentation(image) == nil) {
        data = UIImageJPEGRepresentation(image, 1);
    } else {
        data = UIImagePNGRepresentation(image);
    }
    [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    [fileManager createFileAtPath:[filePath stringByAppendingString:@"/image1.png"] contents:data attributes:nil];
    
    //请求服务器上传图片
    [self updateMyPhotoImage:[NSString stringWithFormat:@"%@/%@",filePath,@"image1.png"]];
    
    [picker dismissModalViewControllerAnimated:YES];
    
    
}
- (void)image:(UIImageView*)image didFinishSavingWithError:(NSString*)error contextInfo:(NSString*)context{
    NSLog(@"保存完成！");
}
- (void)updateMyPhotoImage:(NSString *)filePath{

    [self.progressHUD show:YES];
    UpdateMyPhotoRequestVo *vo = [[UpdateMyPhotoRequestVo alloc] initWithPhotoFilePath:filePath delegate:self];
    [vo release];
}
- (void)asySuccess:(ASIFormDataRequest *)request{
    [self.progressHUD hide:YES];
    NSString *dataStr = request.responseString;
    NSDictionary *dataDic = [dataStr JSONValue];
    
    //成功将数据返回
     NSMutableDictionary *resultDict = [[[NSMutableDictionary alloc] init] autorelease];
    [resultDict setObject:[NSNumber numberWithInt:IPLAT4M_STATUS_SUCCESS] forKey:@"status"];
    [resultDict setObject:dataDic forKey:@"data"];
    
    UpdateMyPhotoResponseVo *vo = [[UpdateMyPhotoResponseVo alloc] initWithDic:resultDict];
    
    [images_.images_ addObject:vo.dataDic];
    [vo release];
    [self setDataSource:images_];
    NSLog(@"responseString = %@", request.responseString);
    
}
- (void)asyFail:(ASIFormDataRequest *)request{
    [self.progressHUD hide:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"网络异常，请检查网络连接后重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}
@end
