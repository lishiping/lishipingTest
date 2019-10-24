//
//  SPHUD.h
//  lishipingTest
//
//  Created by shiping li on 2018/2/9.
//  Copyright © 2018年 shiping1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface SPHUD : NSObject

/*本类别的特点：
 1.旨在实现快捷的显示方法，一个方法代替了以往的创建初始化显示等过程，实现代码复用，利于可读性可维护性
 2.如果是在ViewController类调用SPHUD方法建议使用ViewController+SPHUD类别更方便，要遵循MVC模式下，尽量不让SPHUD被引入到非UI层（例如：网络层在底层拦截弹出警告框）。
 3.由于该类可以写在任何类弹出SPHUD，如果写在网络层等非UI层，要明确注释使用原因方便以后维护，否则后期维护艰难。
 4.方法顺序是使用频率顺序，不常用的方法作为其他常用方法的基础方法
 */

/*
 Here is based on the MBProgressHUD categories can be used directly, not add to the self. The view above;Direct use of [self sp_showPrompt: @ "login succeeds"].
 
 这里是在MBProgressHUD基础上可以直接使用的类别，不用在加到self.view上面；
 直接使用 [self sp_showPrompt:@"登录成功"];
 */

/*****************sp_showPrompt(显示提示消息)*********************/

+ (void)sp_showToast:(NSString *)message;//不建议使用，只是为了跟安卓对应的单词
+ (void)sp_showPrompt:(NSString *)message;
+ (void)sp_showPrompt:(NSString *)message delayHide:(float)seconds;
+ (void)sp_showPromptAddWindow:(NSString *)message;

/*****************sp_showHUD(显示活动指示器)*********************/
+ (void)sp_showHUD;
+ (void)sp_showHUD:(NSString *)message;
+ (void)sp_showHUD:(NSString *)message animation:(BOOL)animated;

+ (void)sp_showHUDInView:(UIView *)superView
                 message:(NSString *)message
               animation:(BOOL)animated;

+ (void)sp_updateHUDMessage:(NSString *)message;

/*****************sp_showHUDGIF(显示GIF图片)*********************/

+ (void)sp_showHUDGIF_name:(NSString *)gifNameInBundleStr;

+ (void)sp_showHUDGIF_name:(NSString *)gifNameInBundleStr
                      text:(NSString *)text
                detailText:(NSString *)detailText;

+ (void)sp_showHUDGIF_name:(NSString *)gifNameInBundleStr
                      text:(NSString *)text
                detailText:(NSString *)detailText
                 delayHide:(float)seconds;

+ (void)sp_showHUDGIF_data:(NSData *)gifData
                      text:(NSString *)text
                detailText:(NSString *)detailText;

+ (void)sp_showHUDGIF_data:(NSData *)gifData
                      text:(NSString *)text
                detailText:(NSString *)detailText
                 delayHide:(float)seconds;

/*****************sp_showHUDCustomView(显示自定义视图)*********************/
+ (void)sp_showHUDCustomView:(UIView *)customV;

+ (void)sp_showHUDCustomView:(UIView *)customV
                        text:(NSString *)text
                  detailText:(NSString *)detailText;

+ (void)sp_showHUDCustomView:(UIView *)customV
                        text:(NSString *)text
                  detailText:(NSString *)detailText
                   delayHide:(float)seconds;


/*****************sp_showMBProgressHUD(显示自定义指示器)*********************/
+ (void)sp_showMBProgressHUD:(NSString *)message
                        mode:(MBProgressHUDMode)mode
                    progress:(float)progress
                   animation:(BOOL)animated;

/**
 快捷显示MBProgressHUD
 
 @param message 显示信息
 @param mode 显示模式
 
 
 /// UIActivityIndicatorView.（默认模式, 系统自带的指示器）
 MBProgressHUDModeIndeterminate,
 
 /// A round, pie+chart like, progress view.（圆形饼图）
 MBProgressHUDModeDeterminate,
 
 /// Horizontal progress bar.（水平进度条）
 MBProgressHUDModeDeterminateHorizontalBar,
 
 /// Ring+shaped progress view.（圆环）
 MBProgressHUDModeAnnularDeterminate,
 
 /// Shows a custom view.（自定义视图）
 MBProgressHUDModeCustomView,
 
 /// Shows only labels.（只显示文字）
 MBProgressHUDModeText
 
 @param progress 进度
 
 @param animated 动画
 
 @param font 文本字体
 
 @param textColor 文本颜色
 
 @param bezelViewColor hud块背景色
 
 @param backgroundColor 全屏整体背景色
 
 */
+ (void)sp_showMBProgressHUD:(NSString *)message
                        mode:(MBProgressHUDMode)mode
                    progress:(float)progress
                   animation:(BOOL)animated
                        font:(UIFont*)font
                   textColor:(UIColor*)textColor
              bezelViewColor:(UIColor*)bezelViewColor
             backgroundColor:(UIColor*)backgroundColor;


/*****************hide(隐藏指示器)*********************/
+ (void)sp_hideHUD;
+ (void)sp_hideHUD:(BOOL)animated;
+ (void)sp_hideHUD:(BOOL)animated delay:(float)seconds;
+ (void)sp_hideHUDInView:(UIView *)view delay:(float)seconds animated:(BOOL)animated;

@end
