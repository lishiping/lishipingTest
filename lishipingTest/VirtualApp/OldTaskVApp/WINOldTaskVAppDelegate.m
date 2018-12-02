////
////  WINOldTaskVAppDelegate.m
////  ankit
////
////  Created by jixuhui on 2018/1/26.
////
//
//#import "WINOldTaskVAppDelegate.h"
//#import "WINVAppManager.h"
////#import "WINRouterManager.h"
//
//#import "NMMapViewController.h"
//#import "NMManagerController.h"
//#import "WINNotificationVAppProtocol.h"
//#import "NMActionController.h"
//#import "AMCommonConfigUtility.h"
//#import "NMManagerFactory.h"
//#import "NMDownloaderUtility.h"
//#import "NMSchemeService.h"
//#import "NMAppSearchUtility.h"
//#import "NMSafeMethodUtility.h"
//#import "AMViewsNavigation.h"
//#import "NMCrashReporterUtility.h"
//#import <objc/runtime.h>
//#import <objc/message.h>
//
//#import <objc/runtime.h>
//#import "AJXEngine.h"
//#import "AJXBundlesUpdateUtil.h"
//#import "NMBehaviorService.h"
//
//#import "OnlineServicesDefine.h"
//#import "LTMCaribbeanUtility.h"
//
//#import <UMShare/UMShare.h>
//#import "NMAccountDefines.h"
//#import "WINOldTaskDefine.h"
//#import "NMNetworkReachability.h"
//#import "WINPerformanceDebugUtility.h"
//#import "LTMNetworkTrafficStatistics.h"
//#import <SecurityGuardSDK/Open/OpenSecurityGuardManager.h>
//
//
//@interface WINOldTaskVAppDelegate ()<UIApplicationDelegate>
//{
//    NSArray* _willResignActiveTasksPart;
//    NSArray* _didBecomeActiveTasksPart;
//    NSArray* _willTerminateTasksPart;
//    NSArray* _delayedTaskInFirstLaunchTasksPart;
//    NSArray* _doActionsBecomeActiveInBackgroundTasksPart;
//}
//
//@property (nonatomic, strong) NSArray *finishLaunchTasksPart1;
//@property (nonatomic, strong) NSArray *didEnterBackgroundTasksPart;
//@property (nonatomic, strong) NSArray *willEnterForegroundTasksPart;
//@property (nonatomic, assign) BOOL appStartForMoveMap;
//@property (nonatomic, assign) BOOL isApplicationFirstLaunch;  // 标识APP是否第一次启动
//
//@end
//
//@interface WINOldTaskVAppDelegate(InternalMethod)
//
//- (void)delayedTaskInFirstLaunch;
//- (void)doActionsBecomeActiveInBackground;
//
//@end
//
//@implementation WINOldTaskVAppDelegate
//
//#pragma mark -内部方法
//
//+ (void)load
//{
//    [[WINVAppManager sharedInstance] registerVAppLifecycleWithVApp:self];
//    [[WINVAppManager sharedInstance] registerAppLifecycleWithVApp:self];
//}
//
//+ (instancetype)sharedInstance
//{
//    static WINOldTaskVAppDelegate *_sharedInstance;
//    static dispatch_once_t onceToken;
//
//    dispatch_once(&onceToken, ^{
//        _sharedInstance = [[WINOldTaskVAppDelegate alloc] init];
//    });
//
//    return _sharedInstance;
//}
//
//#pragma mark - bundle lifecycle
//+ (WINLaunchPriority)launchPriority
//{
//    return WINLaunchPriorityHigh;
//}
//
//+ (void)vAppLaunchWithOptions:(NSDictionary *)launchOptions
//{
//    WINOldTaskVAppDelegate *obj = [self sharedInstance];
//
//    //启动时长埋点
//    [[[NMServiceCenter shareCenter] getProviderByService:@protocol(NMBehaviorClassService)] addAppStartLogWithType:@"进入页面"];
//
//
//    //网络保镖设置渠道号
//    [OpenSecurityGuardManager setGlobalUserData: @"channel"
//                                GlobalUserValue: [OnlineServicesDefine channelID]];
//
//    /* 打开调试日志 */
//    //    [[UMSocialManager defaultManager] openLog:YES];
//
//    /* 设置友盟appkey */
//    [[UMSocialManager defaultManager] setUmSocialAppkey:@"5a66e5518f4a9d6d0b0001a9"];
//    [obj configUSharePlatforms];
//    [obj confitUShareSettings];
//
//    [obj savePrevVersion];
//    [obj checkSourceWith:launchOptions];
//    [obj initTaskArray];
//    [NMNetworkReachability reachability];
//
//    obj.isApplicationFirstLaunch = YES;
//
//    obj.appStartForMoveMap = YES;
//
//    for (NSDictionary* actionItem in obj.finishLaunchTasksPart1) {
//        NSString* actionName = [actionItem objectForKey:NM_ACTION_ITEM_ID_KEY];
//        if ([[actionItem objectForKey:NM_ACTION_ITEM_STATIC_KEY] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
//            [[NMActionController actionClassByName:actionName] staticapplication:[UIApplication sharedApplication] didFinishLaunchingWithOptions:launchOptions];
//        } else {
//            [[NMActionController getActionByName:actionName]  application:[UIApplication sharedApplication] didFinishLaunchingWithOptions:launchOptions];
//        }
//    }
//}
//
//+ (WINLaunchPriority)mapFirstRenderPriority
//{
//    return WINLaunchPriorityHigh;
//}
//
//+ (void)vAppLaunchAfterMapFirstRender
//{
//    [[self sharedInstance] delayedTaskInFirstLaunch];
//}
//
//+ (void)vAppEnterForground
//{
//    WINOldTaskVAppDelegate *obj = [self sharedInstance];
//
//    for (NSDictionary* actionItem in obj.willEnterForegroundTasksPart) {
//        NSString* actionName = [actionItem objectForKey:NM_ACTION_ITEM_ID_KEY];
//        if ([[actionItem objectForKey:NM_ACTION_ITEM_STATIC_KEY] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
//            [[NMActionController actionClassByName:actionName] staticapplicationWillEnterForeground:[UIApplication sharedApplication]];
//        } else {
//            [[NMActionController getActionByName:actionName] applicationWillEnterForeground:[UIApplication sharedApplication]];
//        }
//    }
//
//    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FOREGROUND object:nil];
//}
//
//+ (void)vAppEnterBackground
//{
//    WINOldTaskVAppDelegate *obj = [self sharedInstance];
//
//    for (NSDictionary* actionItem in obj.didEnterBackgroundTasksPart) {
//        NSString* actionName = [actionItem objectForKey:NM_ACTION_ITEM_ID_KEY];
//        if ([[actionItem objectForKey:NM_ACTION_ITEM_STATIC_KEY] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
//            [[NMActionController actionClassByName:actionName] staticapplicationDidEnterBackground:[UIApplication sharedApplication]];
//        } else {
//            [[NMActionController getActionByName:actionName]  applicationDidEnterBackground:[UIApplication sharedApplication]];
//        }
//    }
//
//    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_BACKGROUND object:nil];
//}
//
//#pragma mark Application lifecycle
//
//- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler
//{
//    [[NMDownloaderUtility shareInstance] addCompletionHandler:completionHandler forSession:identifier];
//}
//
//- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler NS_AVAILABLE_IOS(9_0)
//{
//    NSDictionary * userInfo = shortcutItem.userInfo;
//    NSString * urlString = [userInfo objectForKey:@"url"];
//    NSURL *url = [NSURL URLWithString:urlString];
//    BOOL success = NO;
//    if (url) {
//        NM_CLANG_WARNING_IGNORE_BEGIN(-Wnonnull)
//        success = [[WINVAppManager sharedInstance] application:application  openURL:url sourceApplication:AMAP_SCHEME_SOURCE_SHORTCUT annotation:nil];
//        NM_CLANG_WARNING_IGNORE_END
//    }
//    completionHandler(success);
//}
//
//- (void)applicationWillResignActive:(UIApplication *)application
//{
//    _isApplicationFirstLaunch = NO;
//
//    [[AMCommonConfigUtility commonConfig] setApplicationActive:NO];
//
//    for (NSDictionary* actionItem in _willResignActiveTasksPart) {
//        NSString* actionName = [actionItem objectForKey:NM_ACTION_ITEM_ID_KEY];
//        if ([[actionItem objectForKey:NM_ACTION_ITEM_STATIC_KEY] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
//            [[NMActionController actionClassByName:actionName] staticapplicationWillResignActive:application];
//        } else {
//            [[NMActionController getActionByName:actionName]  applicationWillResignActive:application];
//        }
//    }
//
//}
//
//- (void)applicationDidBecomeActive:(UIApplication *)application
//{
//    NMMapViewControllerAppearStatus status = [NMMapViewController getNMMapViewControllerAppearStatus];
//    if (status == NMMapViewControllerAppearStatusHandleWatch ||
//        status == NMMapViewControllerAppearStatusHandleBackgroundURLSession) {
//        [NMMapViewController setNMMapViewControllerAppearStatus:NMMapViewControllerAppearStatusBecomeActive];
//        [self performSelectorOnMainThread:@selector(nmmapViewControllerDidAppear) withObject:nil waitUntilDone:YES];
//    }
//
//    [[AMCommonConfigUtility commonConfig] setApplicationActive:YES];
//
//    if (![[AMCommonConfigUtility commonConfig] loadFromScheme] && _appStartForMoveMap) {
//        [[AMCommonConfigUtility commonConfig] setNeedMoveMap:YES];
//    }
//
//    _appStartForMoveMap = NO;
//
//    for (NSDictionary* actionItem in _didBecomeActiveTasksPart) {
//        NSString* actionName = [actionItem objectForKey:NM_ACTION_ITEM_ID_KEY];
//        BOOL firstLaunchCheck = [[actionItem objectForKey:NM_ACTION_ITEM_FIRSTLAUNCH_KEY] boolValue];
//        if (firstLaunchCheck && _isApplicationFirstLaunch) {
//            continue;
//        }
//
//        if ([[actionItem objectForKey:NM_ACTION_ITEM_STATIC_KEY] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
//            [[NMActionController actionClassByName:actionName] staticapplicationDidBecomeActive:application];
//        } else {
//            [[NMActionController getActionByName:actionName]  applicationDidBecomeActive:application];
//        }
//    }
//
//    if (!_isApplicationFirstLaunch) {
//        [self performSelectorInBackground:@selector(doActionsBecomeActiveInBackground) withObject:nil];
//    }
//
//    [[AMCommonConfigUtility commonConfig] setLoadFromScheme:NO];
//}
//
//- (void)applicationWillTerminate:(UIApplication *)application {
//    for (NSDictionary* actionItem in _willTerminateTasksPart) {
//        NSString* actionName = [actionItem objectForKey:NM_ACTION_ITEM_ID_KEY];
//        if ([[actionItem objectForKey:NM_ACTION_ITEM_STATIC_KEY] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
//            [[NMActionController actionClassByName:actionName] staticapplicationWillTerminate:application];
//        } else {
//            [[NMActionController getActionByName:actionName]  applicationWillTerminate:application];
//        }
//    }
//}
//
//- (void)checkSourceWith:(NSDictionary *)launchOptions{
//    NSURL *url = launchOptions[UIApplicationLaunchOptionsURLKey];
//    if ([url isKindOfClass:[NSURL class]] &&
//        ([[url scheme] isEqualToString:@"iosamap"] ||
//         [[url scheme] isEqualToString:@"amapuri"] ||
//         [[url scheme] isEqualToString:@"scme2017122201358023c49cf2"] ||
//         [[url scheme] isEqualToString:@"scme20171218009637581187f3"] ||
//         launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey] ||
//         launchOptions[UIApplicationLaunchOptionsLocalNotificationKey])
//        ){
//        [[AMCommonConfigUtility commonConfig] setLoadFromScheme:YES];
//    }
//
//    NSString *uriStr = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey][@"actionUri"];
//    if (uriStr.length) {
//        url = [NSURL URLWithString:uriStr];
//    }
//    if ([[url scheme] isEqualToString:@"iosamap"] || [[url scheme] isEqualToString:@"amapuri"]) {
//        [[AMCommonConfigUtility commonConfig] setLoadFromScheme:YES];
//    }
//}
//
//- (void)savePrevVersion
//{
//    if ([AMCommonConfigUtility commonConfig].lastVersionInfo != [OnlineServicesDefine versionInfo]) {
//        [AMCommonConfigUtility commonConfig].prevVersion = [AMCommonConfigUtility commonConfig].lastVersionInfo;
//    }
//}
//
//#pragma mark - private method
//
//- (void)initTaskArray
//{
//    if (!_finishLaunchTasksPart1) {
//        _finishLaunchTasksPart1 = @[
//                                    @{NM_ACTION_ITEM_ID_KEY:@"NMCrashReporterUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                    @{NM_ACTION_ITEM_ID_KEY:@"LTMAJXEngine", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                    @{NM_ACTION_ITEM_ID_KEY:@"AJXBundlesUpdateUtil", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                    @{NM_ACTION_ITEM_ID_KEY:@"NM3DViewAdapter", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                    @{NM_ACTION_ITEM_ID_KEY:@"LTMADIUUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                    @{NM_ACTION_ITEM_ID_KEY:@"NMAE8Utility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                    @{NM_ACTION_ITEM_ID_KEY:@"NMCityInfoUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                    @{NM_ACTION_ITEM_ID_KEY:@"NMSafeMethodUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                    @{NM_ACTION_ITEM_ID_KEY:@"NMDebugLogManager", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//#ifdef DEBUG
//                                    @{NM_ACTION_ITEM_ID_KEY:@"NMAssertUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//#endif
//                                    @{NM_ACTION_ITEM_ID_KEY:@"NMBehaviorManager", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                    @{NM_ACTION_ITEM_ID_KEY:@"LTMCaribbeanUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                    @{NM_ACTION_ITEM_ID_KEY:@"NMACCSUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                    @{NM_ACTION_ITEM_ID_KEY:@"NMHFUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                    @{NM_ACTION_ITEM_ID_KEY:@"LTMLotusPoolUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                    @{NM_ACTION_ITEM_ID_KEY:@"NMHtml5Manager", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                    @{NM_ACTION_ITEM_ID_KEY:@"AMCommonConfigUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                    @{NM_ACTION_ITEM_ID_KEY:@"AMViewsNavigation", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                    @{NM_ACTION_ITEM_ID_KEY:@"NMDownloaderUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                    @{NM_ACTION_ITEM_ID_KEY:@"LTMJsAuthorizeUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                    @{NM_ACTION_ITEM_ID_KEY:@"LTMAGroupCoordinatorUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                    @{NM_ACTION_ITEM_ID_KEY:@"NMASMUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                    @{NM_ACTION_ITEM_ID_KEY:@"NMFrequentLocationsUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                    @{NM_ACTION_ITEM_ID_KEY:@"NMFenceUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                    @{NM_ACTION_ITEM_ID_KEY:@"NMModuleDownloadUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                    @{NM_ACTION_ITEM_ID_KEY:@"LTMShareBikeManager", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]}
//                                    ];
//    }
//
//    if (!_willResignActiveTasksPart) {
//        _willResignActiveTasksPart = @[
//                                       @{NM_ACTION_ITEM_ID_KEY:@"NMMainMapManager", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                       @{NM_ACTION_ITEM_ID_KEY:@"NMCarNaviManager", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                       @{NM_ACTION_ITEM_ID_KEY:@"AMCommonConfigUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                       @{NM_ACTION_ITEM_ID_KEY:@"NMFlashManager", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                       @{NM_ACTION_ITEM_ID_KEY:@"AMLocationService", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                       @{NM_ACTION_ITEM_ID_KEY:@"NMFlashScreenCommercialManager", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                       @{NM_ACTION_ITEM_ID_KEY:@"NMCommuteUtility",NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]
//                                         },
//                                       @{NM_ACTION_ITEM_ID_KEY:@"NMVAManager",NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                       @{NM_ACTION_ITEM_ID_KEY:@"LTMMergeRequestUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                       @{NM_ACTION_ITEM_ID_KEY:@"NMWifiInfoReportUtility",NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                       @{NM_ACTION_ITEM_ID_KEY:@"NMMemoryWarningLogUtility",NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                       @{NM_ACTION_ITEM_ID_KEY:@"LTMOpenURLBaseUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                       @{NM_ACTION_ITEM_ID_KEY:@"LTMScreenRecorderUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]}
//                                       ];
//    }
//
//
//    if (!_didEnterBackgroundTasksPart) {
//        _didEnterBackgroundTasksPart = @[
//                                         @{NM_ACTION_ITEM_ID_KEY:@"NMMainMapManager", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                         @{NM_ACTION_ITEM_ID_KEY:@"NMMessageBoxManager", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                         @{NM_ACTION_ITEM_ID_KEY:@"AMCommonConfigUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                         @{NM_ACTION_ITEM_ID_KEY:@"NMCarNaviManager", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                         @{NM_ACTION_ITEM_ID_KEY:@"LTMFootNaviManager", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                         @{NM_ACTION_ITEM_ID_KEY:@"LTMFootRunManager", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                         @{NM_ACTION_ITEM_ID_KEY:@"LTMShareBikeManager",NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                         @{NM_ACTION_ITEM_ID_KEY:@"LTMRideRunManager", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                         @{NM_ACTION_ITEM_ID_KEY:@"LTMRideNaviManager", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                         @{NM_ACTION_ITEM_ID_KEY:@"NMBusNaviManager", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                         @{NM_ACTION_ITEM_ID_KEY:@"NMBehaviorManager", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                         @{NM_ACTION_ITEM_ID_KEY:@"LTMCaribbeanUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                         @{NM_ACTION_ITEM_ID_KEY:@"AJXBundlesUpdateUtil",NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                         @{NM_ACTION_ITEM_ID_KEY:@"LTMAGroupCoordinatorUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                         @{NM_ACTION_ITEM_ID_KEY:@"NMCloudConfigUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                         @{NM_ACTION_ITEM_ID_KEY:@"LTMAuthorityLimitUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]}
//                                         ];
//    }
//
//
//    if (!_didBecomeActiveTasksPart) {
//        _didBecomeActiveTasksPart = @[
//                                      @{NM_ACTION_ITEM_ID_KEY:@"NMCrashReporterUtility", NM_ACTION_ITEM_FIRSTLAUNCH_KEY:[NSNumber numberWithBool:NO],NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                      @{NM_ACTION_ITEM_ID_KEY:@"AMCommonConfigUtility", NM_ACTION_ITEM_FIRSTLAUNCH_KEY:[NSNumber numberWithBool:NO],NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                      @{NM_ACTION_ITEM_ID_KEY:@"NMEnergyUtility", NM_ACTION_ITEM_FIRSTLAUNCH_KEY:[NSNumber numberWithBool:YES],NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                       @{NM_ACTION_ITEM_ID_KEY:@"NMMainMapManager", NM_ACTION_ITEM_FIRSTLAUNCH_KEY:[NSNumber numberWithBool:NO],NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                      @{NM_ACTION_ITEM_ID_KEY:@"LTMFootNaviManager", NM_ACTION_ITEM_FIRSTLAUNCH_KEY:[NSNumber numberWithBool:NO],NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                      @{NM_ACTION_ITEM_ID_KEY:@"LTMFootRunManager", NM_ACTION_ITEM_FIRSTLAUNCH_KEY:[NSNumber numberWithBool:NO],NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                      @{NM_ACTION_ITEM_ID_KEY:@"LTMShareBikeManager", NM_ACTION_ITEM_FIRSTLAUNCH_KEY:[NSNumber numberWithBool:NO],NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                      @{NM_ACTION_ITEM_ID_KEY:@"LTMRideRunManager", NM_ACTION_ITEM_FIRSTLAUNCH_KEY:[NSNumber numberWithBool:NO],NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                      @{NM_ACTION_ITEM_ID_KEY:@"LTMRideNaviManager", NM_ACTION_ITEM_FIRSTLAUNCH_KEY:[NSNumber numberWithBool:NO],NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                      @{NM_ACTION_ITEM_ID_KEY:@"NMBusNaviManager", NM_ACTION_ITEM_FIRSTLAUNCH_KEY:[NSNumber numberWithBool:NO],NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                      @{NM_ACTION_ITEM_ID_KEY:@"LTMShareBikeScanQRCodeManager", NM_ACTION_ITEM_FIRSTLAUNCH_KEY:[NSNumber numberWithBool:NO],NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                      @{NM_ACTION_ITEM_ID_KEY:@"NMCarNaviManager", NM_ACTION_ITEM_FIRSTLAUNCH_KEY:[NSNumber numberWithBool:NO],NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                      @{NM_ACTION_ITEM_ID_KEY:@"AMLocationService", NM_ACTION_ITEM_FIRSTLAUNCH_KEY:[NSNumber numberWithBool:YES],NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                      @{NM_ACTION_ITEM_ID_KEY:@"NMFlashManager", NM_ACTION_ITEM_FIRSTLAUNCH_KEY:[NSNumber numberWithBool:NO],NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                      @{NM_ACTION_ITEM_ID_KEY:@"NMFlashScreenCommercialManager", NM_ACTION_ITEM_FIRSTLAUNCH_KEY:[NSNumber numberWithBool:NO],NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                      @{NM_ACTION_ITEM_ID_KEY:@"NMBehaviorManager", NM_ACTION_ITEM_FIRSTLAUNCH_KEY:[NSNumber numberWithBool:NO],NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                      @{NM_ACTION_ITEM_ID_KEY:@"LTMCaribbeanUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                      @{NM_ACTION_ITEM_ID_KEY:@"NMScoreManager", NM_ACTION_ITEM_FIRSTLAUNCH_KEY:[NSNumber numberWithBool:NO],NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                      @{NM_ACTION_ITEM_ID_KEY:@"NMMessageBoxManager", NM_ACTION_ITEM_FIRSTLAUNCH_KEY:[NSNumber numberWithBool:YES],NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                      @{NM_ACTION_ITEM_ID_KEY:@"NMTouristManager", NM_ACTION_ITEM_FIRSTLAUNCH_KEY:[NSNumber numberWithBool:YES],NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                      @{NM_ACTION_ITEM_ID_KEY:@"NMAutoRequestUtility", NM_ACTION_ITEM_FIRSTLAUNCH_KEY:[NSNumber numberWithBool:YES],NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                      @{NM_ACTION_ITEM_ID_KEY:@"NMPasteboardObserverManager", NM_ACTION_ITEM_FIRSTLAUNCH_KEY:[NSNumber numberWithBool:YES],NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                      @{NM_ACTION_ITEM_ID_KEY:@"NMDynamicLayerUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                      @{NM_ACTION_ITEM_ID_KEY:@"LTMAGroupCoordinatorUtility", NM_ACTION_ITEM_FIRSTLAUNCH_KEY:[NSNumber numberWithBool:YES],NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                      @{NM_ACTION_ITEM_ID_KEY:@"NMCarConnectionUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                      @{NM_ACTION_ITEM_ID_KEY:@"LTMMergeRequestUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                      @{NM_ACTION_ITEM_ID_KEY:@"NMCommuteUtility",NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                      @{NM_ACTION_ITEM_ID_KEY:@"NMMonitorUtility",NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                      @{NM_ACTION_ITEM_ID_KEY:@"NMVAManager",NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                      @{NM_ACTION_ITEM_ID_KEY:@"NMWifiInfoReportUtility",NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                      @{NM_ACTION_ITEM_ID_KEY:@"LTMLotusPoolUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                      @{NM_ACTION_ITEM_ID_KEY:@"AJXBundlesUpdateUtil", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                      @{NM_ACTION_ITEM_ID_KEY:@"LTMTakeTaxiCheckUncompleteOrderUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},//启动监测不需要创建LTMTakeTaxiManager
//                                      @{NM_ACTION_ITEM_ID_KEY:@"LTMOrderCheckerUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                      @{NM_ACTION_ITEM_ID_KEY:@"LTMFreerideUnCompleteJourneyUntility",NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                      @{NM_ACTION_ITEM_ID_KEY:@"LTMAuthorityLimitUtility",NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]}
//
//                                      ];
//    }
//
//
//    if (!_willTerminateTasksPart) {
//        _willTerminateTasksPart = @[@{NM_ACTION_ITEM_ID_KEY:@"AMCommonConfigUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                    @{NM_ACTION_ITEM_ID_KEY:@"AMLocalNotificationUtil", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                    ];
//    }
//
//
//    if (!_delayedTaskInFirstLaunchTasksPart) {
//        _delayedTaskInFirstLaunchTasksPart = @[
//                                               @{NM_ACTION_ITEM_ID_KEY:@"NMMessageBoxManager", NM_ACTION_ITEM_FIRSTLAUNCH_KEY:[NSNumber numberWithBool:YES],NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
////                                               @{NM_ACTION_ITEM_ID_KEY:@"NMAccountManager", NM_ACTION_ITEM_FIRSTLAUNCH_KEY:[NSNumber numberWithBool:NO],NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//
//                                               @{NM_ACTION_ITEM_ID_KEY:@"NMAutoRequestUtility", NM_ACTION_ITEM_FIRSTLAUNCH_KEY:[NSNumber numberWithBool:NO], NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//
//                                               @{NM_ACTION_ITEM_ID_KEY:@"NMBehaviorManager", NM_ACTION_ITEM_FIRSTLAUNCH_KEY:[NSNumber numberWithBool:NO],NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                               @{NM_ACTION_ITEM_ID_KEY:@"NMOfflineResourceManager",NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                               @{NM_ACTION_ITEM_ID_KEY:@"LTMGeneralSearchDataProvider",NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                               @{NM_ACTION_ITEM_ID_KEY:@"NMCloudSyncUtility",NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                               @{NM_ACTION_ITEM_ID_KEY:@"LTMFootNaviManager",NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                               @{NM_ACTION_ITEM_ID_KEY:@"LTMShareBikeManager",NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                               @{NM_ACTION_ITEM_ID_KEY:@"NMMainMapManager",NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                               @{NM_ACTION_ITEM_ID_KEY:@"NMHtml5Manager",NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                               //                                               @{NM_ACTION_ITEM_ID_KEY:@"NMVAManager",NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:NO]},
//                                               @{NM_ACTION_ITEM_ID_KEY:@"LTMMergeRequestUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                               @{NM_ACTION_ITEM_ID_KEY:@"GTDebugLuncher", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                               @{NM_ACTION_ITEM_ID_KEY:@"LTMTTSPlayerUtility", NM_ACTION_ITEM_FIRSTLAUNCH_KEY:[NSNumber numberWithBool:YES],NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                               @{NM_ACTION_ITEM_ID_KEY:@"NMMemoryWarningLogUtility",NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                               @{NM_ACTION_ITEM_ID_KEY:@"LTMLocationLogCollectCenter",NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                               @{NM_ACTION_ITEM_ID_KEY:@"LTMLotusPoolUtility",NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                               @{NM_ACTION_ITEM_ID_KEY:@"NMRetainCycleDetectionUtility",NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                               @{NM_ACTION_ITEM_ID_KEY:@"LTMLogCollectionUtility",NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//
//                                               @{NM_ACTION_ITEM_ID_KEY:@"NMAMapEyeUtility",NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                               @{NM_ACTION_ITEM_ID_KEY:@"LTMNaviOfflineResourceUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                               //依赖云同步数据，放云同步NMCloudSyncUtility之后
//                                               @{NM_ACTION_ITEM_ID_KEY:@"NMPathConfigUtility", NM_ACTION_ITEM_FIRSTLAUNCH_KEY:[NSNumber numberWithBool:NO], NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                               @{NM_ACTION_ITEM_ID_KEY:@"NMCloudConfigUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                               @{NM_ACTION_ITEM_ID_KEY:@"NMGuideViewManager", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                               @{NM_ACTION_ITEM_ID_KEY:@"LTMTTSResourceUpdateUtility",NM_ACTION_ITEM_FIRSTLAUNCH_KEY:[NSNumber numberWithBool:YES],NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                               @{NM_ACTION_ITEM_ID_KEY:@"LTM3DTouchUtility", NM_ACTION_ITEM_FIRSTLAUNCH_KEY:[NSNumber numberWithBool:NO], NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                               @{NM_ACTION_ITEM_ID_KEY:@"NMLoginCheckManager", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                               @{NM_ACTION_ITEM_ID_KEY:@"NMScoreManager", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                               @{NM_ACTION_ITEM_ID_KEY:@"LTMAuthorityLimitUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                               @{NM_ACTION_ITEM_ID_KEY:@"LTMMainMapTipsCenter", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]}
//                                               ];
//    }
//
//
//    if (!_willEnterForegroundTasksPart) {
//        _willEnterForegroundTasksPart = @[
//                                          @{NM_ACTION_ITEM_ID_KEY:@"NMMainMapManager"
//                                            ,NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                          @{NM_ACTION_ITEM_ID_KEY:@"NMShortcutManager", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                          @{NM_ACTION_ITEM_ID_KEY:@"NMCloudConfigUtility", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                          @{NM_ACTION_ITEM_ID_KEY:@"LTMMainMapTipsCenter", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]}
//                                          ];
//    }
//
//    if (!_doActionsBecomeActiveInBackgroundTasksPart) {
//        _doActionsBecomeActiveInBackgroundTasksPart = @[
//                                                        @{NM_ACTION_ITEM_ID_KEY:@"NMBehaviorManager", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                                        @{NM_ACTION_ITEM_ID_KEY:@"NMLoginCheckManager", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                                        @{NM_ACTION_ITEM_ID_KEY:@"NMHtml5Manager",NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
//                                                        ];
//    }
//}
//
//- (void)delayedTaskInFirstLaunch
//{
//    for (NSDictionary* actionItem in _delayedTaskInFirstLaunchTasksPart) {
//
//        NSString* actionName = [actionItem objectForKey:NM_ACTION_ITEM_ID_KEY];
//        BOOL checkFirstLaunch = [[actionItem objectForKey:NM_ACTION_ITEM_FIRSTLAUNCH_KEY] boolValue];
//
//        //如果非第一次在前台，并且当前条目需要检查第一次，则不在执行本条目
//        if (checkFirstLaunch && !_isApplicationFirstLaunch) {
//            continue;
//        }
//
//        if ([[actionItem objectForKey:NM_ACTION_ITEM_STATIC_KEY] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
//            [[NMActionController actionClassByName:actionName] staticdelayedTaskInFirstLaunch];
//        } else {
//            [[NMActionController getActionByName:actionName]  delayedTaskInFirstLaunch];
//        }
//    }
//
//    [self performSelectorInBackground:@selector(doActionsBecomeActiveInBackground) withObject:nil];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [[LTMNetworkTrafficStatistics shared] endScene:kLTMNetworkTrafficStatisticsSceneLaunch info:nil];
//    });
//
//}
//
//- (void)doActionsBecomeActiveInBackground
//{
//    for (NSDictionary* actionItem in _doActionsBecomeActiveInBackgroundTasksPart) {
//        NSString* actionName = [actionItem objectForKey:NM_ACTION_ITEM_ID_KEY];
//        if ([[actionItem objectForKey:NM_ACTION_ITEM_STATIC_KEY] boolValue]) {
//            [[NMActionController actionClassByName:actionName] staticDoActionsBecomeActiveInBackground];
//        } else {
//            [[NMActionController getActionByName:actionName]  doActionsBecomeActiveInBackground];
//        }
//    }
//}
//
//- (void)confitUShareSettings
//{
//    /*
//     * 打开图片水印
//     */
//    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
//
//    /*
//     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
//     <key>NSAppTransportSecurity</key>
//     <dict>
//     <key>NSAllowsArbitraryLoads</key>
//     <true/>
//     </dict>
//     */
//    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
//}
//
//- (void)configUSharePlatforms
//{
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WECHAT_APPID appSecret:WECHAT_APPSECRET redirectURL:WECHAT_RECTURI];
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:APPID_TENCENT appSecret:nil redirectURL:nil];
//}
//
//- (void)nmmapViewControllerDidAppear{
//    [[NMMapViewController nmMapViewController]viewDidAppear:YES];
//}
//
//@end
