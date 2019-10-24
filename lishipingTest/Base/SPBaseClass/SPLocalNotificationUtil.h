//
//  AMLocalNotificationUtil.h
//  AMapiPhone
//
//  Created by hc on 12-12-27.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SPLocalNotificationUtil : NSObject
//及时通知
+(void)sendDefultPresentNotification:(NSString *)message;
//即时通知，点击后跳转的URI
+ (void)sendDefultPresentNotification:(NSString *)message withActionUri:(NSString *)actionUri;
//定时通知
+(void)sendDefultscheduleNotification:(NSString *)message date:(NSDate *) date;
//带声音震动带通知
+ (void) sendDefultPresentNotification:(NSString *)message WithSound:(NSString *)sound;

+ (void) sendDefultscheduleNotificationWithSound:(NSString *)message date:(NSDate *) date;
+(void)clearOldNotification;

+ (void)sendDefultPresentNotification:(NSString *)title message:(NSString *)message withActionUri:(NSString *)actionUri;

@end
