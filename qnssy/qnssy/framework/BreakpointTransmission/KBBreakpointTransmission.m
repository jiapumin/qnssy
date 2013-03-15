//
//  KBBreakpointTransmission.m
//  BSMobileSale
//
//  Created by jpm on 12-10-23.
//
//
#define DOCUMENTSPATH @"Documents/Caches"
#define TEMPPATH @"Documents/Caches/downloading"

//网络存储池字段
#define NETWORK_SENDER @"sender"
#define NETWORK_SUCCESS @"success"
#define NETWORK_FAIL @"fail"
#define NETWORK_START @"start"
#define NETWORK_PROGRESS @"progress"

#import "KBBreakpointTransmission.h"

@implementation KBBreakpointTransmission{
    
}


- (void)dealloc{
    
    [_downloadinglist release];
    [_downloadFinishList release];
    [_serviceInfo release];
    [super dealloc];
    
}

+ (KBBreakpointTransmission *)instance{
    static KBBreakpointTransmission *instance;
    @synchronized(self) {
        if (!instance) {
            instance = [[KBBreakpointTransmission alloc] init];
        }
    }
    return instance;
}
- (id)init
{
    self = [super init];
    if (self) {
        self.downloadinglist = [[[NSMutableArray alloc] init] autorelease];
        self.downloadFinishList = [[[NSMutableArray alloc] init] autorelease];
        self.serviceInfo = [[[NSMutableDictionary alloc] init] autorelease];
        //加载未完成的文件列表
        [self loadTempFiles];
    }
    return self;
}

- (void)loadDataWithDelegate:(id)delegate
                     success:(SEL)mSuccess
                        fail:(SEL)mFail
                       start:(SEL)mStart
                    progress:(SEL)mProgress
                    fileInfo:(KBBTFileInfoVo *)vo{
    
    if (delegate == nil || vo == nil)  return;
    NSString * guid = [self generateUuidString];
    [_serviceInfo setObject:delegate forKey:guid];
    if (mSuccess!=nil) {
        [_serviceInfo setObject:NSStringFromSelector(mSuccess)
                         forKey:[NSString stringWithFormat:@"%@_%@", guid, NETWORK_SUCCESS]];
    }
    if (mFail!=nil) {
        [_serviceInfo setObject:NSStringFromSelector(mFail)
                         forKey:[NSString stringWithFormat:@"%@_%@", guid, NETWORK_FAIL]];
    }
    if (mStart!=nil) {
        [_serviceInfo setObject:NSStringFromSelector(mStart)
                         forKey:[NSString stringWithFormat:@"%@_%@", guid, NETWORK_START]];
    }
    if (mProgress!=nil) {
        [_serviceInfo setObject:NSStringFromSelector(mProgress)
                         forKey:[NSString stringWithFormat:@"%@_%@", guid, NETWORK_PROGRESS]];
    }
    vo.guid = guid;
    [self beginRequest:vo isBeginDown:YES];
}

- (void)loadTempFiles
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSError *error;
    NSArray *filelist=[fileManager contentsOfDirectoryAtPath:[self getTempFolderPath] error:&error];
    if(!error)
    {
        NSLog(@"%@",[error description]);
    }
    for(NSString *file in filelist)
    {
        if([file rangeOfString:@".rtf"].location <= 100)//以.rtf结尾的文件是下载文件的配置文件，存在文件名称，文件总大小，文件下载URL
        {
            NSInteger index=[file rangeOfString:@"."].location;
            NSString *trueName=[file substringToIndex:index];
            
            //临时文件的配置文件的内容
            NSString *pathStr = [[self getTempFolderPath]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.rtf",trueName]];
            NSString *msg=[[[NSString alloc] initWithData:[NSData dataWithContentsOfFile:pathStr] encoding:NSUTF8StringEncoding] autorelease];
            
            //取得第一个逗号前的文件名
            index=[msg rangeOfString:@","].location;
            NSString *name=[msg substringToIndex:index];
            msg=[msg substringFromIndex:index+1];
            
            //取得第一个逗号和第二个逗间的文件总大小
            index=[msg rangeOfString:@","].location;
            NSString *totalSize=[msg substringToIndex:index];
            msg=[msg substringFromIndex:index+1];
            
            //取得第二个逗号后的所有内容，即文件下载的URL
            NSString *url=msg;
            
            //按照获取的文件名获取临时文件的大小，即已下载的大小
            NSData *fileData=[fileManager contentsAtPath:[[self getTempFolderPath]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.temp",name]]];
            NSInteger receivedDataLength=[fileData length];
            
            //实例化新的文件对象，添加到下载的全局列表，但不开始下载
            KBBTFileInfoVo *tempFile=[[KBBTFileInfoVo alloc] init];
            tempFile.fileName=name;
            tempFile.fileSize=totalSize;
            tempFile.fileReceivedSize=[NSString stringWithFormat:@"%d",receivedDataLength];
            tempFile.fileURL=url;
            tempFile.isDownloading=NO;
            [self beginRequest:tempFile isBeginDown:NO];
            [tempFile release];
            
        }
    }
}

//-(void)loadFinishedFiles
//{
//
//    NSFileManager *fileManager=[NSFileManager defaultManager];
//    NSError *error;
//    NSArray *filelist=[fileManager contentsOfDirectoryAtPath:[self getTargetFloderPath] error:&error];
//    if(!error)
//    {
//        NSLog(@"%@",[error description]);
//    }
//    for(NSString *fileName in filelist)
//    {
//        if([fileName rangeOfString:@"."].location<100)//出去Temp文件夹
//        {
//            KBBTFileInfoVo *finishedFile=[[KBBTFileInfoVo alloc] init];
//            finishedFile.fileName=fileName;
//            
//            //根据文件名获取文件的大小
//            NSInteger length=[[fileManager contentsAtPath:[[self getTargetFloderPath] stringByAppendingPathComponent:fileName]] length];
//            finishedFile.fileSize=[self getFileSizeString:[NSString stringWithFormat:@"%d",length]];
//            
//            [self.downloadFinishList addObject:finishedFile];
//            [finishedFile release];
//        }
//    }
//}
//- (void)startDownload:(KBFileInfoVo *)vo
//{
//    //因为是重新下载，则说明肯定该文件已经被下载完，或者有临时文件正在留着，所以检查一下这两个地方，存在则删除掉
//    NSString *targetPath=[[self getTargetFloderPath]stringByAppendingPathComponent:vo.fileName];
//    NSString *tempPath=[[[self getTempFolderPath]stringByAppendingPathComponent:vo.fileName]stringByAppendingString:@".temp"];
//    if([self isExistFile:targetPath])//已经下载过一次该音乐
//    {
//        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"该文件已经添加到您的下载列表中了！是否重新下载该文件？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alert show];
//        [alert release];
//        return;
//    }
//    //存在于临时文件夹里
//    if([self isExistFile:tempPath])
//    {
//        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"该文件已经添加到您的下载列表中了！是否重新下载该文件？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alert show];
//        [alert release];
//        return;
//    }
//    vo.isDownloading=YES;
//    //若不存在文件和临时文件，则是新的下载
//    [self beginRequest:vo isBeginDown:YES];
//}

- (void)beginRequest:(KBBTFileInfoVo *)vo isBeginDown:(BOOL)isBeginDown
{
    //如果不存在则创建临时存储目录
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSError *error;
    NSString *floderTempPath = [self getTempFolderPath];
    if(![fileManager fileExistsAtPath:floderTempPath])
    {
        [fileManager createDirectoryAtPath:floderTempPath
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:nil];
//        NSURL *url = [NSURL URLWithString:floderTempPath];
//        [AppDelegate addSkipBackupAttributeToItemAtURL:url];
    }
    //如果不存在则创建存储目录
    NSString *floderPath = [self getTargetFloderPath:vo.filePath];
    if(![fileManager fileExistsAtPath:floderPath])
    {
        [fileManager createDirectoryAtPath:floderPath
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:nil];
//        NSURL *url = [NSURL URLWithString:floderTempPath];
//        [AppDelegate addSkipBackupAttributeToItemAtURL:url];
    }
    
    //文件开始下载时，把文件名、文件总大小、文件URL写入文件，XXX.rtf中间用逗号隔开
    NSString *writeMsg=[vo.fileName stringByAppendingFormat:@",%@,%@",vo.fileSize,vo.fileURL];
    NSInteger index=[vo.fileName rangeOfString:@"."].location;
    NSString *name=[vo.fileName substringToIndex:index];
    [writeMsg writeToFile:[[self getTempFolderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.rtf",name]]
               atomically:YES
                 encoding:NSUTF8StringEncoding
                    error:&error];
    

    
    //按照获取的文件名获取临时文件的大小，即已下载的大小
    vo.isFistReceived=YES;
    NSData *fileData=[fileManager contentsAtPath:[floderTempPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.temp",vo.fileName]]];
    NSInteger receivedDataLength=[fileData length];
    vo.fileReceivedSize=[NSString stringWithFormat:@"%d",receivedDataLength];
    
    //如果文件重复下载或暂停、继续，则把队列中的请求删除，重新添加
    for(ASIHTTPRequest *tempRequest in self.downloadinglist)
    {
        if([[NSString stringWithFormat:@"%@",tempRequest.url] isEqual:vo.fileURL])
        {
            [self.downloadinglist removeObject:tempRequest];
            break;
        }
    }
    //创建request
    ASIHTTPRequest *request=[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:vo.fileURL]];
    request.delegate=self;
    [request setTimeOutSeconds:60];
    NSString *downloadPath = [floderPath stringByAppendingPathComponent:vo.fileName];
    [request setDownloadDestinationPath:downloadPath];
    [request setTemporaryFileDownloadPath:[floderTempPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.temp",vo.fileName]]];
    [request setDownloadProgressDelegate:self];
    [request setDidFinishSelector:@selector(downloadSuccess:)];
    [request setDidFailSelector:@selector(downloadFail:)];
    [request setDidStartSelector:@selector(downloadStart:)];
    [request setDidReceiveResponseHeadersSelector:@selector(downloadRequestReceivedResponseHeaders:)];
    //    [request setDownloadProgressDelegate:downCell.progress];//设置进度条的代理,这里由于下载是在AppDelegate里进行的全局下载，所以没有使用自带的进度条委托，这里自己设置了一个委托，用于更新UI
    [request setAllowResumeForFileDownloads:YES];//支持断点续传
    if(isBeginDown)
    {
        vo.isDownloading=YES;
    }
    else
    {
        vo.isDownloading=NO;
    }
    
    NSMutableDictionary *userInfoDic = [[[NSMutableDictionary alloc] init] autorelease];
    [userInfoDic setObject:vo forKey:@"File"];    
    [request setUserInfo:userInfoDic];//设置上下文的文件基本信息
    
    [request setTimeOutSeconds:30.0f];
    if (isBeginDown) {
        [request startAsynchronous];
    }
    [self.downloadinglist addObject:request];
}
- (void)stopDownload:(KBBTFileInfoVo *)vo{
//    [self.request cancel];
//    [self.request release];
//    self.request=nil;
}

#pragma mark - ASIHttpRequest回调委托
//获取下载文件的大小
-(void)downloadRequestReceivedResponseHeaders:(ASIHTTPRequest *)request
{

    KBBTFileInfoVo *vo = [request.userInfo objectForKey:@"File"];
    
    NSString *fileSize;
    
    if ([[request responseHeaders] objectForKey:@"Content-Range"]) {
        
        NSString *rangeStr = [[request responseHeaders] objectForKey:@"Content-Range"];
        
        NSInteger rangePartitionIndex = [rangeStr rangeOfString:@"/"].location;
        
        fileSize = [rangeStr substringFromIndex:rangePartitionIndex + 1];
        
    }else{
        
        fileSize = [[request responseHeaders] objectForKey:@"Content-Length"];
        
    }
    
    vo.fileSize = fileSize;
    NSLog(@"要下载的文件大小为：%@kb;",fileSize);
}

//1.实现ASIProgressDelegate委托，在此实现UI的进度条更新,这个方法必须要在设置[request setDownloadProgressDelegate:self];之后才会运行
//2.这里注意第一次返回的bytes是已经下载的长度，以后便是每次请求数据的大小
//费了好大劲才发现的，各位新手请注意此处
- (void)request:(ASIHTTPRequest *)request didReceiveBytes:(long long)bytes
{
    KBBTFileInfoVo *vo = [request.userInfo objectForKey:@"File"];
    
    id delegate = nil;
    if ([_serviceInfo objectForKey:vo.guid]) {
        delegate = [_serviceInfo objectForKey:vo.guid];
    }
    SEL progressFunction = nil;
    NSString *guid_progress = [NSString stringWithFormat:@"%@_%@",vo.guid, NETWORK_PROGRESS];
    if ([_serviceInfo objectForKey:guid_progress]!=nil) {
        progressFunction = NSSelectorFromString((NSString *)[_serviceInfo objectForKey:guid_progress]);
    }
    
    if(!vo.isFistReceived)
    {
        vo.fileReceivedSize = [NSString stringWithFormat:@"%lld",[vo.fileReceivedSize longLongValue]+bytes];
        NSLog(@"已经下载文件的大小%@kb",vo.fileReceivedSize);
    }
    
    if (delegate && [delegate respondsToSelector:progressFunction]) {
        
        NSMethodSignature *signature = [delegate methodSignatureForSelector:progressFunction];
        NSUInteger argumentsCount = [signature numberOfArguments] - 2;//每个method带有两个隐含参数self与_cmd(选择器)
        if (argumentsCount > 1) {
            [delegate performSelector:progressFunction withObject:request withObject:vo];
        }else if (argumentsCount == 1){
            [delegate performSelector:progressFunction withObject:vo];
        }else{
            [delegate performSelector:progressFunction];
        }   
    }
    vo.isFistReceived = NO;
}

- (void)downloadStart:(ASIHTTPRequest *)request
{
    KBBTFileInfoVo *vo =[request.userInfo objectForKey:@"File"];
    
    id delegate = nil;
    if ([_serviceInfo objectForKey:vo.guid]) {
        delegate = [_serviceInfo objectForKey:vo.guid];
    }
    SEL startFunction =nil;
    NSString *guid_start = [NSString stringWithFormat:@"%@_%@",vo.guid, NETWORK_START];
    if ([_serviceInfo objectForKey:guid_start]!=nil) {
        startFunction = NSSelectorFromString((NSString *)[_serviceInfo objectForKey:guid_start]);
    }
    if (delegate && [delegate respondsToSelector:startFunction]) {
        NSMethodSignature *signature = [delegate methodSignatureForSelector:startFunction];
        NSUInteger argumentsCount = [signature numberOfArguments] - 2;//每个method带有两个隐含参数self与_cmd(选择器)
        if (argumentsCount == 1){
            [delegate performSelector:startFunction withObject:request];
        }else{
            [delegate performSelector:startFunction];
        }
    }
}

- (void)downloadFail:(ASIHTTPRequest *)request
{
    KBBTFileInfoVo *vo =[request.userInfo objectForKey:@"File"];
    
    id delegate = nil;
    if ([_serviceInfo objectForKey:vo.guid]) {
        delegate = [_serviceInfo objectForKey:vo.guid];
    }
    
    SEL successFunction =nil;
    NSString *guid_success = [NSString stringWithFormat:@"%@_%@",vo.guid, NETWORK_SUCCESS];
    if ([_serviceInfo objectForKey:guid_success]!=nil) {
        successFunction = NSSelectorFromString((NSString *)[_serviceInfo objectForKey:guid_success]);
    }
    SEL failFunction = nil;
    NSString *guid_fail = [NSString stringWithFormat:@"%@_%@",vo.guid, NETWORK_FAIL];
    if ([_serviceInfo objectForKey:guid_fail]!=nil) {
        failFunction = NSSelectorFromString((NSString *)[_serviceInfo objectForKey:guid_fail]);
    }
    SEL startFunction =nil;
    NSString *guid_start = [NSString stringWithFormat:@"%@_%@",vo.guid, NETWORK_START];
    if ([_serviceInfo objectForKey:guid_start]!=nil) {
        startFunction = NSSelectorFromString((NSString *)[_serviceInfo objectForKey:guid_start]);
    }
    SEL progressFunction = nil;
    NSString *guid_progress = [NSString stringWithFormat:@"%@_%@",vo.guid, NETWORK_PROGRESS];
    if ([_serviceInfo objectForKey:guid_progress]!=nil) {
        progressFunction = NSSelectorFromString((NSString *)[_serviceInfo objectForKey:guid_progress]);
    }
    
    if (delegate && [delegate respondsToSelector:failFunction]) {
        
        NSMethodSignature *signature = [delegate methodSignatureForSelector:successFunction];
        NSUInteger argumentsCount = [signature numberOfArguments] - 2;//每个method带有两个隐含参数self与_cmd(选择器)
        if (argumentsCount == 1){
            [delegate performSelector:failFunction withObject:request];
        }else{
            [delegate performSelector:failFunction];
        }
        
        
    }
    [self.downloadinglist removeObject:request];
    
    [request release];
    
    //从池中移除
    if (delegate != nil) [_serviceInfo removeObjectForKey:vo.guid];
    if (successFunction != nil) [_serviceInfo removeObjectForKey:guid_success];
    if (failFunction != nil) [_serviceInfo removeObjectForKey:guid_fail];
    if (startFunction != nil) [_serviceInfo removeObjectForKey:guid_start];
    if (progressFunction != nil) [_serviceInfo removeObjectForKey:guid_progress];
    
    NSLog(@"请求失败网络存储池中的数据：%@",_serviceInfo);

    
    NSError *error=[request error];
    NSLog(@"ASIHttpRequest出错了!%@",error);

}

//将正在下载的文件请求ASIHttpRequest从队列里移除，并将其配置文件删除掉,然后向已下载列表里添加该文件对象
- (void)downloadSuccess:(ASIHTTPRequest *)request
{

    KBBTFileInfoVo *vo =[request.userInfo objectForKey:@"File"];
    
    NSInteger index=[vo.fileName rangeOfString:@"."].location;
    NSString *name=[vo.fileName substringToIndex:index];
    NSString *configPath=[[self getTempFolderPath] stringByAppendingPathComponent:[name stringByAppendingString:@".rtf"]];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSError *error;
    if([fileManager fileExistsAtPath:configPath])//如果存在临时文件的配置文件
    {
        [fileManager removeItemAtPath:configPath error:&error];
        
        if(!error)
        {
            NSLog(@"%@",[error description]);
        }
    }
    
    id delegate = nil;
    if ([_serviceInfo objectForKey:vo.guid]) {
        delegate = [_serviceInfo objectForKey:vo.guid];
    }
    
    SEL successFunction =nil;
    NSString *guid_success = [NSString stringWithFormat:@"%@_%@",vo.guid, NETWORK_SUCCESS];
    if ([_serviceInfo objectForKey:guid_success]!=nil) {
        successFunction = NSSelectorFromString((NSString *)[_serviceInfo objectForKey:guid_success]);
    }
    SEL failFunction = nil;
    NSString *guid_fail = [NSString stringWithFormat:@"%@_%@",vo.guid, NETWORK_FAIL];
    if ([_serviceInfo objectForKey:guid_fail]!=nil) {
        failFunction = NSSelectorFromString((NSString *)[_serviceInfo objectForKey:guid_fail]);
    }
    SEL startFunction =nil;
    NSString *guid_start = [NSString stringWithFormat:@"%@_%@",vo.guid, NETWORK_START];
    if ([_serviceInfo objectForKey:guid_start]!=nil) {
        startFunction = NSSelectorFromString((NSString *)[_serviceInfo objectForKey:guid_start]);
    }
    SEL progressFunction = nil;
    NSString *guid_progress = [NSString stringWithFormat:@"%@_%@",vo.guid, NETWORK_PROGRESS];
    if ([_serviceInfo objectForKey:guid_progress]!=nil) {
        progressFunction = NSSelectorFromString((NSString *)[_serviceInfo objectForKey:guid_progress]);
    }
    
    if (delegate && [delegate respondsToSelector:successFunction]) {
        
        NSMethodSignature *signature = [delegate methodSignatureForSelector:successFunction];
        NSUInteger argumentsCount = [signature numberOfArguments] - 2;//每个method带有两个隐含参数self与_cmd(选择器)
        if (argumentsCount > 1) {

            [delegate performSelector:successFunction withObject:request withObject:vo];
        }else if (argumentsCount == 1){
            [delegate performSelector:successFunction withObject:vo];
        }else{
            [delegate performSelector:successFunction];
        }

       
    }
    [self.downloadFinishList addObject:vo];
    [self.downloadinglist removeObject:request];

    [request release];
    
    //从池中移除
    if (delegate != nil) [_serviceInfo removeObjectForKey:vo.guid];
    if (successFunction != nil) [_serviceInfo removeObjectForKey:guid_success];
    if (failFunction != nil) [_serviceInfo removeObjectForKey:guid_fail];
    if (startFunction != nil) [_serviceInfo removeObjectForKey:guid_start];
    if (progressFunction != nil) [_serviceInfo removeObjectForKey:guid_progress];
    
    NSLog(@"请求成功网络存储池中的数据：%@",_serviceInfo);
}

#pragma mark - 数据转换方法

//+(NSString *)transformToM:(NSString *)size
//{
//    float oldSize=[size floatValue];
//    float newSize=oldSize/1024.0f;
//    newSize=newSize/1024.0f;
//    return [NSString stringWithFormat:@"%f",newSize];
//}
//
//+(float)transformToBytes:(NSString *)size
//{
//    float totalSize=[size floatValue];
////    NSLog(@"文件总大小跟踪：%f",totalSize);
//    return totalSize*1024*1024;
//}

- (NSString *)getFileSizeString:(NSString *)size
{
    if([size floatValue]>=1024*1024)//大于1M，则转化成M单位的字符串
    {
        return [NSString stringWithFormat:@"%fM",[size floatValue]/1024/1024];
    }
    else if([size floatValue]>=1024&&[size floatValue]<1024*1024) //不到1M,但是超过了1KB，则转化成KB单位
    {
        return [NSString stringWithFormat:@"%fK",[size floatValue]/1024];
    }
    else//剩下的都是小于1K的，则转化成B单位
    {
        return [NSString stringWithFormat:@"%fB",[size floatValue]];
    }
}

- (float)getFileSizeNumber:(NSString *)size
{
    NSInteger indexM=[size rangeOfString:@"M"].location;
    NSInteger indexK=[size rangeOfString:@"K"].location;
    NSInteger indexB=[size rangeOfString:@"B"].location;
    if(indexM<1000)//是M单位的字符串
    {
        return [[size substringToIndex:indexM] floatValue]*1024*1024;
    }
    else if(indexK<1000)//是K单位的字符串
    {
        return [[size substringToIndex:indexK] floatValue]*1024;
    }
    else if(indexB<1000)//是B单位的字符串
    {
        return [[size substringToIndex:indexB] floatValue];
    }
    else//没有任何单位的数字字符串
    {
        return [size floatValue];
    }
}

- (NSString *)getDocumentPath
{
    return [NSHomeDirectory() stringByAppendingPathComponent:DOCUMENTSPATH];
}

- (NSString *)getTargetFloderPath:(NSString *)filePath
{
    NSString *targetFloderPath = [NSString stringWithFormat:@"%@/%@",DOCUMENTSPATH,filePath];
    return [NSHomeDirectory() stringByAppendingPathComponent:targetFloderPath];
}

- (NSString *)getTempFolderPath
{
    return [NSHomeDirectory()stringByAppendingPathComponent:TEMPPATH];
}

- (BOOL)isExistFile:(NSString *)fileName
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:fileName];
}

- (float)getProgress:(float)totalSize currentSize:(float)currentSize
{
    return currentSize/totalSize;
}


#pragma mark - getUUID
- (NSString *)generateUuidString
{
    // create a new UUID which you own
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    
    // create a new CFStringRef (toll-free bridged to NSString)
    // that you own
    NSString *uuidString = (NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuid);
    
    // transfer ownership of the string
    // to the autorelease pool
    [uuidString autorelease];
    
    // release the UUID
    CFRelease(uuid);
    
    return uuidString;
}
@end
