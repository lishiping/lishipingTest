//
//  SPAppManager.m
//  Wing
//
//  Created by lishiping on 2017/12/28.
//  Copyright © 2017年 AMAP. All rights reserved.
//

#import <CoreSpotlight/CoreSpotlight.h>
#import "SPAppManager.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface SPAppManager()
@property (nonatomic, strong) NSMutableArray *appLifecycleVAppClassCache;
@property (nonatomic, strong) NSMutableArray *highOrderedLaunchArray;
@property (nonatomic, strong) NSMutableArray *lowOrderedLaunchArray;

@end

@implementation SPAppManager

#pragma mark - lifecycle

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static SPAppManager *_sharedInstance;

    dispatch_once(&onceToken, ^{
        _sharedInstance = [[SPAppManager alloc] init];
    });
    
    return _sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _appLifecycleVAppClassCache = [[NSMutableArray alloc] init];
        _highOrderedLaunchArray = [[NSMutableArray alloc] init];
        _lowOrderedLaunchArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)registerAppLifecycleWithVApp:(Class)appClass launchPriority:(SPLaunchPriority)launchPriority
{
    if ([appClass conformsToProtocol:@protocol(UIApplicationDelegate)])
    {
        [self.appLifecycleVAppClassCache addObject:appClass];
        
        if (launchPriority >= SPLaunchPriorityHigh)
        {
            [self.highOrderedLaunchArray addObject:appClass];
        }
        else
        {
            [self.lowOrderedLaunchArray addObject:appClass];
        }
    }
    else
    {
        NSAssert(0, @"%@没有遵循UIApplicationDelegate协议，无法完成AppLifecycle注册！", NSStringFromClass(appClass));
    }
}

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //window加载之前
    for (Class vAppClass in self.highOrderedLaunchArray) {
        SPAppDelegate *bundle = [vAppClass sharedInstance];
        
        if ([bundle respondsToSelector:_cmd]) {
            [(id<UIApplicationDelegate>)bundle application:application didFinishLaunchingWithOptions:launchOptions];
        }
    }

    //window加载之后
    for (Class vAppClass in self.lowOrderedLaunchArray) {
        SPAppDelegate *bundle = [vAppClass sharedInstance];
        
        if ([bundle respondsToSelector:_cmd]) {
            [(id<UIApplicationDelegate>)bundle application:application didFinishLaunchingWithOptions:launchOptions];
        }
    }

    //    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //    [application delegate].window = window;
    //    [window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    for (Class vAppClass in self.appLifecycleVAppClassCache) {
        SPAppDelegate *bundle = [vAppClass sharedInstance];
        
        if ([bundle respondsToSelector:_cmd]) {
            [(id<UIApplicationDelegate>)bundle applicationWillEnterForeground:application];
        }
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    for (Class vAppClass in self.appLifecycleVAppClassCache) {
        SPAppDelegate *bundle = [vAppClass sharedInstance];
        
        if ([bundle respondsToSelector:_cmd]) {
            [(id<UIApplicationDelegate>)bundle applicationDidBecomeActive:application];
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    for (Class vAppClass in self.appLifecycleVAppClassCache) {
        SPAppDelegate *bundle = [vAppClass sharedInstance];
        
        if ([bundle respondsToSelector:_cmd]) {
            [(id<UIApplicationDelegate>)bundle applicationWillResignActive:application];
        }
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    for (Class vAppClass in self.appLifecycleVAppClassCache) {
        SPAppDelegate *bundle = [vAppClass sharedInstance];
        
        if ([bundle respondsToSelector:_cmd]) {
            [(id<UIApplicationDelegate>)bundle applicationDidEnterBackground:application];
        }
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    for (Class vAppClass in self.appLifecycleVAppClassCache) {
        SPAppDelegate *bundle = [vAppClass sharedInstance];
        
        if ([bundle respondsToSelector:_cmd]) {
            [(id<UIApplicationDelegate>)bundle applicationWillTerminate:application];
        }
    }
}

#pragma mark - 接收到远端和本地通知
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    for (Class vAppClass in self.appLifecycleVAppClassCache)
    {
        SPAppDelegate *bundle = [vAppClass sharedInstance];
        
        if ([bundle respondsToSelector:_cmd])
        {
            [(id<UIApplicationDelegate>)bundle application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
        }
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    for (Class vAppClass in self.appLifecycleVAppClassCache)
    {
        SPAppDelegate *bundle = [vAppClass sharedInstance];
        
        if ([bundle respondsToSelector:_cmd])
        {
            [(id<UIApplicationDelegate>)bundle application:application didFailToRegisterForRemoteNotificationsWithError:error];
        }
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    for (Class vAppClass in self.appLifecycleVAppClassCache)
    {
        SPAppDelegate *bundle = [vAppClass sharedInstance];
        
        if ([bundle respondsToSelector:_cmd])
        {
            [(id<UIApplicationDelegate>)bundle application:application didReceiveRemoteNotification:userInfo];
        }
    }
    [[SPAppManager sharedInstance] application:application didReceiveRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    for (Class vAppClass in self.appLifecycleVAppClassCache)
    {
        SPAppDelegate *bundle = [vAppClass sharedInstance];
        
        if ([bundle respondsToSelector:_cmd])
        {
            [(id<UIApplicationDelegate>)bundle application:application didReceiveLocalNotification:notification];
        }
    }
}

#pragma mark - 接收scheme，打开scheme，handle open url
/*当前APP被其他APP或者web,或者内部以URL形式打开的处理等打开唤醒的时候，通过该类处理消息*/
//说明：当通过url执行
//NS_DEPRECATED_IOS(2_0, 9_0, "Please use application:openURL:options:") __TVOS_PROHIBITED
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    for (Class vAppClass in self.appLifecycleVAppClassCache)
    {
        SPAppDelegate *bundle = [vAppClass sharedInstance];
        
        if ([bundle respondsToSelector:_cmd])
        {
        return  [(id<UIApplicationDelegate>)bundle application:application handleOpenURL:url];
        }
    }
    return NO;
}

//当用户通过其它应用启动本应用时，会回调这个方法，url参数是其它应用调用openURL:方法时传过来的。
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation
{
    for (Class vAppClass in self.appLifecycleVAppClassCache)
    {
        SPAppDelegate *bundle = [vAppClass sharedInstance];
        
        if ([bundle respondsToSelector:_cmd])
        {
            return  [(id<UIApplicationDelegate>)bundle application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
        }
    }
    return NO;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    for (Class vAppClass in self.appLifecycleVAppClassCache)
    {
        SPAppDelegate *bundle = [vAppClass sharedInstance];
        
        if ([bundle respondsToSelector:_cmd])
        {
            return  [(id<UIApplicationDelegate>)bundle application:app openURL:url options:options];
        }
    }
    return NO;
}

#pragma mark - 3D touch
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    for (Class vAppClass in self.appLifecycleVAppClassCache)
    {
        SPAppDelegate *bundle = [vAppClass sharedInstance];
        
        if ([bundle respondsToSelector:_cmd])
        {
            [(id<UIApplicationDelegate>)bundle application:application performActionForShortcutItem:shortcutItem completionHandler:completionHandler];
        }
    }
}

#pragma mark - app search
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRestoring>> * __nullable restorableObjects))restorationHandler
{
    for (Class vAppClass in self.appLifecycleVAppClassCache)
    {
        SPAppDelegate *bundle = [vAppClass sharedInstance];
        
        if ([bundle respondsToSelector:_cmd])
        {
            return  [(id<UIApplicationDelegate>)bundle application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
        }
    }
    return NO;
}

#pragma mark - 后台运行任务
- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler
{
    for (Class vAppClass in self.appLifecycleVAppClassCache) {
        SPAppDelegate *bundle = [vAppClass sharedInstance];
        
        if ([bundle respondsToSelector:_cmd]) {
            [(id<UIApplicationDelegate>)bundle application:application handleEventsForBackgroundURLSession:identifier completionHandler:completionHandler];
        }
    }
}

#pragma mark UI相关
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    for (Class vAppClass in self.appLifecycleVAppClassCache)
    {
        SPAppDelegate *bundle = [vAppClass sharedInstance];
        
        if ([bundle respondsToSelector:_cmd])
        {
            return  [(id<UIApplicationDelegate>)bundle application:application supportedInterfaceOrientationsForWindow:window];
        }
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void(^)(NSDictionary *replyInfo))reply{
}

@end



