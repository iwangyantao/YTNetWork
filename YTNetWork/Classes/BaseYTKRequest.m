//
//  BaseYTKRequest.m
//  MicroSliverOperate
//
//  Created by 王延涛 on 2017/2/16.
//  Copyright © 2017年 www.MicroSliverOperate.com. All rights reserved.
//

#import "BaseYTKRequest.h"
#import "AFNetworking.h"
#import "ATNetParamsTools.h"

@interface BaseYTKRequest ()

@end

@implementation BaseYTKRequest

- (NSString *)baseUrl{
  return self.baseURL;
}

- (NSString *)requestUrl
{
    return self.requestURL;
}

///请求入参
- (nullable id)requestArgument
{
//    NSString *checksum = [CCTools getSignWithParams:self.param urlStr:@"" isIM:YES];
//    self.param[@"sign"] = checksum;
//    NSLog(@"cansu :   %@",self.param);
    [ATNetParamsTools getSignWithParams:self.param urlStr:nil];
    return self.param;
}
///请求寄存器，默认为http
- (YTKRequestSerializerType)requestSerializerType
{
    return YTKRequestSerializerTypeHTTP;
}
///响应寄存器，默认JSON响应数据 详见 `responseObject`.
- (YTKResponseSerializerType)responseSerializerType
{
    return YTKResponseSerializerTypeJSON;
}
- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary
{
    return @{};
}
//请求超时时间
- (NSTimeInterval)requestTimeoutInterval
{
    if (self.outTime < 1) {
        return 10;
    }
    return self.outTime;
}
/////失败/成功的回调，一般不需要再这里实现，如果要实现，请必须调用`[super requestFailedFilter];`
//- (void)requestFailedFilter
//{
//    [super requestFailedFilter];
//}
//- (void)requestCompleteFilter{
//    [super requestCompleteFilter];
//}
- (NSDictionary *)jsonValidator{
    return _jsonV;
}

- (void)startWithSuccess:(BaseRequestCompletionBlock)success failure:(BaseRequestCompletionBlock)failure
{
//    my_WS(ws);
    [self startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (![request.responseObject isKindOfClass:[NSDictionary class]]) {
            failure(request.error);
        } else {
            NSDictionary *dict = request.responseObject;
            if (![dict.allKeys containsObject:@"code"] && ![dict.allKeys containsObject:@"resultCode"]) {
                failure(request.responseObject);

            } else {
                id code = dict[@"code"];
                if (!code) {
                    code = dict[@"resultCode"];
                }
                if (code) {
                    success(request.responseObject);
                } else {
                    failure(request.responseObject);
                }
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self _failureWithRequest:request onComplete:^(BOOL msuccess, id responseData, NSError *error) {
            if (msuccess) {
                success(request.responseObject);
            } else {
                failure(request.responseObject);
            }
        }];
    }];
}
- (void)_failureWithRequest:(YTKBaseRequest *)request onComplete:(void (^)(BOOL success, id responseData, NSError *error))block
{
    if ([request.responseObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = request.responseObject;
        if ([dict.allKeys containsObject:@"data"]) {
            if (block) {
                block(YES, dict, nil);
                return;
            }
        }
    }
    if (block) {
        block(NO,nil,nil);
    }
}

- (NSMutableDictionary *)param
{
    if (!_param) {
        _param = [NSMutableDictionary dictionary];
    }
    return _param;
}

@end
