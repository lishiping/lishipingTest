//
//  WINVAppService.h
//  Wing
//
//  Created by jixuhui on 2017/12/28.
//  Copyright © 2017年 AMAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 职责：
 数据交互；
 */
@interface WINVAppService : NSObject

/**
 @brief  每个业务Bundle都是单例
 @return 单例
 */
+ (nullable instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
