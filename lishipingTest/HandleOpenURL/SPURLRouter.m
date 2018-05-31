//
//  SPURLRouter.m
//  lishipingTest
//
//  Created by shiping li on 2018/1/18.
//  Copyright © 2018年 shiping1. All rights reserved.
//

#import "SPURLRouter.h"
#import <SPCategory/NSString+SPEnCode.h>
#import <SPWebViewController.h>

@interface SPURLRouter()

@property(nonatomic,copy)NSString *plistName;

@end

@implementation SPURLRouter

+ (instancetype)manager
{
    static SPURLRouter *gs_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gs_manager = [[[self class] alloc] init];
    });
    return gs_manager;
}

-(void)setViewControllerClassPlist:(NSString*)plistName
{
    _plistName = plistName;
}

+ (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [self application:application openURL:url options:@{UIApplicationLaunchOptionsSourceApplicationKey:@"unkown"}];
}

+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation;
{
    NSDictionary *dict =@{UIApplicationLaunchOptionsSourceApplicationKey:sourceApplication?:@"unkown",
                          UIApplicationLaunchOptionsAnnotationKey:annotation?:@"unkown",
                          };
    
    return [self application:application openURL:url options:dict];
}

+ (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray *))restorationHandler
{
    if ([userActivity.activityType isEqualToString:NSUserActivityTypeBrowsingWeb])
    {
        NSURL *webpageURL = userActivity.webpageURL;
        return [self application:application openURL:webpageURL options:nil];
    }
    return YES;
}

+ (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    //    NSString *bundleID = [options objectForKey:UIApplicationLaunchOptionsSourceApplicationKey];
    //    id annotation = [options objectForKey:UIApplicationLaunchOptionsAnnotationKey];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        if (url.scheme.length>0 && [self checkSchemeIsWhiteList:url.scheme])
        {
            NSMutableDictionary *mDic = [self getParamFromURL:url.query];
            NSString *classStr = [self getViewControllerClassFromBundle:[SPURLRouter manager].plistName urlKey:url.host];
            
            Class cls =NSClassFromString(classStr);
            NSAssert((cls && [cls isSubclassOfClass:[UIViewController class]]), @"类列表取出的类不是viewController类");
            
            if (cls && [cls isSubclassOfClass:[UIViewController class]]) {
                
                //当字典参数中animated=0的时候无动画，animated=1或者其他任何值或者不设置这个参数默认有动画
                //当字典参数中appear_type=0或者不设置或者设置其他别的值该参数的时候，push推进去，当appear_type=1的时候，prsent弹出，
                
                //无动画
                if ([[mDic objectForKey:@"animated"] isEqualToString:@"0"])
                {
                    [mDic removeObjectForKey:@"animated"];
                    
                    //present
                    if ([[mDic objectForKey:@"appear_type"] isEqualToString:@"1"])
                    {
                        [mDic removeObjectForKey:@"appear_type"];
                        SP_PRESENT_VC_BY_CLASSNAME_NO_ANIMATED(classStr, mDic)
                    }else
                    {
                        //push
                        [mDic removeObjectForKey:@"appear_type"];
                        SP_PUSH_VC_BY_CLASSNAME_NO_ANIMATED(classStr, mDic)
                    }
                }
                else
                {
                    //有动画
                    [mDic removeObjectForKey:@"animated"];
                    
                    //present
                    if ([[mDic objectForKey:@"appear_type"] isEqualToString:@"1"])
                    {
                        [mDic removeObjectForKey:@"appear_type"];
                        SP_PRESENT_VC_BY_CLASSNAME(classStr, mDic)
                    }
                    else
                    {
                        //push
                        [mDic removeObjectForKey:@"appear_type"];
                        SP_PUSH_VC_BY_CLASSNAME(classStr, mDic)
                    }
                }
            }
        }
//        else if(url.scheme.length>0)
//        {
//            SP_APP_OPEN_URL(url)
//        }
        else if([url.absoluteString hasPrefix:@"http"] || [url.absoluteString hasPrefix:@"https"])
        {
            SPWebViewController *web = [[SPWebViewController alloc] initWithURL:url];
            
            SP_PUSH_VC(web)
        }
        else
        {
            SP_APP_OPEN_URL(url)
        }
        
    });
    
    return YES;
}



//从url得到请求参数
+(NSMutableDictionary*)getParamFromURL:(NSString*)urlQuery
{
    NSArray *queryArr = [urlQuery componentsSeparatedByString:@"&"];
    
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    for (NSString *querytemp in queryArr) {
        
        NSArray *keyvalue = [querytemp componentsSeparatedByString:@"="];
        NSString *valuString =keyvalue[1];
        [mDic setObject:valuString.urlDecode forKey:keyvalue[0]];
    }
    
    return mDic;
}

//验证白名单
+(BOOL)checkSchemeIsWhiteList:(NSString*)scheme
{
    if (scheme.length>0) {
        NSArray *arr = [self getSchemeFromBundle];
        return [arr containsObject:scheme];
    }
    return NO;
}

//读取info.plist的白名单
+(NSArray*)getSchemeFromBundle
{
    NSArray *bundleURLTypesArr = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleURLTypes"];
    
    NSMutableArray *schemeMArr = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *type in bundleURLTypesArr)
    {
        NSArray *WhitelistArr = [type objectForKey:@"CFBundleURLSchemes"];
        NSString *bundleURLName = [type objectForKey:@"CFBundleURLName"];

        //这一步是为了区分当前APP可以接受内部使用URL做页面跳转的scheme白名单,每个工程不一样，所以这里需要手动修改
        if ([bundleURLName isEqualToString:@"com.lishipingTest"]&&WhitelistArr.count>0)
        {
            [schemeMArr addObjectsFromArray:WhitelistArr];
        }
    }
    return schemeMArr;
}

//从open_url.plist取出对应类
+(NSString*)getViewControllerClassFromBundle:(NSString*)plistName urlKey:(NSString*)urlKey
{
    NSDictionary *dictem = [[NSDictionary alloc] initWithContentsOfFile:
                            [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"]];
    
    NSString *className = nil;
    
    //这是备注信息，方便查看用的
    //    NSString *remark =  [class_info objectForKey:@"remark"];
    NSDictionary *class_info = [dictem objectForKey:urlKey];
    className =  [class_info objectForKey:@"class"];
    
    //以下是备用类，做ABTest使用使用
    if ([className isEqualToString:@"LoginVC"])
    {
        //这里获取网络ABTest控制
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"ab_login"])
        {
            className =  [[dictem objectForKey:urlKey] objectForKey:@"emergency_class"];
        }
    }
    else if ([className isEqualToString:@"RegisterVC"])
    {
        
    }
    
    return className;
}

@end
