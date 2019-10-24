//
//  AMLocalNotificationUtil.m
//  AMapiPhone
//
//  Created by hc on 12-12-27.
//
//

#import "SPLocalNotificationUtil.h"
#import <UserNotifications/UNUserNotificationCenter.h>
//#import "NMUIThemeManager.h"


@implementation SPLocalNotificationUtil

+ (void) sendDefultPresentNotification:(NSString *)message {

    UILocalNotification *locationNotification = [[UILocalNotification alloc] init];
    //设置通知的音乐
    locationNotification.soundName = nil;
    //设置通知内容
    locationNotification.alertBody = message;
    //设置程序的Icon右上角通知的个数
    locationNotification.applicationIconBadgeNumber = 0;
    //执行本地推送 不用等待直接触发已设好的Notification
    [[UIApplication sharedApplication] presentLocalNotificationNow:locationNotification];
    
}

+ (void)sendDefultPresentNotification:(NSString *)message withActionUri:(NSString *)actionUri {
    
    UILocalNotification *locationNotification = [[UILocalNotification alloc] init];
    //设置通知的音乐
    locationNotification.soundName = nil;
    //设置通知内容
    locationNotification.alertBody = message;
    //设置程序的Icon右上角通知的个数
    locationNotification.applicationIconBadgeNumber = 0;
    //执行本地推送 不用等待直接触发已设好的Notification
    locationNotification.userInfo = @{ @"actionUri" : actionUri };
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:locationNotification];
}

+ (void)sendDefultPresentNotification:(NSString *)title message:(NSString *)message withActionUri:(NSString *)actionUri {
    
    UILocalNotification *locationNotification = [[UILocalNotification alloc]  init];
    //设置通知的音乐
    locationNotification.soundName = nil;
    
    if (title.length && [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.2) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability"
        locationNotification.alertTitle = title;
#pragma clang diagnostic pop
    }
    
    //设置通知内容
    locationNotification.alertBody = message;
    //设置程序的Icon右上角通知的个数
    locationNotification.applicationIconBadgeNumber = 0;
    //执行本地推送 不用等待直接触发已设好的Notification
    
    locationNotification.userInfo = @{ @"actionUri" : actionUri };
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:locationNotification];
}

+ (void) sendDefultPresentNotification:(NSString *)message WithSound:(NSString *)sound {
    if ([message isEqualToString:@""]) {
        return;
    }
    UILocalNotification *locationNotification = [[UILocalNotification alloc]  init];
    //设置通知的音乐
    locationNotification.soundName = sound;//UILocalNotificationDefaultSoundName
    //设置通知内容
    locationNotification.alertBody = message;
    //设置程序的Icon右上角通知的个数
    locationNotification.applicationIconBadgeNumber = 0;
    //执行本地推送 不用等待直接触发已设好的Notification
    [[UIApplication sharedApplication] presentLocalNotificationNow:locationNotification];
    
    
}

+(void)sendDefultscheduleNotification:(NSString *)message date:(NSDate *) date {

    UILocalNotification *locationNotification = [[UILocalNotification alloc]  init];
    //设置推送时间，这里使用相对时间，如果fireDate采用GTM标准时间，timeZone可以至nil
    locationNotification.fireDate = date;
    locationNotification.timeZone = [NSTimeZone defaultTimeZone];
    //设置通知的音乐
    locationNotification.soundName = nil;
    //设置通知内容
    locationNotification.alertBody = message;
    //设置程序的Icon右上角通知的个数
    locationNotification.applicationIconBadgeNumber = 0;
    //执行本地推送
    [[UIApplication sharedApplication] scheduleLocalNotification:locationNotification];
    
    
}

+ (void) sendDefultscheduleNotificationWithSound:(NSString *)message date:(NSDate *) date {
    if ([message isEqualToString:@""]) {
        return;
    }
    UILocalNotification *locationNotification = [[UILocalNotification alloc]  init];
    //设置推送时间，这里使用相对时间，如果fireDate采用GTM标准时间，timeZone可以至nil
    locationNotification.fireDate = date;
    locationNotification.timeZone = [NSTimeZone defaultTimeZone];
    //设置通知的音乐
    locationNotification.soundName = UILocalNotificationDefaultSoundName;
    //设置通知内容
    locationNotification.alertBody = message;
    //设置程序的Icon右上角通知的个数
    locationNotification.applicationIconBadgeNumber = 0;
    //执行本地推送 不用等待直接触发已设好的Notification
    [[UIApplication sharedApplication] presentLocalNotificationNow:locationNotification];
    
}

+(void)clearOldNotification {

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
    {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability"
        [[UNUserNotificationCenter currentNotificationCenter] removeAllDeliveredNotifications];
#pragma clang diagnostic pop
        
    } else {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }

}

+ (void)staticapplicationWillTerminate:(UIApplication *)application
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}
@end
