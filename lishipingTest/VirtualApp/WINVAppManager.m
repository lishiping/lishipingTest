//
//  WINVAppManager.m
//  Wing
//
//  Created by jixuhui on 2017/12/28.
//  Copyright © 2017年 AMAP. All rights reserved.
//

#import <CoreSpotlight/CoreSpotlight.h>
#import "WINVAppManager.h"
#import "WINVAppLifecycleProtocol.h"

//#import "NMMapViewController.h"
//#import "AMCommonConfigUtility.h"
//#import "AMNavigationController.h"
//#import "WINNotificationVAppProtocol.h"
//#import "NMCrashReporterUtility.h"
//#import "NMAppSearchUtility.h"
#import <objc/runtime.h>
#import <objc/message.h>
//#import "LTMLaunchCrashMonitor.h"
//#import "LTMScreenDefines.h"
//#import "LTMNetworkTrafficStatistics.h"

typedef NS_ENUM(NSUInteger, WINPriorityFlag) {
    WINPriorityFlagLaunch = 0,
    WINPriorityFlagMapFirstRender = 1
};

@interface WINVAppManager()
@property (nonatomic, strong) NSMutableDictionary *vAppClassCache;
@property (nonatomic, strong) NSMutableArray *appLifecycleVAppClassCache;
@property (nonatomic, strong) NSMutableArray *vappLifecycleVAppClassCache;

@property (nonatomic, strong) NSMutableArray *highOrderedLaunchArray;
@property (nonatomic, strong) NSMutableArray *lowOrderedLaunchArray;
@property (nonatomic, strong) NSMutableArray *orderedMapRenderArray;

@end

@implementation WINVAppManager

#pragma mark - lifecycle

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static WINVAppManager *_sharedInstance;

    dispatch_once(&onceToken, ^{
        _sharedInstance = [[WINVAppManager alloc] init];
    });
    
    return _sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _vAppClassCache = [[NSMutableDictionary alloc] init];
        _appLifecycleVAppClassCache = [[NSMutableArray alloc] init];
        _vappLifecycleVAppClassCache = [[NSMutableArray alloc] init];
        
        _highOrderedLaunchArray = [[NSMutableArray alloc] init];
        _lowOrderedLaunchArray = [[NSMutableArray alloc] init];
        _orderedMapRenderArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)registerVAppServiceClass:(Class)vAppClass protocol:(Protocol *)vAppProtocol
{
    [self.vAppClassCache setValue:vAppClass forKey:NSStringFromProtocol(vAppProtocol)];
    
}

- (void)registerVAppLifecycleWithVApp:(Class)vAppClass;
{
    if ([vAppClass conformsToProtocol:@protocol(WINVAppLifecycleProtocol)]) {
//        [self.vappLifecycleVAppClassCache safelyAddObject:vAppClass];
        [self addVAppClassOrderly:vAppClass];
    }else {
        NSAssert(0, @"%@没有遵循UIApplicationDelegate协议，无法完成AppLifecycle注册！", NSStringFromClass(vAppClass));
    }
}

- (void)registerAppLifecycleWithVApp:(Class)vAppClass
{
    if ([vAppClass conformsToProtocol:@protocol(UIApplicationDelegate)]) {
//        [self.appLifecycleVAppClassCache safelyAddObject:vAppClass];
    }else {
        NSAssert(0, @"%@没有遵循UIApplicationDelegate协议，无法完成AppLifecycle注册！", NSStringFromClass(vAppClass));
    }
}

- (id)serviceWithProtocol:(Protocol *)vAppProtocol
{
    Class vAppClass = [self.vAppClassCache valueForKey:NSStringFromProtocol(vAppProtocol)];
    return [vAppClass sharedInstance];
}

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    [[LTMNetworkTrafficStatistics shared] beginScene:kLTMNetworkTrafficStatisticsSceneLaunch info:nil];
//    if ([LTMLaunchCrashMonitor needChangeToSafeMode]) {
//        [LTMLaunchCrashMonitor showSafeModeView];
//        return YES;
//    } else {
//        [LTMLaunchCrashMonitor recordLaunchTime];
//    }
#ifdef NMPerformanceDebug
    [performanceTestTimeNodes addObject:[NSDate date]];
#endif

    //window加载之前
    for (Class vAppClass in self.highOrderedLaunchArray) {
        [vAppClass vAppLaunchWithOptions:launchOptions];
    }
#ifdef NMPerformanceDebug
    [performanceTestTimeNodes addObject:[NSDate date]];
#endif
    // Set the navigation controller as the window's root view controller and display.
    
//    //小程序代码注释
//    UIViewController *viewController = [NMMapViewController createMapViewController];
//    UIWindow *window = [[UIWindow alloc] initWithFrame:AMAP_SCREEN_BOUNDS];
//    [application delegate].window = window;
//
//    [AMCommonConfigUtility commonConfig].navigationController = [[AMNavigationController alloc] initWithRootViewController:viewController];
//    if([window respondsToSelector:@selector(setRootViewController:)]) {
//        window.rootViewController = [AMCommonConfigUtility commonConfig].navigationController;
//    } else {
//        [window addSubview:[AMCommonConfigUtility commonConfig].navigationController.view];
//    }
//
//    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
//    [AMCommonConfigUtility commonConfig].keyWindow = window;
//    [window makeKeyAndVisible];
#ifdef NMPerformanceDebug
    [performanceTestTimeNodes addObject:[NSDate date]];
#endif
    //window加载之后
    for (Class vAppClass in self.lowOrderedLaunchArray) {
        [vAppClass vAppLaunchWithOptions:launchOptions];
    }
#ifdef NMPerformanceDebug
    [performanceTestTimeNodes addObject:[NSDate date]];
#endif
    
    //map加载首帧之后
    
    // 第一次启动应用，延后执行的操作。
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(delayedTaskInFirstLaunch) name:NM_APP_RUN_DELAY_TASK_NOTIFICATION object:nil];
    
    //暂时移除watch部分逻辑
    //    Class nMAppleWatchUtility = objc_getClass("NMAppleWatchUtility");
    //    if (nMAppleWatchUtility) {
    //        objc_msgSend(nMAppleWatchUtility,@selector(shareInstance));
    //    }
    

    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    for (Class vAppClass in self.appLifecycleVAppClassCache) {
        WINVAppService *bundle = [vAppClass sharedInstance];
        
        if ([bundle respondsToSelector:_cmd]) {
            [(id<UIApplicationDelegate>)bundle applicationWillEnterForeground:application];
        }
    }
    
    for (Class vAppClass in self.vappLifecycleVAppClassCache) {
        if ([vAppClass respondsToSelector:@selector(vAppEnterForground)]) {
            [vAppClass vAppEnterForground];
        }
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
#ifdef NMPerformanceDebug
    [performanceTestTimeNodes addObject:[NSDate date]];
#endif
    for (Class vAppClass in self.appLifecycleVAppClassCache) {
        WINVAppService *bundle = [vAppClass sharedInstance];
        
        if ([bundle respondsToSelector:_cmd]) {
            [(id<UIApplicationDelegate>)bundle applicationDidBecomeActive:application];
        }
    }
#ifdef NMPerformanceDebug
    [performanceTestTimeNodes addObject:[NSDate date]];
#endif
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    for (Class vAppClass in self.appLifecycleVAppClassCache) {
        WINVAppService *bundle = [vAppClass sharedInstance];
        
        if ([bundle respondsToSelector:_cmd]) {
            [(id<UIApplicationDelegate>)bundle applicationWillResignActive:application];
        }
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    for (Class vAppClass in self.appLifecycleVAppClassCache) {
        WINVAppService *bundle = [vAppClass sharedInstance];
        
        if ([bundle respondsToSelector:_cmd]) {
            [(id<UIApplicationDelegate>)bundle applicationDidEnterBackground:application];
        }
    }
    
    for (Class vAppClass in self.vappLifecycleVAppClassCache) {
        if ([vAppClass respondsToSelector:@selector(vAppEnterBackground)]) {
            [vAppClass vAppEnterBackground];
        }
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    for (Class vAppClass in self.appLifecycleVAppClassCache) {
        WINVAppService *bundle = [vAppClass sharedInstance];
        
        if ([bundle respondsToSelector:_cmd]) {
            [(id<UIApplicationDelegate>)bundle applicationWillTerminate:application];
        }
    }
}

#pragma mark - 目前只有WINOldTaskVApp实现，可考虑实现统一方法接收方法名和参数

- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler
{
    for (Class vAppClass in self.appLifecycleVAppClassCache) {
        WINVAppService *bundle = [vAppClass sharedInstance];
        
        if ([bundle respondsToSelector:_cmd]) {
            [(id<UIApplicationDelegate>)bundle application:application handleEventsForBackgroundURLSession:identifier completionHandler:completionHandler];
        }
    }
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler NS_AVAILABLE_IOS(9_0)
{
//    if (![AMCommonConfigUtility commonConfig].hasAgreedPrivacyClause) {
//        completionHandler(NO);
//        return;
//    }
    
    for (Class vAppClass in self.appLifecycleVAppClassCache) {
        WINVAppService *bundle = [vAppClass sharedInstance];
        
        if ([bundle respondsToSelector:_cmd]) {
            [(id<UIApplicationDelegate>)bundle application:application performActionForShortcutItem:shortcutItem completionHandler:completionHandler];
        }
    }
}

#pragma mark - 需要抽到另外地方

#pragma mark UI相关
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
//    return [[AMCommonConfigUtility commonConfig].navigationController supportedInterfaceOrientations];
    
    return UIInterfaceOrientationMaskPortrait;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    id<WINNotificationVAppProtocol> provider = [[WINVAppManager sharedInstance] serviceWithProtocol:@protocol(WINNotificationVAppProtocol)];
//    [provider postDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
//    id<WINNotificationVAppProtocol> provider = [[WINVAppManager sharedInstance] serviceWithProtocol:@protocol(WINNotificationVAppProtocol)];
//    [provider receiveNotification:application didReceiveRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
//    id<WINNotificationVAppProtocol> provider = [[WINVAppManager sharedInstance] serviceWithProtocol:@protocol(WINNotificationVAppProtocol)];
//    [provider receiveNotification:application didReceiveLocalNotification:notification];
}

#pragma mark UI相关

- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void(^)(NSDictionary *replyInfo))reply{
    
//    [[NMCrashReporterUtility sharedCrashReporterUtility] wakeUpFromAppleWatch];
    
//    if ([NMMapViewController getNMMapViewControllerAppearStatus] == NMMapViewControllerAppearStatusNormal) {
//        [NMMapViewController setNMMapViewControllerAppearStatus:NMMapViewControllerAppearStatusHandleWatch];
//    }
//
    //暂时移除watch部分逻辑
//    Class nMAppleWatchUtility = objc_getClass("NMAppleWatchUtility");
//    if (nMAppleWatchUtility) {
//        id instance = ((id (*) (id, SEL))objc_msgSend)(nMAppleWatchUtility,@selector(shareInstance));
//        NSMethodSignature *signature = [instance methodSignatureForSelector:@selector(application:handleWatchKitExtensionRequest:reply:)];
//        NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];
//        [invocation setTarget:instance];
//        [invocation setSelector:@selector(application:handleWatchKitExtensionRequest:reply:)];
//        [invocation setArgument:&application atIndex:2];
//        [invocation setArgument:&userInfo atIndex:3];
//        [invocation setArgument:&reply atIndex:4];
//        [invocation invoke];
//    }
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray *))restorationHandler NS_AVAILABLE_IOS(8_0)
{
    if (@available(iOS 9.0, *)) {
        if ([userActivity.activityType isEqualToString:CSSearchableItemActionType]) {
            
            NSString *title = userActivity.title ? userActivity.title : @"";
            NSString * uniqueID = [[userActivity userInfo] objectForKey:@"kCSSearchableItemActivityIdentifier"];
            //如果title为空，从uniqueID获取，fix ios 10.0没有title的问题
            if ([title length] == 0) {
                //用.分割,用,分割关键词
                NSArray *uniqueIDlineArray = [uniqueID componentsSeparatedByString:@"."];
                title = [uniqueIDlineArray firstObject] ? [uniqueIDlineArray firstObject] : @"";
                title = [[title componentsSeparatedByString:@","] firstObject] ? [[title componentsSeparatedByString:@","] firstObject] : @"";
            }
            
//            NSString * url = [[NMAppSearchUtility appsearchUtility] schemeSearchTitle:title uniqueID:uniqueID];
//            [self application:[UIApplication sharedApplication] handleOpenURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
            
        } else if ([userActivity.activityType isEqualToString:@"NSUserActivityTypeBrowsingWeb"]) {
            NSURL *webUrl = userActivity.webpageURL;
            NSString *schemeString = nil;
            NSArray *ary = [[webUrl query] componentsSeparatedByString:@"&"];
            for(NSString *parts in ary) {
                NSArray *subAry = [parts componentsSeparatedByString:@"="];
                if (subAry.count == 0) {
                    continue;
                }
                
                NSString *key = [subAry objectAtIndex:0];
                NSString *value = @"";
                if (subAry.count >= 2) {
                    value = [subAry objectAtIndex:1];
                }
                
                if ([key isEqualToString:@"schema"]) {
//                    schemeString = [value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//                    [self application:[UIApplication sharedApplication] handleOpenURL:[NSString encodeURLWithString:schemeString]];
                    break;
                }
            }
        }
    } else {
        // Fallback on earlier versions
    }
    
    return YES;
}

#pragma mark - open URL

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [self curApplication:application openURL:url options:@{}];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSDictionary *options = nil;
    if (@available(iOS 9.0, *)) {
        if (sourceApplication) {
            options = @{UIApplicationOpenURLOptionsSourceApplicationKey:sourceApplication};
        }
        return [self curApplication:application openURL:url options:options];
    } else {
        // Fallback on earlier versions
        if (sourceApplication) {
            options = @{@"UIApplicationOpenURLOptionsSourceApplicationKey":sourceApplication};
        }
        return [self curApplication:application openURL:url options:options];
    }
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
//    if (![AMCommonConfigUtility commonConfig].hasAgreedPrivacyClause) {
//        return NO;
//    }
    
    return [self curApplication:app openURL:url options:options];
}

#pragma mark - private method

- (void)delayedTaskInFirstLaunch
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:NM_APP_RUN_DELAY_TASK_NOTIFICATION object:nil];

    for (Class vAppClass in self.orderedMapRenderArray) {
        [vAppClass vAppLaunchAfterMapFirstRender];
    }
}

- (void)addVAppClassOrderly:(Class)vAppClass
{
    if ([vAppClass respondsToSelector:@selector(vAppLaunchWithOptions:)]) {
        if ([vAppClass launchPriority] <= WINLaunchPriorityLow/2) {
            [self addVAppClass:vAppClass toArray:self.highOrderedLaunchArray priorityFlag:WINPriorityFlagLaunch];
        }else {
            [self addVAppClass:vAppClass toArray:self.lowOrderedLaunchArray priorityFlag:WINPriorityFlagLaunch];
        }
    }
    
    if ([vAppClass respondsToSelector:@selector(vAppLaunchAfterMapFirstRender)]) {
        [self addVAppClass:vAppClass toArray:self.orderedMapRenderArray priorityFlag:WINPriorityFlagMapFirstRender];
    }
}

- (void)addVAppClass:(Class)vAppClass toArray:(NSMutableArray *)mArray priorityFlag:(WINPriorityFlag)flag
{
    if ([mArray count] == 0) {
        [mArray addObject:vAppClass];
    }else {
        WINLaunchPriority vAppProiority = [self priorityOfVAppClass:vAppClass flag:flag];
        for (NSInteger j = [mArray count] - 1; j >= 0; j--) {
            Class lastClass = [mArray objectAtIndex:j];
            
            if (vAppProiority >= [self priorityOfVAppClass:lastClass flag:flag]) {
                [mArray insertObject:vAppClass atIndex:j+1];
                break;
            }else {
                if (j == 0) {
                    [mArray insertObject:vAppClass atIndex:j];
                }else {
                    continue;
                }
            }
        }
    }
}

- (WINLaunchPriority)priorityOfVAppClass:(Class)class flag:(WINPriorityFlag)flag
{
    switch (flag) {
        case WINPriorityFlagLaunch:
            return [class launchPriority];
            break;
        case WINPriorityFlagMapFirstRender:
            return [class mapFirstRenderPriority];
            break;
            
        default:
            return WINLaunchPriorityLow;
            break;
    }
}

- (BOOL)curApplication:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{    
//    if (!self.outsideSchemeControl) {
//        self.outsideSchemeControl = [[WINOutsideSchemeControl alloc] init];
//    }
//
//    if (@available(iOS 9.0, *)) {
//        return [self.outsideSchemeControl openURL:url sourceApplication:[options valueForKey:UIApplicationOpenURLOptionsSourceApplicationKey] annotation:[options valueForKey:UIApplicationOpenURLOptionsAnnotationKey]];
//    } else {
//        // Fallback on earlier versions
//        return [self.outsideSchemeControl openURL:url sourceApplication:[options valueForKey:@"UIApplicationOpenURLOptionsSourceApplicationKey"] annotation:[options valueForKey:@"UIApplicationOpenURLOptionsAnnotationKey"]];
//    }
    
    return NO;
}

@end



