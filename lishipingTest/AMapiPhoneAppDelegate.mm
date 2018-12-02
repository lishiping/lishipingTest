//
//  AMapiPhoneAppDelegate.m
//  AMapiPhone
//
//  Created by Martin Yin on 8/7/11.
//  Copyright 2011 Autonavi. All rights reserved.
//

#import "AMapiPhoneAppDelegate.h"
#import "WINVAppManager.h"

//#import "AMCommonConfigUtility.h"
//#import "LTMCaribbeanUtility.h"
#import <mach/mach_time.h>
#import "WINOldTaskDefine.h"
//#import "WINPerformanceDebugUtility.h"

#ifdef AMAP_PERFORMANCE_TEST
#import "AMapEye_APMLib/AMapEye_APM.h"
#endif

@protocol WINCarPlayVAppProtocol;
NSMutableDictionary *launchTimeDic;

@implementation AMapiPhoneAppDelegate

+ (void)load
{
    //App启动，最早的时机，不能放在后面，不然导致统计数据不准确
    launchTimeDic = [[NSMutableDictionary alloc] initWithCapacity:7];
    [launchTimeDic setValue:@"1" forKey:@"from"];
    
    NSDate *now = [NSDate date];
    NSTimeInterval time = [now timeIntervalSince1970];
    [launchTimeDic setValue:@(time*1000) forKey:@"app_startup"];
    
//    [WINPerformanceDebugUtility initPerformanceNodes];
    
    //暂时把这里当做启动开始
//    [AMCommonConfigUtility commonConfig].appStartPreTime = mach_absolute_time();
    
    //APM TEST
//    [LTMCaribbeanUtility startAPMTaskID:@"Launch" interval:APM_LAUNCH_TASK_INTERNAL mode:AMEPerformanceAnalyzerShowTypeAll];
}

#pragma mark Application lifecycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
#ifdef AMAP_PERFORMANCE_TEST  // 线下性能测试
    [AMapEye_APM initAPM];
    [AMapEye_APM setPostDic:^BOOL(NSUInteger modeInt,NSString *jsonStr){
        return YES;
    }];
#endif
    
//    [WINPerformanceDebugUtility addPerformanceNodes];
    
    //进入主图
    NSDate *now = [NSDate date];
    NSTimeInterval time = [now timeIntervalSince1970];
    [launchTimeDic setValue:@(time*1000) forKey:@"app_mainmap"];
    
    return [[WINVAppManager sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [[WINVAppManager sharedInstance] applicationWillResignActive:application];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[WINVAppManager sharedInstance] applicationDidEnterBackground:application];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[WINVAppManager sharedInstance] applicationWillEnterForeground:application];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[WINVAppManager sharedInstance] applicationDidBecomeActive:application];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    [[WINVAppManager sharedInstance] applicationWillTerminate:application];
}

- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)())completionHandler
{
    [[WINVAppManager sharedInstance] application:application handleEventsForBackgroundURLSession:identifier completionHandler:completionHandler];
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    [[WINVAppManager sharedInstance] application:application performActionForShortcutItem:shortcutItem completionHandler:completionHandler];
}


#pragma mark Memory management
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[WINVAppManager sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [[WINVAppManager sharedInstance] application:application didReceiveRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [[WINVAppManager sharedInstance] application:application didReceiveLocalNotification:notification];
}

#pragma mark UI相关
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return [[WINVAppManager sharedInstance] application:application supportedInterfaceOrientationsForWindow:window];
}

- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void(^)(NSDictionary *replyInfo))reply{
    [[WINVAppManager sharedInstance] application:application handleWatchKitExtensionRequest:userInfo reply:reply];
}

//#pragma mark - CPApplicationDelegate
//
//- (void)application:(UIApplication *)application didConnectCarInterfaceController:(CPInterfaceController *)interfaceController toWindow:(CPWindow *)window
//API_AVAILABLE(ios(12.0))
//{
//    [[[WINVAppManager sharedInstance] serviceWithProtocol:@protocol(WINCarPlayVAppProtocol)] application:application didConnectCarInterfaceController:interfaceController toWindow:window];
//}
//
//- (void)application:(UIApplication *)application didDisconnectCarInterfaceController:(CPInterfaceController *)interfaceController fromWindow:(CPWindow *)window
//API_AVAILABLE(ios(12.0))
//{
//    [[[WINVAppManager sharedInstance] serviceWithProtocol:@protocol(WINCarPlayVAppProtocol)] application:application didDisconnectCarInterfaceController:interfaceController fromWindow:window];
//}
//
//- (void)application:(UIApplication *)application didSelectNavigationAlert:(CPNavigationAlert *)navigationAlert
//API_AVAILABLE(ios(12.0))
//{
//    [[[WINVAppManager sharedInstance] serviceWithProtocol:@protocol(WINCarPlayVAppProtocol)] application:application didSelectNavigationAlert:navigationAlert];
//}
//
//- (void)application:(UIApplication *)application didSelectManeuver:(CPManeuver *)maneuver
//API_AVAILABLE(ios(12.0))
//{
//    [[[WINVAppManager sharedInstance] serviceWithProtocol:@protocol(WINCarPlayVAppProtocol)] application:application didSelectManeuver:maneuver];
//}

#pragma mark - app search

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray *))restorationHandler
{
    return [[WINVAppManager sharedInstance] application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
}

#pragma mark - 推送、scheme调用
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [[WINVAppManager sharedInstance] application:application handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[WINVAppManager sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [[WINVAppManager sharedInstance] application:app openURL:url options:options];
}

@end
