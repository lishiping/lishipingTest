//
//  LSPNetWorkReachability.h
//
//  Created by lishiping on 16/6/29.
//  Copyright © 2016年 lishiping. All rights reserved.
//
/*高级网络环境类，带有2g，3g，4g，wifi*/

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LSPNetWorkStatus) {
    LSPNetWorkStatusNotReachable = 0,
    LSPNetWorkStatusUnknown = 1,
    LSPNetWorkStatusWWAN2G = 2,
    LSPNetWorkStatusWWAN3G = 3,
    LSPNetWorkStatusWWAN4G = 4,
//    LSPNetWorkStatusWWAN5G = 5,
    LSPNetWorkStatusWiFi = 9,
};

extern NSString *LSPNetWorkReachabilityChangedNotification;

@interface LSPNetWorkReachability : NSObject

/*!
 * Use to check the reachability of a given host name.
 */
+ (instancetype)reachabilityWithHostName:(NSString *)hostName;

/*!
 * Use to check the reachability of a given IP address.
 */
+ (instancetype)reachabilityWithAddress:(const struct sockaddr *)hostAddress;

/*!
 * Checks whether the default route is available. Should be used by applications that do not connect to a particular host.
 */
+ (instancetype)reachabilityForInternetConnection;

- (BOOL)startNotifier;

- (void)stopNotifier;

- (LSPNetWorkStatus)currentReachabilityStatus;

@end
