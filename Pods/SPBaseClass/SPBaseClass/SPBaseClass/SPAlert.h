//
//  SPAlert.h
//  lishipingTest
//
//  Created by shiping li on 2018/2/9.
//  Copyright © 2018年 shiping1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^SPUIAlertActionBlock)(UIAlertAction * _Nullable action);

@interface SPAlert : NSObject

/*本类的特点：
 1.如果是在ViewController类调用Alert方法建议使用ViewController+SPUIAlertViewController类别更方便，要遵循MVC模式下，尽量不让Alert被引入到非UI层（例如：网络层在底层拦截弹出警告框），这也是苹果开发文档的要求，所以苹果方面废弃了UIAlertView直接show的方式。
 2.旨在实现快捷的方法，一行代码代替了以往的创建初始化显示等过程，实现代码复用，利于可读性可维护性
 3.由于该类可以写在任何类弹出Alert，如果写在网络层等非UI层，要明确注释使用原因方便以后维护，否则后期维护艰难。
 4.方法顺序是使用频率顺序，不常用的方法作为其他常用方法的基础方法
 5.缺点只扩展了一个和两个按钮的方法，两个以上按钮的没做处理，因为多个按钮的无法控制，而且使用频率不高，可以自行创建
 */

#pragma mark - AlertView

/**
 只有标题且只有一个按钮的alertView，只有一个选择方案的（例如强制更新等）
 
 @param title 标题
 @param ok_title 按钮名字
 @param ok_block 按钮回调
 */
+(UIAlertController*_Nullable)sp_showAlertView_title:(NSString*_Nullable)title
                     ok_title:(NSString*_Nullable)ok_title
                     ok_block:(SPUIAlertActionBlock _Nullable)ok_block;

/**
 有标题有详情信息，但只有一个按钮的alertView，只有一个选择方案的（例如强制更新等）
 
 @param title 标题
 @param message 信息
 @param ok_title 按钮名字
 @param ok_block 按钮回调
 */
+(UIAlertController*_Nullable)sp_showAlertView_title:(NSString*_Nullable)title
                      message:(NSString*_Nullable)message
                     ok_title:(NSString*_Nullable)ok_title
                     ok_block:(SPUIAlertActionBlock _Nullable)ok_block;

/**
 有标题有详情信息，但只有一个按钮的alertView，加入了动画控制，带完成回调,只有一个选择方案的（例如强制更新等）
 
 @param title 标题
 @param message 信息
 @param flag 动画
 @param ok_title 按钮名字
 @param ok_block 按钮回调
 @param completion 完成回调
 */
+(UIAlertController*_Nullable)sp_showAlertView_title:(NSString*_Nullable)title
                      message:(NSString*_Nullable)message
                     animated: (BOOL)flag
                     ok_title:(NSString*_Nullable)ok_title
                     ok_block:(SPUIAlertActionBlock _Nullable)ok_block
                   completion:(void (^ __nullable)(void))completion;

/**
 快捷警告框，两个按钮
 
 @param title 标题
 @param message 信息
 @param ok_title 确认或者自定义按钮名字
 @param cancel_title 取消或者自定义按钮名字
 @param ok_block 确认或者自定义按钮回调
 @param cancel_block 取消或者自定义按钮回调
 */
+(UIAlertController*_Nullable)sp_showAlertView_title:(NSString*_Nullable)title
                      message:(NSString*_Nullable)message
                     ok_title:(NSString*_Nullable)ok_title
                 cancel_title:(NSString*_Nullable)cancel_title
                     ok_block:(SPUIAlertActionBlock _Nullable)ok_block
                 cancel_block:(SPUIAlertActionBlock _Nullable)cancel_block;

/**
 快捷的弹出警告框的方法
 
 @param title 标题
 @param message 详情信息
 @param ok_title 确定按钮或者自定义名字
 @param cancel_title 取消按钮或者自定义名字
 @param animated 动画
 @param ok_block 确定按钮或者自定义按钮回调
 @param cancel_block 取消按钮或者自定义按钮回调
 @param completion UIAlertViewController完成弹出后的回调（不用可传nil）
 */
+(UIAlertController*_Nullable)sp_showAlertView_title:(NSString*_Nullable)title
                      message:(NSString*_Nullable)message
                     ok_title:(NSString*_Nullable)ok_title
                 cancel_title:(NSString*_Nullable)cancel_title
                     animated: (BOOL)animated
                     ok_block:(SPUIAlertActionBlock _Nullable)ok_block
                 cancel_block:(SPUIAlertActionBlock _Nullable)cancel_block
                   completion:(void (^ __nullable)(void))completion;

#pragma mark - ActionSheet

/**
 快捷弹出ActionSheet控件，默认使用UIAlertActionStyleDestructive风格
 
 @param title 标题
 @param message 信息
 @param ok_title 确认或者自定义名字
 @param cancel_title 取消或者自定义名字
 @param ok_block 确认或者自定义按钮的回调
 @param cancel_block 取消或者自定义按钮的回调
 */
+(UIAlertController*_Nullable)sp_showActionSheet_title:(NSString*_Nullable)title
                        message:(NSString*_Nullable)message
                       ok_title:(NSString*_Nullable)ok_title
                   cancel_title:(NSString*_Nullable)cancel_title
                       ok_block:(SPUIAlertActionBlock _Nullable)ok_block
                   cancel_block:(SPUIAlertActionBlock _Nullable)cancel_block;

/**
 快捷弹出ActionSheet控件，默认使用UIAlertActionStyleDestructive风格
 
 @param title 标题
 @param message 信息
 @param ok_title_destructive 确认或者自定义名字
 @param cancel_title 取消或者自定义名字
 @param ok_block 确认或者自定义按钮的回调
 @param cancel_block 取消或者自定义按钮的回调
 */
+(UIAlertController*_Nullable)sp_showActionSheet_title:(NSString*_Nullable)title
                        message:(NSString*_Nullable)message
           ok_title_destructive:(NSString*_Nullable)ok_title_destructive
                   cancel_title:(NSString*_Nullable)cancel_title
                       ok_block:(SPUIAlertActionBlock _Nullable)ok_block
                   cancel_block:(SPUIAlertActionBlock _Nullable)cancel_block;

/**
 快捷弹出ActionSheet控件，默认使用UIAlertActionStyleDefault风格
 
 @param title 标题
 @param message 信息
 @param ok_title_default 确认或者自定义名字
 @param cancel_title 取消或者自定义名字
 @param ok_block 确认或者自定义按钮的回调
 @param cancel_block 取消或者自定义按钮的回调
 */
+(UIAlertController*_Nullable)sp_showActionSheet_title:(NSString*_Nullable)title
                        message:(NSString*_Nullable)message
               ok_title_default:(NSString*_Nullable)ok_title_default
                   cancel_title:(NSString*_Nullable)cancel_title
                       ok_block:(SPUIAlertActionBlock _Nullable)ok_block
                   cancel_block:(SPUIAlertActionBlock _Nullable)cancel_block;

/**
 快捷弹出ActionSheet控件，带有动画控制，默认按钮风格，以及完成的回调
 
 @param title 标题
 @param message 信息
 @param ok_title 确认或者自定义名字
 @param cancel_title 取消或者自定义名字
 @param animated 动画
 @param ok_title_style 默认按钮的风格
 @param ok_block 确认或者自定义按钮的回调
 @param cancel_block 取消或者自定义按钮的回调
 */
+(UIAlertController*_Nullable)sp_showActionSheet_title:(NSString*_Nullable)title
                        message:(NSString*_Nullable)message
                       ok_title:(NSString*_Nullable)ok_title
                   cancel_title:(NSString*_Nullable)cancel_title
                       animated: (BOOL)animated
                 ok_title_style:(UIAlertActionStyle)ok_title_style
                       ok_block:(SPUIAlertActionBlock _Nullable)ok_block
                   cancel_block:(SPUIAlertActionBlock _Nullable)cancel_block
                     completion:(void (^ __nullable)(void))completion;


@end
