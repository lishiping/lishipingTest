//
//  SPAppManager.h
//  Wing
//
//  Created by lishiping on 2017/12/28.
//  Copyright © 2017年 AMAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SPAppDelegate.h"


/***********虚拟APP模块*************/
/*
 1.本模块功能将APPDelegate拆开执行，多业务模块继承开发使用更好
 2.可以创建自定义继承SPAppDelegate类并实现load和shareInstance方法，并实现UIApplication协议，完成协议方法
 3.如果遇到业务模块之间有依赖顺序可以使用高低优先级去管理didFinishLaunchingWithOptions启动顺序，其他代理方法之间没有顺序，为了让其他代理方法分开
*/
@class SPAppDelegate;
/**
 数字越大优先级越大，如果有特殊需求，需要有依赖关系，可以设置1100比1000大的优先比1000先执行等
 */
typedef NS_ENUM(NSUInteger, SPLaunchPriority) {
    SPLaunchPriorityLow = 100,
    SPLaunchPriorityHigh = 1000
};

NS_ASSUME_NONNULL_BEGIN

/**
 遵循UIApplicationDelegate协议；
 负责管理业务Bundle的中心，完成App生命周期派发，业务Bundle对象获取；
 */
@interface SPAppManager : NSObject <UIApplicationDelegate>

/**
 @brief 获取单例的入口方法
 @return SPAppManager单例
 */
+ (instancetype)sharedInstance;

/**
 @brief 在load方法里面注册接收app生命周期bundle类，会创建bundle实例对象进行生命周期派发。
 @param appClass 业务Bundle类
 @param launchPriority 业务Bundle启动优先级
 */
- (void)registerAppLifecycleWithVApp:(Class)appClass launchPriority:(SPLaunchPriority)launchPriority;

@end

NS_ASSUME_NONNULL_END

