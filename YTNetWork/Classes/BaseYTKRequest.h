//
//  BaseYTKRequest.h
//  MicroSliverOperate
//
//  Created by 王延涛 on 2017/2/16.
//  Copyright © 2017年 www.MicroSliverOperate.com. All rights reserved.
//
#import <YTKNetwork/YTKNetwork.h>
typedef NS_ENUM(NSInteger, BaseRequestMethod) {
    BaseRequestMethodGET = 0,
    BaseRequestMethodPOST,
    BaseRequestMethodHEAD,
    BaseRequestMethodPUT,
    BaseRequestMethodDELETE,
    BaseRequestMethodPATCH,
};

typedef void(^BaseRequestCompletionBlock)(id resp);
typedef void(^BaseRequestIsNoMoreBlock)(BOOL isNoMore);

@interface BaseYTKRequest : YTKRequest
/** 根域名 */
@property(nonatomic,copy)NSString *baseURL;
/** 地址 */
@property(nonatomic,copy)NSString *requestURL;
/** 请求方式 */
@property(nonatomic,assign)BaseRequestMethod  baseRequestMethed;
@property(nonatomic,strong)NSMutableDictionary *param;
@property(nonatomic,strong)NSDictionary *jsonV;
/** 超时时长 */
@property (nonatomic, assign) NSTimeInterval outTime;
/**
 不需要分页的请求

 @param success 成功回调
 @param failure 失败回调
 */
- (void)startWithSuccess:(BaseRequestCompletionBlock)success
                failure:(BaseRequestCompletionBlock)failure;


@end
