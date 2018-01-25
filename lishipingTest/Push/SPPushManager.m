//
//  SPPushManager.m
//  lishipingTest
//
//  Created by shiping li on 2017/12/27.
//  Copyright © 2017年 shiping1. All rights reserved.
//

#import "SPPushManager.h"
#import <UserNotifications/UserNotifications.h>

@implementation SPPushManager


+(void)checkNotificationAuthorizationStatusWithCompletionHandler:(void(^)(BOOL succeed))block
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
    {
        //监视通知开关，iOS 10 使用以下方法才能得到授权
        UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
        // 获取当前的通知授权状态, UNNotificationSettings
        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {
                //            NSLog(@"已授权");
                block(YES);
            }
            else
            {
                //            NSLog(@"未授权");
                block(NO);
            }
        }];
    }
    else if ([UIDevice currentDevice].systemVersion.floatValue>=8.0f)
    {
        //ios8.0-10.0
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone == setting.types) {
            //        NSLog(@"推送关闭 8.0,用户不允许通知!");
            block(NO);
        }
        else
        {
            //        NSLog(@"推送打开 8.0");
            block(YES);
        }
    }
    else
    {
        //ios3.0-8.0
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        
        if(UIRemoteNotificationTypeNone == type){
            //            NSLog(@"推送关闭");
            block(NO);
        }
        else
        {
            //            NSLog(@"推送打开");
            block(YES);
        }
    }
}


@end
