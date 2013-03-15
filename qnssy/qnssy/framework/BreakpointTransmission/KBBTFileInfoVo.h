//
//  KBFileInfoVo.h
//  BSMobileSale
//
//  Created by jpm on 12-10-24.
//
//

#import <Foundation/Foundation.h>

@interface KBBTFileInfoVo : NSObject


@property(nonatomic,retain)NSString *fileID; //数据的唯一标示
@property(nonatomic,retain)NSString *fileName;//带后缀的文件名字
@property(nonatomic,retain)NSString *fileSize;//文件的大小
@property(nonatomic)BOOL isFistReceived;//是否是第一次接受数据，如果是则不累加第一次返回的数据长度，之后变累加
@property(nonatomic,retain)NSString *fileReceivedSize; //已经下载的文件大小
@property(nonatomic,retain)NSMutableData *fileReceivedData;//接受的数据
@property(nonatomic,retain)NSString *fileURL;//文件下载的url路径
@property(nonatomic)BOOL isDownloading;//是否正在下载
@property(nonatomic)BOOL isP2P;//是否是p2p下载
@property(nonatomic,retain)id sender;//用于传送一个需要的接收时使用的对象
@property(nonatomic,retain)NSString *filePath;//文件在本地的存储路径
@property(nonatomic,retain)NSString *guid;//区分多个网络请求的标示符

@end
