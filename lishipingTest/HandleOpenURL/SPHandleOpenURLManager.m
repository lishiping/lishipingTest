//
//  SPHandleOpenURLManager.m
//  lishipingTest
//
//  Created by shiping li on 2018/1/18.
//  Copyright © 2018年 shiping1. All rights reserved.
//

#import "SPHandleOpenURLManager.h"
#import <SPFastPush.h>

@interface SPHandleOpenURLManager()

@property(nonatomic,copy)NSString *plistName;

@end

@implementation SPHandleOpenURLManager

+ (instancetype)manager
{
    static SPHandleOpenURLManager *gs_manager = nil;
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
    return [[self class] application:application openURL:url options:@{UIApplicationLaunchOptionsSourceApplicationKey:@"unkown"}];
}

+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation;
{
    NSDictionary *dict =@{UIApplicationLaunchOptionsSourceApplicationKey:sourceApplication?:@"unkown",
                          UIApplicationLaunchOptionsAnnotationKey:annotation?:@"unkown",
                          };
    
    return [self application:application openURL:url options:dict];
}

+ (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    //    NSString *bundleID = [options objectForKey:UIApplicationLaunchOptionsSourceApplicationKey];
    //    id annotation = [options objectForKey:UIApplicationLaunchOptionsAnnotationKey];
    
    NSMutableDictionary *mDic = [self getParamFromURL:url.query];
    NSString *classStr = [self getViewControllerClassFromBundle:[SPHandleOpenURLManager manager].plistName urlKey:url.host];
    
    if (classStr.length>0 && [self checkSchemeIsWhiteList:url.scheme])
    {
        //当animated=0的时候无动画，animated=1或者其他任何值或者不设置这个参数默认有动画
        //当appear_type=0或者不设置或者设置其他别的值该参数的时候，push推进去，当appear_type=1的时候，prsent弹出，
        
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
    
    return YES;
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

//从url得到请求参数
+(NSMutableDictionary*)getParamFromURL:(NSString*)urlQuery
{
    NSArray *queryArr = [urlQuery componentsSeparatedByString:@"&"];
    
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    for (NSString *querytemp in queryArr) {
        
        NSArray *keyvalue = [querytemp componentsSeparatedByString:@"="];
        [mDic setObject:keyvalue[1] forKey:keyvalue[0]];
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
    NSArray *URLTypesArr = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleURLTypes"];
    
    NSMutableArray *schemeMArr = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *type in URLTypesArr) {
        NSArray *WhitelistArr = [type objectForKey:@"CFBundleURLSchemes"];
        [schemeMArr addObjectsFromArray:WhitelistArr];
    }
    return schemeMArr;
}

//读取info.plist的白名单
+(NSString*)getViewControllerClassFromBundle:(NSString*)plistName urlKey:(NSString*)urlKey
{
    NSDictionary *dictem = [[NSDictionary alloc] initWithContentsOfFile:
                            [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"]];
    
    NSString *classStr =  [[dictem objectForKey:urlKey] objectForKey:@"class"];
    //这是备注信息，方便查看用的
    //    NSString *remark =  [[dictem objectForKey:urlKey] objectForKey:@"remark"];
    
    return classStr;
}

@end
