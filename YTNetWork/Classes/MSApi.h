//
//  MSApi.h
//  MicroSliverOperate
//
//  Created by 王延涛 on 2017/2/16.
//  Copyright © 2017年 www.MicroSliverOperate.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseYTKRequest.h"

@class BaseYTKRequest,CCNetResModel;
@interface MSApi : NSObject
@property(nonatomic,assign)BaseYTKRequest* baseRequest;


//普通get请求
+ (void)getContentWithParams:(NSDictionary *)dict jsonValidator:(NSDictionary *)jsonValidator  toURL:(NSString *)url  baseURL:(NSString *)baseURL outTime:(NSTimeInterval)outTime onComplete:(void (^)(BOOL success, CCNetResModel *responseData,NSError *error))block;

//普通get请求
+ (void)getContentWithParams:(NSDictionary *)dict jsonValidator:(NSDictionary *)jsonValidator  toURL:(NSString *)url  baseURL:(NSString *)baseURL onComplete:(void (^)(BOOL success, CCNetResModel *responseData,NSError *error))block;
//普通post请求
+ (void)sendPostContent:(NSDictionary *)dict jsonValidator:(NSDictionary *)jsonValidator  toURL:(NSString*)url baseURL:(NSString*)baseURL onComplete:(void (^)(BOOL success, CCNetResModel *responseData, NSError *error))block;

//普通post请求
+ (void)sendPostContent:(NSDictionary *)dict jsonValidator:(NSDictionary *)jsonValidator  toURL:(NSString*)url baseURL:(NSString*)baseURL outTime:(NSTimeInterval)outTime onComplete:(void (^)(BOOL success, CCNetResModel *responseData, NSError *error))block;

@end
