//
//  WINVAppManager.h
//  Wing
//
//  Created by jixuhui on 2017/12/28.
//  Copyright © 2017年 AMAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WINVAppService.h"
#import "WINVAppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

/**
 遵循UIApplicationDelegate协议；
 负责管理业务Bundle的中心，完成App生命周期派发，业务Bundle对象获取；
 */
@interface WINVAppManager : NSObject <UIApplicationDelegate>

/**
 @brief 获取单例的入口方法
 @return WINVAppManager单例
 */
+ (instancetype)sharedInstance;

/**
 @brief 在业务Bundle的load方法里，向内部cache注册key:Protocol value:Class键值对，完成对外功能注册
 @param vAppClass 业务Bundle 类名
 @param vAppProtocol 业务Bundle 协议名
 */
- (void)registerVAppServiceClass:(Class)vAppClass protocol:(nullable Protocol *)vAppProtocol;

/**
 @brief 注册接收vapp生命周期bundle类，会派发生命周期的类方法，推荐使用
 @param vAppClass 业务Bundle类
 */
- (void)registerVAppLifecycleWithVApp:(Class)vAppClass;

/**
 @brief 注册接收app生命周期bundle类，会创建bundle实例对象进行生命周期派发。不推荐使用，只针对特殊业务需求
 @param vAppClass 业务Bundle类
 */
- (void)registerAppLifecycleWithVApp:(Class)vAppClass;

/**
 @brief 通过Protocol获取对应Bundle实例
 @param vAppProtocol 业务Bundle 协议名
 @return 业务Bundle 实例
 */
- (nullable id)serviceWithProtocol:(nullable Protocol *)vAppProtocol;

@end

NS_ASSUME_NONNULL_END

