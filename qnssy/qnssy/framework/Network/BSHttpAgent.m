//
//  EiHttpAgent.m
//  BSNetWork
//
//  Created by jpm on 11-10-24.
//  Copyright 2011年 BaoSight. All rights reserved.
//

#import "BSHttpAgent.h"
#import "ASIFormDataRequest.h"
#import "BSContainer.h"
#import "SBJson.h"
#import "GDataXMLNode.h"
@implementation BSHttpAgent

@synthesize bsASIHttpDelegate=_bsASIHttpDelegate;
@synthesize WebHttpAgentSuccussAction=_webHttpAgentSuccussAction;
@synthesize WebHttpAgentFailAction=_webHttpAgentFailAction;


- (id)init
{
    return self;
}

#pragma mark -  startWebAsyRequest

- (void)startWebAsyRequest:(NSMutableDictionary *)requestDict 
           succussFunction:(SEL)suAction 
              failFunction:(SEL)faAction{
    
	NSMutableDictionary *resultDict = [[[NSMutableDictionary alloc] init] autorelease];
    
	@try
	{
		
        NSString *wsName = [requestDict objectForKey:@"wsName"];//服务名
        NSString *xmlNS = [requestDict objectForKey:@"xmlNS"];//命名空间
        
        //1、初始化SOAP消息体
        NSString* soapMsgBody1 = [[NSString alloc] initWithFormat:
                                  @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                                  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" \n"
                                  "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" \n"
                                  "xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                                  "<soap:Body>\n"
                                  "<%@ xmlns=\"%@\">\n", wsName, xmlNS];
        NSString* soapMsgBody2 = [[NSString alloc] initWithFormat:
                                  @"</%@>\n"
                                  "</soap:Body>\n"
                                  "</soap:Envelope>", wsName];
        
        //2、生成SOAP调用参数
        NSString* soapParas = [[NSString alloc] init];
        soapParas = @"";
        
        NSDictionary *data = [requestDict objectForKey:@"data"];
        if (![data isEqual:nil]) {
            for (NSString *key in [data.allKeys objectEnumerator]) {
                soapParas = [soapParas stringByAppendingFormat:@"<%@>%@</%@>\n",key,[data objectForKey:key],key];
            }
        }
        
        //3、生成SOAP消息
        NSString* soapMsg = [soapMsgBody1 stringByAppendingFormat:@"%@%@", soapParas, soapMsgBody2];
        
        //请求发送到的路径
        NSString* urlString = [BSContainer instance].serviceHttpURLString;
        NSURL* url = [NSURL URLWithString:urlString];
        
        ASIHTTPRequest * theRequest = [ASIHTTPRequest requestWithURL:url];
        NSString*msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
        
        //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
        [theRequest addRequestHeader:@"Content-Type"value:@"text/xml; charset=utf-8"];
        [theRequest addRequestHeader:@"SOAPAction"value:[NSString stringWithFormat:@"%@%@", xmlNS, wsName]];
        
        [theRequest addRequestHeader:@"Content-Length"value:msgLength];
        [theRequest setRequestMethod:@"POST"];
        [theRequest appendPostData:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
        
        [theRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        
        //设置超时时间
        theRequest.timeOutSeconds = 60;
        
        [theRequest setDidFinishSelector:@selector(webAsySuccess:)];
        [theRequest setDidFailSelector:@selector(webAsyFail:)];
        
        _webHttpAgentSuccussAction = suAction;
        _webHttpAgentFailAction = faAction;
        
        //设置异步
        theRequest.delegate = self;

        theRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys: [requestDict objectForKey:@"guid"], @"guid", nil];
        //异步调用
        [theRequest startAsynchronous];
	}@catch (NSException * e) {
		NSLog(@"communicateSecurityByCommunicationType NSException:%@",[e description]);
		[resultDict setObject:[NSNumber numberWithInt:IPLAT4M_STATUS_NETWORK_ERROR] forKey:@"status"];
		[resultDict setObject:@"Http request error！" forKey:@"msg"];
        [self exeWebServiceDelegateMethod:_webHttpAgentFailAction result:resultDict];
        return;
	}

}

- (void)webAsySuccess:(ASIFormDataRequest *)request
{

    NSData * dataReply = request.responseData;
    NSMutableDictionary *resultDict = [[[NSMutableDictionary alloc] init] autorelease];
    NSString * guid = [request.userInfo valueForKey:@"guid"];
    [resultDict setObject:guid forKey:@"guid"];
    int statusCode = request.responseStatusCode;
    @try {
        if (statusCode>199&&statusCode<299&dataReply!=nil) {
            NSString * dataReply = [request responseString];
            NSLog(@"%@",dataReply);
            NSError *error;
            GDataXMLDocument *XMLdocument = [[GDataXMLDocument alloc] initWithXMLString:[request responseString] options:0 error:&error];   
            GDataXMLElement *rootElement = [XMLdocument rootElement];
            
            NSArray *rootArray = rootElement.children;
            GDataXMLElement *bodyElement = [rootArray objectAtIndex:0];
            
            NSArray *bodyArray = bodyElement.children;
            GDataXMLElement *phoneDataResponseElement = [bodyArray objectAtIndex:0];
            
            NSArray *phoneDataResponseArray = phoneDataResponseElement.children;
            GDataXMLElement *phoneDataReturnElement = [phoneDataResponseArray objectAtIndex:0];
            
            
            NSArray *phoneDataReturnArray = phoneDataReturnElement.children;
            GDataXMLElement *data = [phoneDataReturnArray objectAtIndex:0];
            
            NSString *dataString =  data.XMLString;
            
//            NSDictionary *dataDic = dataString.JSONValue;
            
            NSLog(@"%@",dataString);
            
            if (dataString == nil) dataString = @"";
            
            //成功将数据返回
            [resultDict setObject:[NSNumber numberWithInt:IPLAT4M_STATUS_SUCCESS] forKey:@"status"];
            
            [resultDict setObject:dataString forKey:@"data"];
            
            [self exeWebServiceDelegateMethod:_webHttpAgentSuccussAction result:resultDict];
            return;
        }else {
            NSLog(@"WebHttpAgent_doPost: Http response code is %d:!",statusCode);
            [resultDict setObject:[NSNumber numberWithInt:IPLAT4M_STATUS_NETWORK_ERROR] forKey:@"status"];
            [resultDict setObject:@"Http response status code error!" forKey:@"msg"];
            [self exeWebServiceDelegateMethod:_webHttpAgentFailAction result:resultDict];
            return;
        }
    }
    @catch (NSException *exception) {
        NSLog(@"WebHttpAgent_doLoginPost: response status code is %d",statusCode);
        [resultDict setObject:[NSNumber numberWithInt:IPLAT4M_STATUS_NETWORK_ERROR] forKey:@"status"];
        [resultDict setObject:@"服务器异常" forKey:@"msg"];
        [self exeWebServiceDelegateMethod:_webHttpAgentFailAction result:resultDict];
        return;
    }
}

- (void)webAsyFail:(ASIFormDataRequest *)request
{
    NSMutableDictionary *resultDict = [[[NSMutableDictionary alloc] init] autorelease];
    NSString * guid = [request.userInfo valueForKey:@"guid"];
    [resultDict setObject:guid forKey:@"guid"];
    [resultDict setObject:[NSNumber numberWithInt:IPLAT4M_STATUS_NETWORK_ERROR] forKey:@"status"];
    [resultDict setObject:@"服务器访问失败，请稍后再尝试连接" forKey:@"msg"];
    [self exeWebServiceDelegateMethod:_webHttpAgentFailAction result:resultDict];
    return;
}
#pragma mark -  startServletAsyRequest

- (void)startServletAsyRequest:(NSMutableDictionary *)requestDict
               succussFunction:(SEL)suAction
                  failFunction:(SEL)faAction{
    
	NSMutableDictionary *resultDict = [[[NSMutableDictionary alloc] init] autorelease];
    
	@try
	{
		
        NSString *urlParas = [[NSString alloc] init];
        urlParas = @"";
        
        NSDictionary *method = [requestDict objectForKey:@"method"];
        if (![method isEqual:nil]) {
            urlParas = [urlParas stringByAppendingFormat:@"?"];
            for (NSString *key in [method.allKeys objectEnumerator]) {
                urlParas = [urlParas stringByAppendingFormat:@"%@=%@&",key,[method objectForKey:key]];
            }
            urlParas = [urlParas substringToIndex:(urlParas.length -1)];
            
        }

        NSString* urlString = [[BSContainer instance].serviceHttpURLString stringByAppendingFormat:@"%@",urlParas];
        NSLog(@"请求服务器地址:%@",urlString);
        NSURL* url = [NSURL URLWithString:urlString];
        
        ASIFormDataRequest * theRequest = [ASIFormDataRequest requestWithURL:url];

        [theRequest setRequestMethod:@"POST"];
        //要向服务器发送的参数数据
        NSDictionary *data = [requestDict objectForKey:@"data"];
        for (NSString *key in [data.allKeys objectEnumerator]) {
            [theRequest setPostValue:[data objectForKey:key] forKey:key];
        }
        
        [theRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        
        //设置超时时间
        theRequest.timeOutSeconds = 60;
        
        [theRequest setDidFinishSelector:@selector(servletAsySuccess:)];
        [theRequest setDidFailSelector:@selector(servletAsyFail:)];
        
        _webHttpAgentSuccussAction = suAction;
        _webHttpAgentFailAction = faAction;
        
        //设置异步
        theRequest.delegate = self;
        
        theRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys: [requestDict objectForKey:@"guid"], @"guid", nil];
        //异步调用
        [theRequest startAsynchronous];
	}@catch (NSException * e) {
		NSLog(@"communicateSecurityByCommunicationType NSException:%@",[e description]);
		[resultDict setObject:[NSNumber numberWithInt:IPLAT4M_STATUS_NETWORK_ERROR] forKey:@"status"];
		[resultDict setObject:@"Http request error！" forKey:@"msg"];
        [self exeWebServiceDelegateMethod:_webHttpAgentFailAction result:resultDict];
        return;
	}
    
}

- (void)servletAsySuccess:(ASIFormDataRequest *)request
{
    
    NSData * dataReply = request.responseData;
    NSMutableDictionary *resultDict = [[[NSMutableDictionary alloc] init] autorelease];
    NSString * guid = [request.userInfo valueForKey:@"guid"];
    [resultDict setObject:guid forKey:@"guid"];
    int statusCode = request.responseStatusCode;
    @try {
        if (statusCode>199&&statusCode<299&dataReply!=nil) {
            NSString * dataReply = [request responseString];
            if (dataReply == nil) dataReply = @"";
            NSLog(@"%@",dataReply);
            
            NSDictionary *dataDic = dataReply.JSONValue;
  
            //成功将数据返回
            [resultDict setObject:[NSNumber numberWithInt:IPLAT4M_STATUS_SUCCESS] forKey:@"status"];
            
            [resultDict setObject:dataDic forKey:@"data"];
            
            [self exeWebServiceDelegateMethod:_webHttpAgentSuccussAction result:resultDict];
            return;
        }else {
            NSLog(@"WebHttpAgent_doPost: Http response code is %d:!",statusCode);
            [resultDict setObject:[NSNumber numberWithInt:IPLAT4M_STATUS_NETWORK_ERROR] forKey:@"status"];
            [resultDict setObject:@"Http response status code error!" forKey:@"msg"];
            [self exeWebServiceDelegateMethod:_webHttpAgentFailAction result:resultDict];
            return;
        }
    }
    @catch (NSException *exception) {
        NSLog(@"WebHttpAgent_doLoginPost: response status code is %d",statusCode);
        [resultDict setObject:[NSNumber numberWithInt:IPLAT4M_STATUS_NETWORK_ERROR] forKey:@"status"];
        [resultDict setObject:@"服务器异常" forKey:@"msg"];
        [self exeWebServiceDelegateMethod:_webHttpAgentFailAction result:resultDict];
        return;
    }
}

- (void)servletAsyFail:(ASIFormDataRequest *)request
{
    NSMutableDictionary *resultDict = [[[NSMutableDictionary alloc] init] autorelease];
    NSString * guid = [request.userInfo valueForKey:@"guid"];
    [resultDict setObject:guid forKey:@"guid"];
    [resultDict setObject:[NSNumber numberWithInt:IPLAT4M_STATUS_NETWORK_ERROR] forKey:@"status"];
    [resultDict setObject:@"服务器访问失败，请稍后再尝试连接" forKey:@"msg"];
    [self exeWebServiceDelegateMethod:_webHttpAgentFailAction result:resultDict];
    return;
}

#pragma mark - 回调

- (void)exeWebServiceDelegateMethod:(SEL)action 
                             result:(id)result
{
    if (_bsASIHttpDelegate&&[_bsASIHttpDelegate respondsToSelector:action] ) {
        [_bsASIHttpDelegate performSelector:action  withObject:result];
    }
}

- (void)dealloc
{
    [_bsASIHttpDelegate release];
	[super dealloc];
}
@end
