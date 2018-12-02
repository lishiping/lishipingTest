//
//  WINVAppLifecycleProtocol.h
//  Wing
//
//  Created by jixuhui on 2017/12/28.
//  Copyright © 2017年 AMAP. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 数字越大优先级越低，如果有特殊需求，需要有依赖关系，各分界以中间值为界限，比如501，归属low；500，归属high
 */
typedef NS_ENUM(NSUInteger, WINLaunchPriority) {
    WINLaunchPriorityHigh = 100,
    WINLaunchPriorityLow = 1000
};

@protocol WINVAppLifecycleProtocol <NSObject>
@optional

/**
 @brief  业务模块配置冷启动的优先级，默认为WINLaunchPriorityLow
 @return WINLaunchPriority枚举类型值
 */
+ (WINLaunchPriority)launchPriority;

/**
 @brief  业务模块配置延迟冷启动（地图完成首帧加载）的优先级，默认为WINLaunchPriorityLow
 @return WINLaunchPriority枚举类型值
 */
+ (WINLaunchPriority)mapFirstRenderPriority;

/**
 @brief app生命周期仅一次，冷启动
 @param launchOptions UIApplication launchOptions
 */
+ (void)vAppLaunchWithOptions:(nullable NSDictionary *)launchOptions;

/**
 延迟冷启动，地图完成首帧加载之后
 */
+ (void)vAppLaunchAfterMapFirstRender;

/**
 @brief  热启动，app从后台进入前台
 */
+ (void)vAppEnterForground;

/**
 @brief  app从前台进入后台
 */
+ (void)vAppEnterBackground;

@end

NS_ASSUME_NONNULL_END

