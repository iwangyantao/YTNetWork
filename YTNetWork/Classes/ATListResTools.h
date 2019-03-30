//
//  ATListResTools.h
//  Attendance
//
//  Created by YT on 2019/3/16.
//  Copyright © 2019 AT. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ListResToolsCallback)(void);
@interface ATListResTools : NSObject
@property (nonatomic, copy, readonly) ListResToolsCallback listResToolsCallback;
/** 数据数组 */
@property (nonatomic, strong, readonly) NSMutableArray *dataArr;
/** 是否没有更多数据了 */
@property (nonatomic, assign, readonly) BOOL isNoMoreData;
- (instancetype)initWithRequestUrlString:(NSString*)urlString scrollView:(UIScrollView *)scrollView callBack:(ListResToolsCallback)callBack;
- (void)listRequsetisSuccess:(BOOL)isSuccess isNoMoreData:(BOOL)isNoMoreData dataList:(NSArray *)listArr oresDict:(NSDictionary *)ores isRefresh:(BOOL)isRefresh;
- (void)stop;
- (void)start;
- (void)loadMore;
@end
