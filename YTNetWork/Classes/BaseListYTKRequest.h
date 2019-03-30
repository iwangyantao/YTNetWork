//
//  BaseListYTKRequest.h
//  NanoChatLive
//
//  Created by YT on 2017/6/19.
//  Copyright © 2017年 www.NanoChatLive.com. All rights reserved.
//

#import "BaseYTKRequest.h"

@protocol BaseListYTKRequestDelegate <NSObject>
- (void)listRequsetisSuccess:(BOOL)isSuccess isNoMoreData:(BOOL)isNoMoreData dataList:(NSArray *)listArr oresDict:(NSDictionary *)ores isRefresh:(BOOL)isRefresh;
@end


@interface BaseListYTKRequest : BaseYTKRequest
///** BaseListYTKRequestDelegate */
//@property(nonatomic,copy)NSString *listName;
@property (nonatomic, assign) id <BaseListYTKRequestDelegate> listDelegate;
- (void)loadData;
- (void)loadMore;
@end
