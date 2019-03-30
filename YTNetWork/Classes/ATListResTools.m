//
//  ATListResTools.m
//  Attendance
//
//  Created by YT on 2019/3/16.
//  Copyright © 2019 AT. All rights reserved.
//

#import "ATListResTools.h"
#import "BaseListYTKRequest.h"
#import <MJExtension/MJExtension.h>
#import <MJRefresh/MJRefresh.h>
@interface ATListResTools ()<BaseListYTKRequestDelegate>
@property (nonatomic, strong) BaseListYTKRequest *listRes;
@property (nonatomic, copy, readwrite) ListResToolsCallback listResToolsCallback;
/** 数据数组 */
@property (nonatomic, strong, readwrite) NSMutableArray *dataArr;
/** 是否没有更多数据了 */
@property (nonatomic, assign, readwrite) BOOL isNoMoreData;
/** UIScrollView<#des#> */
@property (nonatomic, weak) UIScrollView *scrollView;
@end

@implementation ATListResTools

- (void)dealloc
{
    
}
- (instancetype)initWithRequestUrlString:(NSString *)urlString scrollView:(UIScrollView *)scrollView callBack:(ListResToolsCallback)callBack
{
    if (self = [super init]) {
        self.listRes.requestURL = urlString;
        self.listResToolsCallback = callBack;
        self.scrollView = scrollView;
    }
    return self;
}

- (void)listRequsetisSuccess:(BOOL)isSuccess isNoMoreData:(BOOL)isNoMoreData dataList:(NSArray *)listArr oresDict:(NSDictionary *)ores isRefresh:(BOOL)isRefresh
{
    self.isNoMoreData = isNoMoreData;
    if (self.scrollView.mj_footer.isRefreshing) {
        if (isNoMoreData) {
            [self.scrollView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.scrollView.mj_footer endRefreshing];
        }
    }
    if (self.scrollView.mj_header.isRefreshing) {
        [self.scrollView.mj_header endRefreshing];
    }
}

- (void)stop
{
    [self.listRes stop];
    self.listRes.delegate = nil;
    self.listRes = nil;
}

- (void)start
{
    [self.listRes loadData];
    [self.scrollView.mj_footer resetNoMoreData];
}

- (void)loadMore
{
    [self.listRes loadMore];
}

- (BaseListYTKRequest *)listRes
{
    if (!_listRes) {
        _listRes = [[BaseListYTKRequest alloc] init];
        _listRes.listDelegate = self;
    }
    return _listRes;
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

@end
