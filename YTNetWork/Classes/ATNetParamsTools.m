//
//  ATNetParamsTools.m
//  Attendance
//
//  Created by YT on 2019/2/15.
//  Copyright © 2019 AT. All rights reserved.
//

#import "ATNetParamsTools.h"
//#import <UIDevice+YYAdd.h>
@implementation ATNetParamsTools
+ (NSString *)getSignWithParams:(NSMutableDictionary *)dict urlStr:(NSString *)url
{
    // 子类集成 重写该方法可以添加默认的参数
    if ([dict.allKeys containsObject:@"sign"]) {
        [dict removeObjectForKey:@"sign"];
    }
//    ATUserInfoManager *model = [ATAppManager sharedAPPData].user;
//    if (model.uuid.length > 1) {
//        dict[@"uuid"] = model.uuid;
//    } else {
//        dict[@"uuid"] = @"";
//
//    }
    NSString *versionMain =
    [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    if (versionMain) {
        dict[@"ver"] = versionMain;
    }
    dict[@"s"] = @1;
//    NSString *platform = [UIDevice currentDevice].machineModelName;
//    if (platform) {
//        dict[@"dem"] = platform;
//    }
    NSString *phoneVersion = [[UIDevice currentDevice] systemVersion];
    if (phoneVersion) {
        dict[@"sysphoneVersion"] = phoneVersion;
    }
//    NSMutableString *contentString  =[NSMutableString string];
//    NSArray *keys = [dict allKeys];
//    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//        return [obj1 compare:obj2 options:NSNumericSearch];
//    }];
//
//    for (NSString *keyStr in sortedArray) {
//        [contentString appendFormat:@"%@&",dict[keyStr]];
//    }
//    NSString *mKey = @"JI2e1j3ZN^19cZ~dKb";
//
//    NSString *preStr = [NSString stringWithFormat:@"%@%@",contentString, mKey];
//    //    NSLog(@"preStr:%@",preStr);
//    NSString *presign = [[preStr MD5] MD5];
//    NSString *sign = nil;
//    if (presign.length >= 28) {
//        sign = [presign substringFromIndex:2 toIndex:28];
//
//    } else {
//        sign = presign;
//    }
//    //    NSLog(@"preStr---%@",preStr);
//    //    NSLog(@"sign--%@",sign);
    return @"";
}

@end
