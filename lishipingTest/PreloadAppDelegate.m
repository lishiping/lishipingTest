//
//  PreloadAppDelegate.m
//  lishipingTest
//
//  Created by 164749 on 2018/12/19.
//  Copyright © 2018年 shiping1. All rights reserved.
//

#import "PreloadAppDelegate.h"
#import "SPAppManager.h"
#import <SPDebugBar.h>
#import "SPNetworkManager.h"
#import "SPURLRouter.h"
#import <GCDWebUploader.h>
#import "Third/ThirdVC.h"
#import "SPBaseNavigationController.h"
#import "SPSocketManager.h"
#import "FLEXManager.h"

@implementation PreloadAppDelegate

+ (void)load
{
    [[SPAppManager sharedInstance] registerAppLifecycleWithVApp:[self class] launchPriority:SPLaunchPriorityHigh];
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

//当应用程序启动时（不包括已在后台的情况下转到前台），调用此回调。launchOptions是启动参数，假如用户通过点击push通知启动的应用，这个参数里会存储一些push通知的信息。
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //配置服务器地址，为了测试服切换和正式服设定
    [self loadDebugTool];
    
    [[SPURLRouter manager] setViewControllerClassPlist:@"open_url"];

    
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];

    //2. 启动http server服务
  GCDWebUploader  *webUploader = [[GCDWebUploader alloc] initWithUploadDirectory:documentsPath];
    [webUploader start];
    NSLog(@"Visit %@ in your web browser", webUploader.serverURL);
//
//    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    [application delegate].window = window;
//
//
//    ThirdVC *thirdVC =[[ThirdVC alloc] init];
//    thirdVC.serverURL = [webUploader.serverURL absoluteString];
//
//    SPBaseNavigationController *nav = [[SPBaseNavigationController alloc] initWithRootViewController:thirdVC];
//
//    window.rootViewController = nav;
//
//    [window makeKeyAndVisible];
//    
    return YES;
}

//加载调试工具
-(void)loadDebugTool
{
    //检测当前是否是测试包
    //当debug和打测试包的时候为了测试人员切换服务器调试，调试工具要显示，线上包的时候该调试工具不显示
    if (TEST||DEBUG)
    {
        NSDictionary* socketServerDic = @{
                                    SP_TITLE_KEY:@"socket测试主机地址",
                                    SP_ARRAY_KEY: @[
                                            @"192.168.1.122:8686",
                                            @"100.81.137.239:54321"
                                            ]
                                    };
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
        
        NSArray *serverArray = [NSArray arrayWithObjects:socketServerDic,serverDic,panServerDic,imServerDic, nil];
        
        NSDictionary* secondDic = @{
                                    SP_TITLE_KEY:@"分析工具",
                                    SP_ARRAY_KEY: @[
                                            @"FLEX工具"
                                            ]
                                    };
        
        NSDictionary *thirdDic = @{
                                   SP_TITLE_KEY:@"商业化功能",
                                   SP_ARRAY_KEY: @[
                                           @"商业放量",
                                           @"商业灰度"
                                           ]};
        
        NSArray *otherArray = [NSArray arrayWithObjects:secondDic,thirdDic, nil];
        
        [SPDebugBar sharedInstanceWithServerArray:serverArray selectedServerArrayBlock:^(NSArray *objects, NSError *error)
        {
            SP_LOG(@"选中的服务器地址：%@",objects);
            NSAssert(!error,error.description);
            if (error) {
                
                //设置线上正式服地址
                [SPNetworkManager manager].host = @"https://www.baidu.com";
            }
            else
            {
                NSString *str1 = objects[0];
                str1 =  [str1 stringByReplacingOccurrencesOfString:@"：" withString:@":"];
                NSArray *arr1 = [str1 componentsSeparatedByString:@":"];
                [SPSocketManager sharedInstance].host =arr1[0];
                [SPSocketManager sharedInstance].port =arr1[1];

//                [SPNetworkManager manager].host = objects[1];
            }
            
        } otherSectionArray:otherArray otherSectionArrayBlock:^(UINavigationController *navigationController,NSString *string, NSError *error) {
            SP_LOG(@"你点击了:%@",string);
            if ([string isEqualToString:@"FLEX工具"]) {
                    [[FLEXManager sharedManager] showExplorer];
            }
            //            ABTestVC *abTestVC = [[ABTestVC alloc] init];
            //            abTestVC.title = string;
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

@end
