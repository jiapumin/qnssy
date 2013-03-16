//
//  EiHttpAgent.h
//  BSNetWork
//
//  Created by jpm on 11-10-24.
//  Copyright 2011年 BaoSight. All rights reserved.
//

#define IPLAT4M_STATUS_FAILED  -1

#define  IPLAT4M_STATUS_SUCCESS  0

#define  IPLAT4M_STATUS_INVALID_USER  -2

#define  IPLAT4M_STATUS_TIMEOUT  -3

#define  IPLAT4M_STATUS_CANCELLED  -4

#define  IPLAT4M_STATUS_INVALID_PASSWORD  -5

#define  IPLAT4M_STATUS_UNAUTHENTIFICATION  -6

#define  IPLAT4M_STATUS_NETWORK_ERROR  -7

#define IPLAT4M_STATUS_DEVICE_LOCKED  -8


#import <Foundation/Foundation.h>

#import "ASIFormDataRequest.h"

@interface BSHttpAgent : NSObject
{
}
@property (nonatomic,assign) SEL WebHttpAgentSuccussAction;
@property (nonatomic,assign) SEL WebHttpAgentFailAction;
@property (nonatomic,retain) id bsASIHttpDelegate;


- (void)startWebAsyRequest:(id)request  
           succussFunction:(SEL)suAction 
              failFunction:(SEL)faAction;
- (void)startServletAsyRequest:(id)requestDict
               succussFunction:(SEL)suAction
                  failFunction:(SEL)faAction;


@end
