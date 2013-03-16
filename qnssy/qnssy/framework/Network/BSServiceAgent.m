//
//  EiServiceAgent.m
//  BSNetWork
//
//  Created by jpm on 11-10-24.
//  Copyright 2011年 BaoSight. All rights reserved.
//

//网络存储池字段
#define NETWORK_SENDER @"sender"
#define NETWORK_SUCCESS @"success"
#define NETWORK_FAIL @"fail"

#import "BSServiceAgent.h"
#import "BSHttpAgent.h"

@implementation BSServiceAgent
@synthesize httpAgent=_httpAgent;
@synthesize serviceInfo = _serviceInfo;
- (id)init
{
    if (self = [super init]) {
        if (self.httpAgent == nil) {
            BSHttpAgent *tempHttpAgent = [[BSHttpAgent alloc] init];
            self.httpAgent = tempHttpAgent;
            [tempHttpAgent release];
        }
        if (self.serviceInfo == nil) {
            NSMutableDictionary *tempServiceInfo = [[NSMutableDictionary alloc] init];
            self.serviceInfo = tempServiceInfo;
            [tempServiceInfo release];
        }
    }
    return self;
}
#pragma mark -  Servlet

- (void)callServletWithObject:(id)sender
                  requestDict:(NSMutableDictionary *)requestDic
                       target:(id)delegate
              successCallBack:(SEL)sucAction
                 failCallBack:(SEL)failAction{
    if (delegate==nil||sender==nil) {
        return;
    }
    if (requestDic == nil) {
        requestDic = [[[NSMutableDictionary alloc] init] autorelease];
    }
    _httpAgent.bsASIHttpDelegate = self;
    NSString * guid = [self generateUuidString];
    [_serviceInfo setObject:delegate forKey:guid];
    if (sender!=nil) {
        [_serviceInfo setObject:sender
                         forKey:[NSString stringWithFormat:@"%@_%@", guid, NETWORK_SENDER]];
    }
    if (sucAction!=nil) {
        [_serviceInfo setObject:NSStringFromSelector(sucAction)
                         forKey:[NSString stringWithFormat:@"%@_%@", guid, NETWORK_SUCCESS]];
    }
    if (failAction!=nil) {
        [_serviceInfo setObject:NSStringFromSelector(failAction)
                         forKey:[NSString stringWithFormat:@"%@_%@", guid, NETWORK_FAIL]];
    }
    [requestDic setObject:guid forKey:@"guid"];
    
    [_httpAgent startServletAsyRequest:requestDic
                       succussFunction:@selector(callWebServiceWithObjectSuccessed:)
                          failFunction:@selector(callWebServiceWithObjectFailed:)];
}

#pragma mark -  WebService

- (void)callWebServiceWithObject:(id)sender
                     requestDict:(NSMutableDictionary *)requestDic 
                          target:(id)delegate
                 successCallBack:(SEL)sucAction 
                    failCallBack:(SEL)failAction{
    if (delegate==nil||sender==nil) {
        return;
    }
    if (requestDic == nil) {
        requestDic = [[[NSMutableDictionary alloc] init] autorelease];
    }
    _httpAgent.bsASIHttpDelegate = self;
    NSString * guid = [self generateUuidString];
    [_serviceInfo setObject:delegate forKey:guid];
    if (sender!=nil) {
        [_serviceInfo setObject:sender
                         forKey:[NSString stringWithFormat:@"%@_%@", guid, NETWORK_SENDER]];
    }
    if (sucAction!=nil) {
        [_serviceInfo setObject:NSStringFromSelector(sucAction)
                         forKey:[NSString stringWithFormat:@"%@_%@", guid, NETWORK_SUCCESS]];
    }
    if (failAction!=nil) {
        [_serviceInfo setObject:NSStringFromSelector(failAction)
                         forKey:[NSString stringWithFormat:@"%@_%@", guid, NETWORK_FAIL]];
    }
    [requestDic setObject:guid forKey:@"guid"];
    
    [_httpAgent startWebAsyRequest:requestDic 
                   succussFunction:@selector(callWebServiceWithObjectSuccessed:) 
                      failFunction:@selector(callWebServiceWithObjectFailed:)];
}

- (void)callWebServiceWithObjectSuccessed:(NSMutableDictionary *)resultDict
{
    NSString * guid = [resultDict objectForKey:@"guid"];
    
    id delegate = nil;
    if ([_serviceInfo objectForKey:guid]) {
        delegate = [_serviceInfo objectForKey:guid];
    }
    
    id sender = nil;
    NSString *guid_sender = [NSString stringWithFormat:@"%@_%@",guid, NETWORK_SENDER];
    if ([_serviceInfo objectForKey:guid_sender]) {
        sender = [_serviceInfo objectForKey:guid_sender];
    }
    
    SEL successFunction =nil;
    NSString *guid_success = [NSString stringWithFormat:@"%@_%@",guid, NETWORK_SUCCESS];
    if ([_serviceInfo objectForKey:guid_success]!=nil) {
        successFunction = NSSelectorFromString((NSString *)[_serviceInfo objectForKey:guid_success]);
    }
    SEL failFunction = nil;
    NSString *guid_fail = [NSString stringWithFormat:@"%@_%@",guid, NETWORK_FAIL];
    if ([_serviceInfo objectForKey:guid_fail]!=nil) {
        failFunction = NSSelectorFromString((NSString *)[_serviceInfo objectForKey:guid_fail]);  
    }
    
    @try {
        if ([[resultDict objectForKey:@"status"] intValue] != IPLAT4M_STATUS_SUCCESS) {
            [self exeDelegateMethodWithObject:sender target:delegate function:failFunction result:resultDict];
        }
        else {
            [self exeDelegateMethodWithObject:sender target:delegate function:successFunction result:resultDict];
        }
	}
	@catch (NSException * e) {
		NSLog(@"BSServiceAgent NSException:%@",[e description]);
        [resultDict setObject:[NSNumber numberWithInt:IPLAT4M_STATUS_FAILED] forKey:@"status"];
        [resultDict setObject:@"业务逻辑代码错误，请检查您的业务代码！" forKey:@"msg"];
        [self exeDelegateMethod:delegate function:failFunction result:resultDict];
	}
    //从池中移除
    if (sender != nil) [_serviceInfo removeObjectForKey:guid_sender];
    if (successFunction != nil) [_serviceInfo removeObjectForKey:guid_success];
    if (failFunction != nil) [_serviceInfo removeObjectForKey:guid_fail];
    if (delegate != nil) [_serviceInfo removeObjectForKey:guid];

    NSLog(@"网络存储池中的数据：%@",_serviceInfo);
}
- (void)callWebServiceWithObjectFailed:(NSDictionary *)resultDict
{
    //指定调用哪一个Controller得回调
    NSString * guid = (NSString *)[resultDict objectForKey:@"guid"];
    id delegate = [_serviceInfo objectForKey:guid];
    id sender = nil;
    NSString *guid_sender = [NSString stringWithFormat:@"%@_%@",guid, NETWORK_SENDER];
    if ([_serviceInfo objectForKey:guid_sender]!=nil) {
        sender = [_serviceInfo objectForKey:guid_sender];
    }
    SEL failFunction = nil;
    NSString *guid_fail = [NSString stringWithFormat:@"%@_%@",guid, NETWORK_FAIL];
    if ([_serviceInfo objectForKey:guid_fail]!=nil) {
        failFunction = NSSelectorFromString((NSString *)[_serviceInfo objectForKey:guid_fail]);
    }
    [self exeDelegateMethodWithObject:sender target:delegate function:failFunction result:resultDict];
    
    //从池中移除
    if (sender != nil) [_serviceInfo removeObjectForKey:guid_sender];
    if (failFunction != nil) [_serviceInfo removeObjectForKey:guid_fail];
    if (delegate != nil) [_serviceInfo removeObjectForKey:guid];
    
}

- (void)exeDelegateMethod:(id)delegate 
                 function:(SEL)action 
                   result:(id)result
{
    if (delegate&&[delegate respondsToSelector:action] ) {
        [delegate performSelector:action  withObject:result];
    }
}

- (void)exeDelegateMethodWithObject:(id)sender 
                             target:(id)delegate 
                           function:(SEL)action 
                             result:(id)result
{
    if (delegate&&[delegate respondsToSelector:action] ) {
        NSMethodSignature * signature = [delegate methodSignatureForSelector:action];
        NSUInteger argumentsCount = [signature numberOfArguments] - 2;//每个method带有两个隐含参数self与_cmd(选择器)
        
        if (argumentsCount>1) {
            [delegate performSelector:action withObject:sender withObject:result];
        } else {
            [delegate performSelector:action withObject:result];
        }
    }
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
#pragma mark - dealloc


- (void)releaseDelegate:(id)deallocedDelegate {
    NSLog(@"%@",_serviceInfo);

    for (NSString* key in _serviceInfo) {
        if ([_serviceInfo objectForKey:key] == deallocedDelegate) {
            [_serviceInfo setObject:nil forKey:key];
        }
    }
//    NSLog(@"%@",_serviceInfo);

}


- (void)dealloc
{
    [_httpAgent release];
    [_serviceInfo release];
	[super dealloc];
}
@end
