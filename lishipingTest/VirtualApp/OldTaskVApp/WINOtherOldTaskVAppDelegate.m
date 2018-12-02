//
//  WINOtherOldTaskVApp.m
//  Pods
//
//  Created by jixuhui on 2018/1/29.
//

#import "WINOtherOldTaskVAppDelegate.h"
#import "WINVAppManager.h"

//#import "NMActionController.h"
//#import "NMBaseAction.h"
#import "WINOldTaskDefine.h"

@interface WINOtherOldTaskVAppDelegate ()

@property (nonatomic, strong) NSArray *finishLaunchTasksPart2;

@end

@implementation WINOtherOldTaskVAppDelegate

+ (void)load
{
    [[WINVAppManager sharedInstance] registerVAppLifecycleWithVApp:self];
}

+ (instancetype)sharedInstance
{
    static WINOtherOldTaskVAppDelegate *_sharedInstance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[WINOtherOldTaskVAppDelegate alloc] init];
    });
    
    return _sharedInstance;
}

+ (WINLaunchPriority)launchPriority
{
    return WINLaunchPriorityLow;
}

+ (void)vAppLaunchWithOptions:(NSDictionary *)launchOptions;
{
    WINOtherOldTaskVAppDelegate *obj = [self sharedInstance];
    
    [obj initTask];
    
    for (NSDictionary* actionItem in obj.finishLaunchTasksPart2) {
        NSString* actionName = [actionItem objectForKey:NM_ACTION_ITEM_ID_KEY];
//        if ([[actionItem objectForKey:NM_ACTION_ITEM_STATIC_KEY] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
//            [[NMActionController actionClassByName:actionName] staticapplication:[UIApplication sharedApplication] didFinishLaunchingWithOptions:launchOptions];
//        } else {
//            [[NMActionController getActionByName:actionName]  application:[UIApplication sharedApplication] didFinishLaunchingWithOptions:launchOptions];
//        }
    }
}

- (void)initTask
{
    if (!_finishLaunchTasksPart2) {
        _finishLaunchTasksPart2 = @[
                                    @{NM_ACTION_ITEM_ID_KEY:@"NMMainMapManager" ,NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
                                    @{NM_ACTION_ITEM_ID_KEY:@"NMShareManager", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
                                    @{NM_ACTION_ITEM_ID_KEY:@"NMOfflineResourceManager", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
                                    @{NM_ACTION_ITEM_ID_KEY:@"NMCarNaviManager", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
                                    @{NM_ACTION_ITEM_ID_KEY:@"NMNotificationManager", NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
                                    @{NM_ACTION_ITEM_ID_KEY:@"NMFlashManager",NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
                                    @{NM_ACTION_ITEM_ID_KEY:@"NMRealTimeMapManager",NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
                                    @{NM_ACTION_ITEM_ID_KEY:@"NMFlashScreenCommercialManager",NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
                                    @{NM_ACTION_ITEM_ID_KEY:@"NMMonitorUtility",NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
                                    @{NM_ACTION_ITEM_ID_KEY:@"LTMSafeKVStore",NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
                                    @{NM_ACTION_ITEM_ID_KEY:@"LTMTakeTaxiCheckUncompleteOrderUtility",NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},//启动监测不需要创建LTMTakeTaxiManager
                                    @{NM_ACTION_ITEM_ID_KEY:@"LTMOrderCheckerUtility",NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]},
                                    @{NM_ACTION_ITEM_ID_KEY:@"LTMFreerideUnCompleteJourneyUntility",NM_ACTION_ITEM_STATIC_KEY:[NSNumber numberWithBool:YES]}
                                    
                                    ];
    }
}

@end
