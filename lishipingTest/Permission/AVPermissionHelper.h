//
//  AVPermissionHelper.h
//
//  Created by lishiping on 2021/1/27.
//  Copyright © 2021 lgl. All rights reserved.
//  设备权限管理器

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AVPermissionHelper : NSObject

+ (void)requestAccessAudio:(UIViewController *)controller
         completionHandler:(void (^__nullable)(BOOL granted))completionHandler;

+ (void)requestAccessVideo:(UIViewController *)controller
         completionHandler:(void (^__nullable)(BOOL granted))completionHandler;

+ (void)requestAccessVideoAndAudio:(UIViewController *)controller
         completionHandler:(void (^__nullable)(BOOL granted))completionHandler;


/// 请求摄像头和麦克风权限
/// @param completionHandler 是否授权
+ (void)requestAccessVideoAndAudioCompletionHandler:(void (^__nullable)(BOOL granted))completionHandler;

@end

NS_ASSUME_NONNULL_END
