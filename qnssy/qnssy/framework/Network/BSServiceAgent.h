//
//  EiServiceAgent.h
//  BSNetWork
//
//  Created by jpm on 11-10-24.
//  Copyright 2011年 BaoSight. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BSHttpAgent;
@interface BSServiceAgent : NSObject{
    
}
@property (nonatomic,retain) BSHttpAgent *httpAgent;
@property (nonatomic,retain) NSMutableDictionary *serviceInfo;


- (void)callWebServiceWithObject:(id)sender
                     requestDict:(NSMutableDictionary *)requestDic 
                          target:(id)delegate
                 successCallBack:(SEL)sucAction 
                    failCallBack:(SEL)failAction;

@end

@interface BSServiceAgent(private)

- (NSString *)generateUuidString;

- (void)releaseDelegate:(id)deallocedDelegate ;

@end
