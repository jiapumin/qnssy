//
//  Container.m
//  BSNetWork
//
//  Created by  on 11-11-28.
//  Copyright (c) 2011年 BaoSight. All rights reserved.
//


//#define WEBSERVICE_PREFIX @"http://10.43.8.140:9080/tm/services/BMTMReservationWebService?wsdl"//远程WebService的地址
//#define WEBSERVICE_SUFFIX @"BMTMReservationWebService?wsdl"//参数 webServiceFile

//#define WEBSERVICE_PREFIX @"http://webservice.36wu.com/ExpressService.asmx"

#define WEBSERVICE_URL @"http://www.51hlife.com/HPPWebService/ServiceForBobile.asmx"//远程WebService的地址
//#define WEBSERVICE_SUFFIX @"ServiceForBobile.asmx"//参数 webServiceFile

#import "BSContainer.h"
#import "BSServiceAgent.h"

@implementation BSContainer
@synthesize serviceAgent;
@synthesize serviceHttpURLString;
@synthesize noticeNum;

-(id)init
{
    if(self = [super init]){

        //初始化service
        if (self.serviceAgent==nil) {
            BSServiceAgent * tempServiceAgent = [[BSServiceAgent alloc] init];
            self.serviceAgent = tempServiceAgent;
            [tempServiceAgent release];
        }
//        if (self.userInfo == nil) {
//            UserInfo *tempUserInfo = [[UserInfo alloc]init];
//            self.userInfo = tempUserInfo;
//            [tempUserInfo release];
//        }
        self.serviceHttpURLString = WEBSERVICE_URL;
        
    }
    return self;
}

+ (BSContainer *)instance{
    static BSContainer *instance;
     @synchronized(self) {
         if (!instance) {
             instance = [[BSContainer alloc] init];
         }
     }
    return instance;
}

-(void) dealloc{
    [serviceAgent release];
    [serviceHttpURLString release];
//    [userInfo release];
    [super dealloc];
}

@end
