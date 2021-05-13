//
//  AVPermissionHelper.m
//
//  Created by lishiping on 2021/1/27.
//  Copyright © 2021 lgl. All rights reserved.
//

#import "AVPermissionHelper.h"
#import "LGLAPLAlertViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <SPFastPush/SPFastPush.h>

@implementation AVPermissionHelper

+ (void)requestAccessAudio:(UIViewController *)controller completionHandler:(void (^)(BOOL))completionHandler
{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio
                             completionHandler:^(BOOL granted){
        dispatch_async(dispatch_get_main_queue(), ^{
            if(!granted){
                [self routeSetting:@"请在”设置-应用管理-新东方在线”中开启麦克风权限"
                        controller:controller
                     cancelHandler:^
                 {}];
            }
            if(completionHandler)
            {
                completionHandler(granted);
            }
        });
    }];
}

+ (void)requestAccessVideo:(UIViewController *)controller completionHandler:(void (^)(BOOL))completionHandler
        
{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo
                             completionHandler:^(BOOL granted){
        dispatch_async(dispatch_get_main_queue(), ^{
            if(!granted)
            {
                [self routeSetting:@"请在”设置-应用管理-新东方在线”中开启相机权限"
                        controller:controller
                     cancelHandler:^
                {}];
            }
            if(completionHandler)
            {
                completionHandler(granted);
            }
        });
    }];
}

+ (void)requestAccessVideoAndAudio:(UIViewController *)controller completionHandler:(void (^)(BOOL))completionHandler
{
    __weak typeof(self) weak_self = self;
    [self requestAccessVideo:controller completionHandler:^(BOOL granted) {
        if (granted) {
            [weak_self requestAccessAudio:controller completionHandler:^(BOOL granted) {
                if (completionHandler) {
                    completionHandler(granted);
                }
            }];
        }else{
            if (completionHandler) {
                completionHandler(granted);
            }
        }
    }];
}

+(void)requestAccessVideoAndAudioCompletionHandler:(void (^)(BOOL))completionHandler
{
    UIViewController *topVC = SP_GET_TOP_VC;
    [self requestAccessVideoAndAudio:topVC completionHandler:completionHandler];
}

+ (void)routeSetting:(NSString *)msg
          controller:(UIViewController *)controller
       cancelHandler:(void (^ __nullable)(void))cancelHandler
{
    LGLAPLAlertViewController *alert = [LGLAPLAlertViewController alertControllerWithTitle:@"请求权限"
                                                        message:msg
                                                 preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"去开启"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *action)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消"
                                              style:UIAlertActionStyleCancel
                                            handler:^(UIAlertAction *action)
    {
        if(cancelHandler)
        {
            cancelHandler();
        }
    }]];
    [controller presentViewController:alert
                             animated:YES
                           completion:nil];
}

@end
