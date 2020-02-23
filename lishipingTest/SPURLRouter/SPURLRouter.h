//
//  SPURLRouter.h
//  lishipingTest
//
//  Created by shiping li on 2018/1/18.
//  Copyright © 2018年 shiping1. All rights reserved.
//

/*
 1.本类是作者设计的使用URL做VC页面跳转和使用WebView打开网页，以及打开第三方软件等功能
 2.本类的好处是：
 （1）在工程内部任何地方都可以使用url随意跳转VC页面，随意打开网页
 （2）页面直接不需要import引用，完美解决类之间的耦合问题
 （3）由于URL的地址可以服务器下发，所以APP内部打开也具有非常灵活性
 3.如果想使用safari打开网页以及打开其他APP使用SP_APP_OPEN_URL_STRING(@"https://www.baidu.com/")
 4.打开本工程的页面或者内部webview显示url使用SP_INAPP_OPEN_URL_STRING(@"https://www.baidu.com/")
 5.本类的原理是，传入的url的host查询类名，url参数提取出来合成字典对象，然后遍历APP的rootVC拿到topVC，使用topVC去pushVC类对象并使用KVC将字典对象赋值给VC对象的属性参数
 6.当前APP被其他APP或者web使用scheme打开唤醒的时候，通过该类处理消息打开内部web或者内部具体页面*/

#import <Foundation/Foundation.h>
#import <SPFastPush/SPFastPush.h>

@interface SPURLRouter : NSObject

//将下面的代码放到Appelegate对应的方法里面

//- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
//{
//    //在工程建立一个open_url.plist的文件，在plist里面添加一个字典，key=login，value=@{@"class":@"LoginVC",@"emergency_class":@"LoginVC",@"remark":@"这个是备注信息，本类是登录页"}，使用下面的方法就可以弹出登录页面

// class是VC类名，emergency_class是备用的VC页面，在ABTest时候会用到

//    [[SPURLRouter manager] setViewControllerClassPlist:@"open_url"];

//当appear_type=0或者不设置或者设置其他别的值该参数的时候，push推进去，当appear_type=1的时候，prsent弹出，
//当animated=0的时候无动画，animated=1或者其他任何值或者不设置这个参数默认有动画
//SP_APP_OPEN_URL_STRING(@"lishiping://login?title=nihao&appear_type=0&animated=1")

//}

//
//#pragma mark - handle open url
///*当前APP被其他APP或者web,或者内部以URL形式打开的处理等打开唤醒的时候，通过该类处理消息*/
////说明：当通过url执行
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url NS_DEPRECATED_IOS(2_0, 9_0, "Please use application:openURL:options:") __TVOS_PROHIBITED;
//{
//    return [SPURLRouter application:application handleOpenURL:url];
//}
////当用户通过其它应用启动本应用时，会回调这个方法，url参数是其它应用调用openURL:方法时传过来的。
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation NS_DEPRECATED_IOS(4_2, 9_0, "Please use application:openURL:options:") __TVOS_PROHIBITED;
//{
//    return [SPURLRouter application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
//}
//
//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options NS_AVAILABLE_IOS(9_0)
//{
//    return  [SPURLRouter application:app openURL:url options:options];
//}
//
//+ (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray *))restorationHandler
//{
//    return [SPURLRouter application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
//}



+ (instancetype)manager;

/**
 单例初始化类列表使用
 */
-(void)setViewControllerClassPlist:(NSString*)plistName;

//使用宏直接打开一个网页或者scheme方式打开程序内部页面
#define SP_INAPP_OPEN_URL_STRING(urlString) [SPURLRouter application:nil handleOpenURL:[NSURL URLWithString:urlString]];
+ (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url;


+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation;

+ (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options;

+ (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray *))restorationHandler;

@end
