//
//  CCNetResModel.h
//  kaka
//
//  Created by YT on 2017/6/7.
//  Copyright © 2017年 CC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCNetResModel : NSObject
/** msg */
@property (nonatomic, copy) NSString *msg;
/** data */
@property (nonatomic, strong) id data;
/** code */
@property (nonatomic, copy) NSString *typeCode;

@end
