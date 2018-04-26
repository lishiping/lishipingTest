//
//  AppDelegate.m
//  lishipingTest
//
//  Created by shiping1 on 2017/11/2.
//  Copyright © 2017年 shiping1. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <SPDebugBar.h>
#import "SPHandleOpenURLManager.h"
#import "SPNetworkManager.h"
#import <SPBaseTabBarController.h>
#import <SPBaseVC.h>
#import <SDWebImageManager.h>
#import <SPMacro/SPMacro.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


//说明：当程序载入后执行
//当应用程序启动时（不包括已在后台的情况下转到前台），调用此回调。launchOptions是启动参数，假如用户通过点击push通知启动的应用，这个参数里会存储一些push通知的信息。
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //配置服务器地址，为了测试服切换和正式服设定
    [self loadDebugTool];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController =[self addTabBarController];
    
    [[SPHandleOpenURLManager manager] setViewControllerClassPlist:@"open_url"];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

//加载调试工具
-(void)loadDebugTool
{
    //检测当前是否是测试包
    //当debug和打测试包的时候为了测试人员切换服务器调试，调试工具要显示，线上包的时候该调试工具不显示
    if (TEST||DEBUG)
    {
        NSDictionary* serverDic = @{
                                    SP_TITLE_KEY:@"百度服务器地址",
                                    SP_ARRAY_KEY: @[
                                            @"https://172.16.142.122:8686",
                                            @"http://api.baidu.com",
                                            @"http://api.ceshi.baidu.com"
                                            ]
                                    };
        
        NSDictionary *panServerDic = @{
                                       SP_TITLE_KEY:@"百度网盘地址",
                                       SP_ARRAY_KEY: @[
                                               @"https://api.pan.baidu.com",
                                               @"http://api.pan.baidu.com",
                                               @"http://api.ceshi.pan.baidu.com",
                                               @"http://api.test.pan.baidu.com"
                                               ]};
        
        NSDictionary *imServerDic = @{
                                      SP_TITLE_KEY:@"百度聊天地址",
                                      SP_ARRAY_KEY: @[
                                              @"https://api.pan.baidu.com",
                                              @"http://api.pan.baidu.com",
                                              @"http://api.ceshi.pan.baidu.com",
                                              @"http://api.test.pan.baidu.com"
                                              ]};
        
        NSArray *serverArray = [NSArray arrayWithObjects:serverDic,panServerDic,imServerDic, nil];
        
        NSDictionary* secondDic = @{
                                    SP_TITLE_KEY:@"灰度功能",
                                    SP_ARRAY_KEY: @[
                                            @"ABTestSDK",
                                            @"AB放量"
                                            ]
                                    };
        
        NSDictionary *thirdDic = @{
                                   SP_TITLE_KEY:@"商业化功能",
                                   SP_ARRAY_KEY: @[
                                           @"商业放量",
                                           @"商业灰度"
                                           ]};
        
        NSArray *otherArray = [NSArray arrayWithObjects:secondDic,thirdDic, nil];
        
        [SPDebugBar sharedInstanceWithServerArray:serverArray selectedServerArrayBlock:^(NSArray *objects, NSError *error) {
            SP_LOG(@"选中的服务器地址：%@",objects);
            NSAssert(!error,error.description);
            if (error) {
                //设置线上正式服地址
                [SPNetworkManager manager].host = @"https://www.baidu.com";
            }
            else
            {
                [SPNetworkManager manager].host = objects[0];
            }
            
        } otherSectionArray:otherArray otherSectionArrayBlock:^(UINavigationController *navigationController,NSString *string, NSError *error) {
            SP_LOG(@"你点击了:%@",string);
            
            //            ABTestVC *abTestVC = [[ABTestVC alloc] init];
            //            abTestVC.title = string;
            //
            //            [navigationController pushViewController:abTestVC animated:YES];
        }];
    }
    else
    {
        //set up online server address
        //设置线上正式服地址
        [SPNetworkManager manager].host = @"https://www.baidu.com";
        
    }
}


-(UITabBarController*)addTabBarController
{
//    [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:@"https://h5.sinaimg.cn/upload/1078/660/2018/03/30/1111111111.png"] options:SDWebImageRetryFailed progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
//    }];
//
//    UIImage *ima = [[SDImageCache sharedImageCache] imageFromCacheForKey:@"https://h5.sinaimg.cn/upload/1078/660/2018/03/30/1111111111.png"];
    
    
    NSArray *normalImages = [NSArray arrayWithObjects:
                             @"home_normal",
                             @"search_normal",
                             @"zixun_hover_nor",
                             @"interact_normal",
                             @"user_normal",
                             //                                 @"icon_tabbar_qa_d",
                             //                               @"icon_tabbar_me_d",
                             nil];
    NSArray *selectedImages = [NSArray arrayWithObjects:
                               @"home_hover",
                               @"search_hover",
                               @"zixun_hover_nor",
                               @"interact_hover",
                               @"user_hover",
                               //                                   @"icon_tabbar_qa_h",
                               //                                   @"icon_tabbar_me_h",
                               nil];
    
    SPBaseTabBarController *tab = [[SPBaseTabBarController alloc] init_didSelectViewControllerBlock:^(UITabBarController *tabBarViewcontroller, UIViewController *viewcontroller) {
        NSLog(@"选中后处理%lu",(unsigned long)tabBarViewcontroller.selectedIndex);
        viewcontroller.tabBarItem.badgeValue = nil;
    }];
    
    [tab addItemController:[ViewController new]
          tabBarItem_title:@"微信"
      tabBarItem_titleFont:[UIFont systemFontOfSize:14]
tabBarItem_normalTitleColor:[UIColor colorWithRed:164/255.0 green:164/255.0 blue:164/255.0 alpha:1]
tabBarItem_selectTitleColor:[UIColor colorWithRed:31/255.0 green:185/255.0 blue:37/255.0 alpha:1]
          tabBarItem_image:SP_IMAGE(normalImages[0])
  tabBarItem_selectedImage:SP_IMAGE(selectedImages[0])
     tabBarItem_badgeValue:@"20"];
    
    [tab addItemController:[SPBaseVC new]
          tabBarItem_title:@"通讯录"
      tabBarItem_titleFont:[UIFont systemFontOfSize:14]
tabBarItem_normalTitleColor:[UIColor colorWithRed:164/255.0 green:164/255.0 blue:164/255.0 alpha:1]
tabBarItem_selectTitleColor:[UIColor colorWithRed:31/255.0 green:185/255.0 blue:37/255.0 alpha:1]
          tabBarItem_image:SP_IMAGE(normalImages[1])
  tabBarItem_selectedImage:SP_IMAGE(selectedImages[1])
     tabBarItem_badgeValue:nil];
    
    [tab addItemController:[SPBaseVC new]
          tabBarItem_title:@"发现"
      tabBarItem_titleFont:[UIFont systemFontOfSize:14]
tabBarItem_normalTitleColor:[UIColor colorWithRed:164/255.0 green:164/255.0 blue:164/255.0 alpha:1]
tabBarItem_selectTitleColor:[UIColor colorWithRed:31/255.0 green:185/255.0 blue:37/255.0 alpha:1]
          tabBarItem_image:SP_IMAGE(normalImages[2])
  tabBarItem_selectedImage:SP_IMAGE(selectedImages[2])
     tabBarItem_badgeValue:nil];
    
    [tab addItemController:[SPBaseVC new]
          tabBarItem_title:@"我的"
      tabBarItem_titleFont:[UIFont systemFontOfSize:14]
tabBarItem_normalTitleColor:[UIColor colorWithRed:164/255.0 green:164/255.0 blue:164/255.0 alpha:1]
tabBarItem_selectTitleColor:[UIColor colorWithRed:31/255.0 green:185/255.0 blue:37/255.0 alpha:1]
          tabBarItem_image:SP_IMAGE(normalImages[3])
  tabBarItem_selectedImage:SP_IMAGE(selectedImages[3])
     tabBarItem_badgeValue:nil];
    
    return tab;
}

//说明：当应用程序将要入非活动状态执行，在此期间，应用程序不接收消息或事件，比如来电话了
//当应用从活动状态主动到非活动状态的应用程序时会调用这个方法。这可导致产生某些类型的临时中断（如传入电话呼叫或SMS消息）。或者当用户退出应用程序，它开始过渡到的背景状态。使用此方法可以暂停正在进行的任务，禁用定时器，降低OpenGL ES的帧速率。游戏应该使用这种方法来暂停游戏。调用时机可能有以下几种：锁屏，按HOME键，下接状态栏，双击HOME键弹出低栏，等情况。
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

//说明：当程序被推送到后台的时候调用。所以要设置后台继续运行，则在这个函数里面设置即可
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

//说明：当程序从后台将要重新回到前台时候调用，这个刚好跟上面的那个方法相反。
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


//说明：当应用程序进入活动状态执行
//当应用程序全新启动，或者在后台转到前台，完全激活时，都会调用这个方法。如果应用程序是以前运行在后台，这时可以选择刷新用户界面。
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

//说明：当程序将要退出是被调用，通常是用来保存数据和一些退出前的清理工作。这个需要要设置UIApplicationExitsOnSuspend的键值。
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//说明：iPhone设备只有有限的内存，如果为应用程序分配了太多内存操作系统会终止应用程序的运行，在终止前会执行这个方法，通常可以在这里进行内存清理工作防止程序被终止
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    
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

#pragma mark - handle open url
/*当前APP被其他APP或者web,或者内部以URL形式打开的处理等打开唤醒的时候，通过该类处理消息*/
//说明：当通过url执行
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url NS_DEPRECATED_IOS(2_0, 9_0, "Please use application:openURL:options:") __TVOS_PROHIBITED;
{
    return [SPHandleOpenURLManager application:application handleOpenURL:url];
}
//当用户通过其它应用启动本应用时，会回调这个方法，url参数是其它应用调用openURL:方法时传过来的。
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation NS_DEPRECATED_IOS(4_2, 9_0, "Please use application:openURL:options:") __TVOS_PROHIBITED;
{
    return [SPHandleOpenURLManager application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options NS_AVAILABLE_IOS(9_0)
{
    return  [SPHandleOpenURLManager application:app openURL:url options:options];
}

+ (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray *))restorationHandler
{
    return [SPHandleOpenURLManager application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
}


@end
