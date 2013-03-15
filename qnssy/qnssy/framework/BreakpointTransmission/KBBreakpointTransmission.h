//
//  KBBreakpointTransmission.h
//  BSMobileSale
//
//  Created by jpm on 12-10-23.
//
//

#import <Foundation/Foundation.h>
#import "KBBTFileInfoVo.h"

@interface KBBreakpointTransmission : NSObject<ASIProgressDelegate,ASIHTTPRequestDelegate>

@property (nonatomic,retain) NSMutableDictionary *serviceInfo;

@property (nonatomic, retain) NSMutableArray *downloadinglist;//正在下载的文件列表(ASIHttpRequest对象)
@property (nonatomic, retain) NSMutableArray *downloadFinishList;//已下载完成的文件列表（文件对象）

+ (KBBreakpointTransmission *)instance;
//- (void)startDownload:(KBFileInfoVo *)vo;
- (void)loadDataWithDelegate:(id)delegate
                     success:(SEL)mSuccess
                        fail:(SEL)mFail
                       start:(SEL)mStart
                    progress:(SEL)mProgress
                    fileInfo:(KBBTFileInfoVo *)vo;
////加载正在下载的文件
//- (void)loadTempFiles;
////加载已经下载的文件
//- (void)loadFinishedFiles;
- (void)beginRequest:(KBBTFileInfoVo *)vo isBeginDown:(BOOL)isBeginDown;
- (void)stopDownload:(KBBTFileInfoVo *)vo;



////将字节转化成M单位，不附带M
//+(NSString *)transformToM:(NSString *)size;
////将不M的字符串转化成字节
//+(float)transformToBytes:(NSString *)size;
//将文件大小转化成M单位或者B单位
- (NSString *)getFileSizeString:(NSString *)size;
//经文件大小转化成不带单位ied数字
- (float)getFileSizeNumber:(NSString *)size;

- (NSString *)getDocumentPath;
- (NSString *)getTargetFloderPath:(NSString *)filePath;//得到实际文件存储文件夹的路径
- (NSString *)getTempFolderPath;//得到临时文件存储文件夹的路径
- (BOOL)isExistFile:(NSString *)fileName;//检查文件名是否存在

//传入文件总大小和当前大小，得到文件的下载进度
- (CGFloat)getProgress:(float)totalSize currentSize:(float)currentSize;

@end
