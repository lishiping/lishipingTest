//
//  SPHUD.m
//  lishipingTest
//
//  Created by shiping li on 2018/2/9.
//  Copyright © 2018年 shiping1. All rights reserved.
//

#import "SPHUD.h"
#import <SPFastPush.h>
#import<UIViewController+SPHUD.h>
#import <UIImage+SPGIF.h>

@implementation SPHUD

// 使block在主线程中运行
#define sp_run_in_main_thread(block)    if ([NSThread isMainThread]) {(block);} else {dispatch_async(dispatch_get_main_queue(), ^{(block);});}

#define sp_color_rgb(rgbValue) [UIColor colorWith\
Red     :(rgbValue & 0xFF0000)     / (float)0xFF0000 \
green   :(rgbValue & 0xFF00)       / (float)0xFF00 \
blue    :(rgbValue & 0xFF)         / (float)0xFF \
alpha   :1.0]


#define hud_detailLabel_textColor [UIColor whiteColor]//文本颜色
#define hud_backgroundColor [UIColor whiteColor]//整体背景色
#define hud_bezelView_Color sp_color_rgb(0x1E1E1E)//hud块背景色
#define hud_detailLabel_font [UIFont systemFontOfSize:14]//文本字体


#pragma mark - sp_showPrompt

+(void)sp_showToast:(NSString *)message
{
    [self sp_showPrompt:message];
}

+ (void)sp_showPrompt:(NSString *)message;
{
    CGFloat time = 1.5;
    time += (message.length / 20.);
    time = MIN(time, 5);
    [self sp_showPrompt:message delayHide:time];
}

+(void)sp_showPrompt:(NSString *)message delayHide:(float)seconds
{
    [self sp_hideHUD];
    
    UIView *v = SP_GET_TOP_VC.view;
    sp_run_in_main_thread(showPrompt(v, message, seconds, YES));
}

+ (void)sp_showPromptAddWindow:(NSString *)message
{
    [self sp_hideHUD];
    
    sp_run_in_main_thread(showPrompt([[UIApplication sharedApplication].delegate window], message, 2, YES));
}

#pragma mark - sp_showHUD

+ (void)sp_showHUD
{
    [self sp_showHUD:nil animation:YES];
}

+ (void)sp_showHUD:(NSString *)message
{
    [self sp_showHUD:message animation:YES];
}

+ (void)sp_showHUD:(NSString *)message animation:(BOOL)animated
{
    UIView *v = SP_GET_TOP_VC.view;
    [self sp_showHUDInView:v message:message animation:animated];
}

+ (void)sp_showHUDInView:(UIView *)superView message:(NSString *)message animation:(BOOL)animated
{
    [self sp_hideHUDInView:superView delay:0.0 animated:NO];
    sp_run_in_main_thread(showHUD(superView, message, 0, animated));
}

#pragma mark - sp_showHUDGIF

+ (void)sp_showHUDGIF_name:(NSString *)gifNameInBundleStr
{
    [self sp_showHUDGIF_name:gifNameInBundleStr text:nil detailText:nil];
}

+ (void)sp_showHUDGIF_name:(NSString *)gifNameInBundleStr
                      text:(NSString *)text
                detailText:(NSString *)detailText
{
    [self sp_showHUDGIF_name:gifNameInBundleStr text:text detailText:detailText delayHide:0.0f];
}

+ (void)sp_showHUDGIF_name:(NSString *)gifNameInBundleStr
                      text:(NSString *)text
                detailText:(NSString *)detailText
                 delayHide:(float)seconds
{
    UIImage *image = [UIImage sp_animatedGIFNamed:gifNameInBundleStr];
    UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
    [self sp_showHUDCustomView:imageview text:text detailText:detailText delayHide:seconds];
}

+ (void)sp_showHUDGIF_data:(NSData *)gifData
                      text:(NSString *)text
                detailText:(NSString *)detailText
{
    [self sp_showHUDGIF_data:gifData text:text detailText:detailText delayHide:0.0f];
}

+ (void)sp_showHUDGIF_data:(NSData *)gifData
                      text:(NSString *)text
                detailText:(NSString *)detailText
                 delayHide:(float)seconds
{
    UIImage *image = [UIImage sp_animatedGIFWithData:gifData];
    UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
    [self sp_showHUDCustomView:imageview text:text detailText:detailText delayHide:seconds];
}

+ (void)sp_showHUDCustomView:(UIView *)customV
{
    [self sp_showHUDCustomView:customV text:nil detailText:nil delayHide:0.0f];
}

+ (void)sp_showHUDCustomView:(UIView *)customV text:(NSString *)text detailText:(NSString *)detailText
{
    [self sp_showHUDCustomView:customV text:text detailText:detailText delayHide:0.0f];
}

+ (void)sp_showHUDCustomView:(UIView *)customV text:(NSString *)text detailText:(NSString *)detailText delayHide:(float)seconds
{
    UIView *v = SP_GET_TOP_VC.view;
    sp_run_in_main_thread(showCustomHUD(v, customV, text,detailText, seconds, YES));
}

+ (void)sp_updateHUDMessage:(NSString *)message
{
    UIView *v = SP_GET_TOP_VC.view;
    MBProgressHUD *hud = [MBProgressHUD HUDForView:v];
    if (hud)
    {
        hud.detailsLabel.text=message;
    }
    else
    {
        [self sp_showPrompt:message];
    }
}

#pragma mark - sp_showMBProgressHUD

+ (void)sp_showMBProgressHUD:(NSString *)message mode:(MBProgressHUDMode)mode progress:(float)progress animation:(BOOL)animated
{
    [self sp_showMBProgressHUD:message mode:mode progress:progress animation:animated font:hud_detailLabel_font textColor:hud_detailLabel_textColor bezelViewColor:hud_bezelView_Color backgroundColor:hud_backgroundColor];
}

+ (void)sp_showMBProgressHUD:(NSString *)message mode:(MBProgressHUDMode)mode progress:(float)progress animation:(BOOL)animated font:(UIFont *)font textColor:(UIColor *)textColor bezelViewColor:(UIColor *)bezelViewColor backgroundColor:(UIColor *)backgroundColor
{
    if (progress>0.999f) {
        [self sp_hideHUD];
        return;
    }
    UIView *v = SP_GET_TOP_VC.view;
    sp_run_in_main_thread(showProgressHUD(v, message, mode,progress, 0, animated,font,textColor,bezelViewColor,backgroundColor));
}


#pragma mark - hide

+(void)sp_hideHUD
{
    [self sp_hideHUD:NO];
}

+ (void)sp_hideHUD:(BOOL)animated
{
    [self sp_hideHUD:NO delay:0.0f];
}

+ (void)sp_hideHUD:(BOOL)animated delay:(float)seconds;
{
    UIView *v = SP_GET_TOP_VC.view;
    [self sp_hideHUDInView:v delay:seconds animated:animated];
}

+ (void)sp_hideHUDInView:(UIView *)view delay:(float)seconds animated:(BOOL)animated
{
    sp_run_in_main_thread(hideHUD(view, seconds, animated));
}

@end
