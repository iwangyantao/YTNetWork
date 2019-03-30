//
//  MSApi.m
//  MicroSliverOperate
//
//  Created by 王延涛 on 2017/2/16.
//  Copyright © 2017年 www.MicroSliverOperate.com. All rights reserved.
//

#import "MSApi.h"
#import "CCNetResModel.h"
#import <MJExtension/MJExtension.h>
@implementation MSApi

+(void)getContentWithParams:(NSDictionary *)dict jsonValidator:(NSDictionary *)jsonValidator toURL:(NSString *)url baseURL:(NSString *)baseURL onComplete:(void (^)(BOOL, CCNetResModel *, NSError *))block{
    [self getContentWithParams:dict jsonValidator:jsonValidator toURL:url baseURL:baseURL outTime:10 onComplete:block];
}

+ (void)sendPostContent:(NSDictionary *)dict jsonValidator:(NSDictionary *)jsonValidator  toURL:(NSString *)url baseURL:(NSString *)baseURL onComplete:(void (^)(BOOL, CCNetResModel *, NSError *))block{
    //    NSLog(@"url    -------     %@",url);
    
    [self sendPostContent:dict jsonValidator:jsonValidator toURL:url baseURL:baseURL outTime:10 onComplete:block];
}

+ (void)getContentWithParams:(NSDictionary *)paramDict jsonValidator:(NSDictionary *)jsonValidator toURL:(NSString *)url baseURL:(NSString *)baseURL outTime:(NSTimeInterval)outTime onComplete:(void (^)(BOOL, CCNetResModel *, NSError *))block
{
    //    NSLog(@"url    -------     %@",url);
//    baseURL = baseURL == nil ? Domain_Base : baseURL;
    BaseYTKRequest *ytk_request = [[BaseYTKRequest alloc]init];
    ytk_request.param = [NSMutableDictionary dictionaryWithDictionary:paramDict];
    ytk_request.baseURL = baseURL;
    ytk_request.requestURL = url;
    ytk_request.outTime = outTime;
    if (jsonValidator) {
        ytk_request.jsonV = jsonValidator;
    }
    ytk_request.ignoreCache = YES;
    
    ytk_request.baseRequestMethed = BaseRequestMethodGET;
    [ytk_request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (block) {
            if (![request.responseObject isKindOfClass:[NSDictionary class]]) {
                block(NO,nil,nil);
                id responseObject = request.responseObject;
                responseObject = ![responseObject isKindOfClass:[NSData class]] ? responseObject : @"";
//                responseObject = [responseObject isKindOfClass:[]]
            
                NSLog(@"错误地址 --- %@ 错误返回： %@ 错误信息：%@ : 错误参数：%@", request.response, responseObject, nil, request.requestArgument);
//                [[[UIApplication sharedApplication] keyWindow] zj_showWarning:@"网络异常，稍后再试" and:1.5];

                return ;
            }
            NSDictionary *netDict = request.responseObject;
            CCNetResModel *netModel = [CCNetResModel mj_objectWithKeyValues:netDict];
            if (netModel.typeCode.length == 0) {
                block(NO,netModel,nil);
                NSLog(@"错误地址 --- %@ 错误返回： %@ 错误信息：%@ : 错误参数：%@", request.response, request.responseObject, request.error, request.requestArgument);
//                [[[UIApplication sharedApplication] keyWindow] zj_showWarning:@"网络异常，稍后再试" and:1.5];

                return;
            }
            
            if (netModel.typeCode.integerValue != 1) {
                block(NO,netModel,nil);
                NSLog(@"错误地址 --- %@ 错误返回： %@ 错误信息：%@ : 错误参数：%@", request.response, request.responseObject, request.error, request.requestArgument);
                NSString *tipString = netModel.msg.length == 0 ? @"网络异常，稍后再试" : netModel.msg;
                NSLog(@"%@",tipString);
//                [[[UIApplication sharedApplication] keyWindow] zj_showWarning:tipString and:1.5];
                return;
            }
            block(YES,netModel,nil);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        id responseObject = request.error;
        responseObject = ![responseObject isKindOfClass:[NSData class]] ? responseObject : @"";
        NSLog(@"request.error:  %@ ---- %@",responseObject,request.requestArgument);
        if (block) {
            block(NO,nil,responseObject);
        }
    }];
}




+ (void)sendPostContent:(NSDictionary *)paramDict jsonValidator:(NSDictionary *)jsonValidator toURL:(NSString *)url baseURL:(NSString *)baseURL outTime:(NSTimeInterval)outTime onComplete:(void (^)(BOOL, CCNetResModel *, NSError *))block
{
//    baseURL = baseURL == nil ? Domain_Base : baseURL;

    BaseYTKRequest *ytk_request = [[BaseYTKRequest alloc]init];
    ytk_request.param = [NSMutableDictionary dictionaryWithDictionary:paramDict];
    if (jsonValidator) {
        ytk_request.jsonV = jsonValidator;
    }
    ytk_request.baseURL = baseURL;
    ytk_request.requestURL = url;
    ytk_request.baseRequestMethed = BaseRequestMethodPOST;
    ytk_request.outTime = outTime;

    ytk_request.ignoreCache = YES;
    [ytk_request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        //        NSLog(@"request.responseObject=:  %@",request.responseObject);
        if (block) {
            if (![request.responseObject isKindOfClass:[NSDictionary class]]) {
                block(NO,nil,nil);
                NSLog(@"错误地址 --- %@ 错误返回： %@ 错误信息：%@ : 错误参数：%@", request.response, request.responseObject, request.error, request.requestArgument);
//                [[[UIApplication sharedApplication] keyWindow] zj_showWarning:@"网络异常，稍后再试" and:1.5];
                
                return ;
            }
            NSDictionary *netDict = request.responseObject;
            CCNetResModel *netModel = [CCNetResModel mj_objectWithKeyValues:netDict];
            if (netModel.typeCode.length == 0) {
                block(NO,netModel,nil);
                NSLog(@"错误地址 --- %@ 错误返回： %@ 错误信息：%@ : 错误参数：%@", request.response, request.responseObject, request.error, request.requestArgument);
//                [[[UIApplication sharedApplication] keyWindow] zj_showWarning:@"网络异常，稍后再试" and:1.5];
                
                return;
            }
            
            if (netModel.typeCode.integerValue != 1) {
                block(NO,netModel,nil);
                NSLog(@"错误地址 --- %@ 错误返回： %@ 错误信息：%@ : 错误参数：%@", request.response, request.responseObject, request.error, request.requestArgument);
                NSString *tipString = netModel.msg.length == 0 ? @"网络异常，稍后再试" : netModel.msg;
                NSLog(@"%@",tipString);

//                [[[UIApplication sharedApplication] keyWindow] zj_showWarning:tipString and:1.5];
                return;
            }
            block(YES,netModel,nil);
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        id responseObject = request.error;
        responseObject = ![responseObject isKindOfClass:[NSData class]] ? responseObject : @"";
        NSLog(@"request.error:  %@ ---- %@",responseObject,request.requestArgument);
        if (block) {
            block(NO,nil,responseObject);
        }
    }];

}


@end
