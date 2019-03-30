//
//  BaseListYTKRequest.m
//  NanoChatLive
//
//  Created by YT on 2017/6/19.
//  Copyright © 2017年 www.NanoChatLive.com. All rights reserved.
//

#import "BaseListYTKRequest.h"
#import "ATNetParamsTools.h"
#import "CCNetResModel.h"
#import <MJExtension/MJExtension.h>
@interface BaseListYTKRequest ()<YTKRequestDelegate>
/** page */
@property (nonatomic, assign) NSInteger page;
/** 是否没有更多数据 */
@property (nonatomic, assign) BOOL isNoMoreDataBl;
/** 是否是下拉刷新的 */
@property (nonatomic, assign) BOOL isRefresh;
@end

@implementation BaseListYTKRequest
- (instancetype)init
{
    if (self = [super init]) {
        self.delegate = self;
    }
    return self;
}
///请求入参
- (nullable id)requestArgument
{
    if (self.page) {
        self.param[@"page"] = @(self.page);
    } else {
        self.param[@"page"] = @1;
    }
//    self.param[@"pageSize"] = @20;
//    NSString *checksum = [CCTools getSignWithParams:self.param urlStr:@"" isIM:YES];
//    self.param[@"sign"] = checksum;
//    NSLog(@"列表形式的 参数：%@",self.param);
    [ATNetParamsTools getSignWithParams:self.param urlStr:nil];
    return self.param;
}
- (void)loadData
{
    self.page = 1;
    self.isRefresh = YES;
    self.isNoMoreDataBl = NO;
    [self start];
}

- (void)loadMore
{
    self.isRefresh = NO;
    if (!self.isNoMoreDataBl) {
        [self start];
    } else {
        if ([self.listDelegate respondsToSelector:@selector(listRequsetisSuccess:isNoMoreData:dataList:oresDict:isRefresh:)]) {
            [self.listDelegate listRequsetisSuccess:YES isNoMoreData:YES dataList:@[] oresDict:@{} isRefresh:self.isRefresh];
        }
    }
}
- (void)requestFinished:(__kindof YTKBaseRequest *)request
{
    if (![request.responseObject isKindOfClass:[NSDictionary class]]) {
        [self noMoreData:NO resuest:request];
        return;
    }
    NSDictionary *reqdict = (NSDictionary *)request.responseObject;
    if (!([reqdict.allKeys containsObject:@"typeCode"] && [reqdict.allKeys containsObject:@"data"])) {
        [self noMoreData:NO resuest:request];
        return;
    }
   
    if (![reqdict[@"data"] isKindOfClass:[NSArray class]] ){
        [self noMoreData:NO resuest:request];
       return;
    }
    CCNetResModel *netModel = [CCNetResModel mj_objectWithKeyValues:reqdict];
    NSString *codeStr = netModel.typeCode;
    if (![codeStr isEqualToString:@"1"]) {
        [self noMoreData:NO resuest:request];
        return;
    }
    NSArray *dataArr = reqdict[@"data"];
    if (dataArr.count == 0) {
        self.isNoMoreDataBl = YES;
        if ([self.listDelegate respondsToSelector:@selector(listRequsetisSuccess:isNoMoreData:dataList:oresDict:isRefresh:)]) {
            [self.listDelegate listRequsetisSuccess:YES isNoMoreData:YES dataList:@[] oresDict:reqdict isRefresh:self.isRefresh];
        }
         NSLog(@"没有数据了 --- %@ 返回： %@ 信息：%@ : 参数：%@", request.response, request.responseObject, request.error, self.param);
        self.page ++;
        return;
    }
    
    id pageSize;
    if ([reqdict.allKeys containsObject:@"pageSize"]) {
        pageSize = reqdict[@"pageSize"];
    }
    if ([pageSize isKindOfClass:[NSString class]]) {
        NSString *pageSizeString = pageSize;
        self.isNoMoreDataBl = (pageSizeString.integerValue > dataArr.count) ? YES : NO;
    } else if ([pageSize isKindOfClass:[NSNumber class]]) {
        NSNumber *pageSizeNumber = pageSize;
        self.isNoMoreDataBl = (pageSizeNumber.integerValue > dataArr.count) ? YES : NO;
    } else {
        self.isNoMoreDataBl = NO;
    }
    if (self.listDelegate) {
        if ([self.listDelegate respondsToSelector:@selector(listRequsetisSuccess:isNoMoreData:dataList:oresDict:isRefresh:)]) {
            [self.listDelegate listRequsetisSuccess:YES isNoMoreData:self.isNoMoreDataBl dataList:dataArr oresDict:reqdict isRefresh:self.isRefresh];
            self.page ++;
        }
    }
}
- (void)requestFailed:(__kindof YTKBaseRequest *)request
{
    id responseObject = request.responseObject;
    responseObject = ![responseObject isKindOfClass:[NSData class]] ? responseObject : @"";
    NSLog(@"错误地址 --- %@ 错误返回： %@ 错误信息：%@ : 错误参数：%@", request.response, responseObject, nil, self.param);
    if (self == nil) return;
    if (self.listDelegate == nil) return;
    if ([request.responseObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary *reqdict = request.responseObject;
        id code = nil;
        if ([reqdict.allKeys containsObject:@"typeCode"]) {
            code = reqdict[@"typeCode"];
        }
        if (code && [reqdict.allKeys containsObject:@"data"]) {
            if ([reqdict[@"data"] isKindOfClass:[NSArray class]]) {
                CCNetResModel *netModel = [CCNetResModel mj_objectWithKeyValues:reqdict];
                NSString *codeStr = netModel.typeCode;
                if (![codeStr isEqualToString:@"500"]) {
                    [self requestFinished:request];
                    return;
                }
            }
        }
    }
    if (self.listDelegate) {
        if ([self.listDelegate respondsToSelector:@selector(listRequsetisSuccess:isNoMoreData:dataList:oresDict:isRefresh:)]) {
            [self.listDelegate listRequsetisSuccess:NO isNoMoreData:NO dataList:nil oresDict:nil isRefresh:self.isRefresh];
        }
    }
}
- (void)noMoreData:(BOOL)noMoreData resuest:(YTKRequest *)request
{
    self.isNoMoreDataBl = noMoreData;
    if (self.listDelegate) {
        if ([self.listDelegate respondsToSelector:@selector(listRequsetisSuccess:isNoMoreData:dataList:oresDict:isRefresh:)]) {
            [self.listDelegate listRequsetisSuccess:NO isNoMoreData:noMoreData dataList:nil oresDict:nil isRefresh:self.isRefresh];
        }
    }
 
    NSLog(@"错误地址 --- %@ 错误返回： %@ 错误信息：%@ : 错误参数：%@", request.response, request.responseObject, request.error, self.param);
}

@end
