//
//  DemoAppDelegate.m
//  lishipingTest
//
//  Created by 164749 on 2018/12/19.
//  Copyright © 2018年 shiping1. All rights reserved.
//

#import "DemoAppDelegate.h"
#import "ViewController.h"
#import "SPNetworkManager.h"
#import <SPBaseTabBarController.h>
#import <SPBaseVC.h>
#import <SDWebImageManager.h>
#import <SPMacro/SPMacro.h>
#import "SecondHomeVC.h"
#import "SPAppManager.h"

@implementation DemoAppDelegate

+ (void)load
{
    [[SPAppManager sharedInstance] registerAppLifecycleWithVApp:[self class] launchPriority:SPLaunchPriorityLow];
}

+ (instancetype)sharedInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

//说明：当程序载入后执行
//当应用程序启动时（不包括已在后台的情况下转到前台），调用此回调。launchOptions是启动参数，假如用户通过点击push通知启动的应用，这个参数里会存储一些push通知的信息。
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
        
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [application delegate].window = window;
    
    window.rootViewController =[self addTabBarController];
        
    [window makeKeyAndVisible];
    
    return YES;
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
    
    [tab addItemController:[SecondHomeVC new]
          tabBarItem_title:@"测试demo"
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
    
    tab.selectedIndex = 1;
    return tab;
}

/*当前APP被其他APP或者web,或者内部以URL形式打开的处理等打开唤醒的时候，通过该类处理消息*/
//说明：当通过url执行
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url NS_DEPRECATED_IOS(2_0, 9_0, "Please use application:openURL:options:") __TVOS_PROHIBITED;
{
    return [SPURLRouter application:application handleOpenURL:url];
}

//当用户通过其它应用启动本应用时，会回调这个方法，url参数是其它应用调用openURL:方法时传过来的。
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation NS_DEPRECATED_IOS(4_2, 9_0, "Please use application:openURL:options:") __TVOS_PROHIBITED;
{
    return [SPURLRouter application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options NS_AVAILABLE_IOS(9_0)
{
    return  [SPURLRouter application:app openURL:url options:options];
}

@end
