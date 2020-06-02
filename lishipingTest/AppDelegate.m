//
//  AppDelegate.m
//  lishipingTest
//
//  Created by shiping1 on 2017/11/2.
//  Copyright © 2017年 shiping1. All rights reserved.
//

#import "AppDelegate.h"
#import "SPAppManager.h"
#import "FLEXManager.h"
#import "LLDebug.h"





@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - 生命周期
//说明：当程序载入后执行
//当应用程序启动时（不包括已在后台的情况下转到前台），调用此回调。launchOptions是启动参数，假如用户通过点击push通知启动的应用，这个参数里会存储一些push通知的信息。
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /*
     下面是这个类的一些属性：
     
     1.设置icon上的数字图标
     
     //设置主界面icon上的数字图标，在2.0中引进，缺省为0
     
     [UIApplicationsharedApplication].applicationIconBadgeNumber= 4;
     
     2.设置摇动手势的时候，是否支持redo,undo操作
     
     //摇动手势，是否支持redo undo操作。
     
     //3.0以后引进，缺省YES
     
     [UIApplicationsharedApplication].applicationSupportsShakeToEdit=YES;
     
     3.判断程序运行状态
     
     //判断程序运行状态，在2.0以后引入
     
     
     UIApplicationStateActive,
     
     UIApplicationStateInactive,
     
     UIApplicationStateBackground
     
     
     if([UIApplicationsharedApplication].applicationState==UIApplicationStateInactive){
     
     NSLog(@"程序在运行状态");
     
     }
     
     4.阻止屏幕变暗进入休眠状态
     
     //阻止屏幕变暗，慎重使用,缺省为no 2.0
     
     [UIApplicationsharedApplication].idleTimerDisabled=YES;
     
     慎重使用本功能，因为非常耗电。
     
     5.显示联网状态
     
     //显示联网标记2.0
     
     [UIApplicationsharedApplication].networkActivityIndicatorVisible=YES;
     
     */

    [[LLDebugTool sharedTool] startWorking];

    LSP_SUPER_LOG(@"太阳神超级阿波罗日志系统==%@",@"李世平");

       //产生Log
//    DDLogDebug(string);
//       DDLogVerbose(@"Verbose李世平");
//       DDLogDebug(@"Debug李世平");
//       DDLogInfo(@"Info李世平");
//       DDLogWarn(@"Warn李世平ad发送到发送到发送到发送到发送到发送到发送到发送到发送到发送到发送到发士大夫士大夫第三方撒的发生的");
//       DDLogError(@"Error李世平");
    
//    NSArray *array = @[@5,@7,@9,@3,@10,@15,@25,@2,@6];
//    NSUInteger max =  [self max:array];
//    NSLog(@"max=%lu",(unsigned long)max);
    return [[SPAppManager sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
}

//说明：当应用程序将要入非活动状态执行，在此期间，应用程序不接收消息或事件，比如来电话了
//当应用从活动状态主动到非活动状态的应用程序时会调用这个方法。这可导致产生某些类型的临时中断（如传入电话呼叫或SMS消息）。或者当用户退出应用程序，它开始过渡到的背景状态。使用此方法可以暂停正在进行的任务，禁用定时器，降低OpenGL ES的帧速率。游戏应该使用这种方法来暂停游戏。调用时机可能有以下几种：锁屏，按HOME键，下接状态栏，双击HOME键弹出低栏，等情况。
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    [[SPAppManager sharedInstance] applicationWillResignActive:application];
}

//说明：当程序被推送到后台的时候调用。所以要设置后台继续运行，则在这个函数里面设置即可
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[SPAppManager sharedInstance] applicationDidEnterBackground:application];
}

//说明：当程序从后台将要重新回到前台时候调用，这个刚好跟上面的那个方法相反。
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [[SPAppManager sharedInstance] applicationWillEnterForeground:application];
}


//说明：当应用程序进入活动状态执行
//当应用程序全新启动，或者在后台转到前台，完全激活时，都会调用这个方法。如果应用程序是以前运行在后台，这时可以选择刷新用户界面。
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[SPAppManager sharedInstance] applicationDidBecomeActive:application];
}

//说明：当程序将要退出是被调用，通常是用来保存数据和一些退出前的清理工作。这个需要要设置UIApplicationExitsOnSuspend的键值。
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[SPAppManager sharedInstance] applicationWillTerminate:application];
}



#pragma mark - 接收到远端和本地通知
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [[SPAppManager sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    [[SPAppManager sharedInstance] application:application didFailToRegisterForRemoteNotificationsWithError:error];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [[SPAppManager sharedInstance] application:application didReceiveRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    [[SPAppManager sharedInstance] application:application didReceiveLocalNotification:notification];
}

#pragma mark - 接收scheme，打开scheme，handle open url
/*当前APP被其他APP或者web,或者内部以URL形式打开的处理等打开唤醒的时候，通过该类处理消息*/
//说明：当通过url执行
// NS_DEPRECATED_IOS(2_0, 9_0, "Please use application:openURL:options:") __TVOS_PROHIBITED
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [[SPAppManager sharedInstance] application:application handleOpenURL:url];
}

//当用户通过其它应用启动本应用时，会回调这个方法，url参数是其它应用调用openURL:方法时传过来的。
// NS_DEPRECATED_IOS(4_2, 9_0, "Please use application:openURL:options:") __TVOS_PROHIBITED
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation
{
    return [[SPAppManager sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    return [[SPAppManager sharedInstance] application:app openURL:url options:options];
}

#pragma mark - 3D touch
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    [[SPAppManager sharedInstance] application:application performActionForShortcutItem:shortcutItem completionHandler:completionHandler];
}

#pragma mark - app search

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRestoring>> * __nullable restorableObjects))restorationHandler
{
    return [[SPAppManager sharedInstance] application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
}

#pragma mark - 后台运行任务
- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler
{
    [[SPAppManager sharedInstance] application:application handleEventsForBackgroundURLSession:identifier completionHandler:completionHandler];
}



#pragma mark - 接收内存警告
//说明：iPhone设备只有有限的内存，如果为应用程序分配了太多内存操作系统会终止应用程序的运行，在终止前会执行这个方法，通常可以在这里进行内存清理工作防止程序被终止
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    
}

#pragma mark - UI变化相关，横竖屏，手表，系统时间，状态栏方向变化，状态栏大小变化（接电话时候）
//横竖屏变化
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window  NS_AVAILABLE_IOS(6_0) __TVOS_PROHIBITED
{
    return [[SPAppManager sharedInstance] application:application supportedInterfaceOrientationsForWindow:window];
}

- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void(^)(NSDictionary *replyInfo))reply{
    [[SPAppManager sharedInstance] application:application handleWatchKitExtensionRequest:userInfo reply:reply];
}

//说明：当系统时间发生改变时执行
- (void)applicationSignificantTimeChange:(UIApplication*)application
{
    
}

//说明：当StatusBar框将要变化时执行
- (void)application:(UIApplication*)application willChangeStatusBarFrame:(CGRect)newStatusBarFrame
{
    
}

//说明：当StatusBar框方向将要变化时执行
- (void)application:(UIApplication*)application willChangeStatusBarOrientation:
(UIInterfaceOrientation)newStatusBarOrientation
{
    
}

//说明：当StatusBar框方向变化完成后执行
- (void)application:(UIApplication*)application didChangeStatusBarOrientation:(UIInterfaceOrientation)oldStatusBarOrientation
{
    
}


//-(NSInteger)max:(NSArray*)array
//{
//    int max = 0;
//    for (int i=0; i<array.count; i++) {
//        int x = array[i];
//        int y = array[i+1];
//        max = (y-x)>max?(y-x):max;
//    }
//    return max;
//}
-(NSInteger)max:(NSArray*)array
{
    NSUInteger max = 0;
    for (int i=0; i<array.count; i++) {
        int x = array[i];
        
        for (int m=0; m<=i+1; m++) {
            int y = array[m];
            max = (y-x)>max?(y-x):max;
        }
    }
    return max;
}
@end
