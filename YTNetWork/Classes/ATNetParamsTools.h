//
//  ATNetParamsTools.h
//  Attendance
//
//  Created by YT on 2019/2/15.
//  Copyright © 2019 AT. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ATNetParamsTools : NSObject
+ (NSString *)getSignWithParams:(NSMutableDictionary *)dict urlStr:(NSString *)url;

@end

