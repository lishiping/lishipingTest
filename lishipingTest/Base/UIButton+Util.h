//
//  UIButton+Util.h
//  jgdc
//
//  Created by QingClass on 2018/11/13.
//  Copyright © 2018 QingClass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Util)

// 按钮延时多少秒出发点击事件(防止重复点击)
//@property (nonatomic, assign) NSTimeInterval j_eventInterval;

/**
 *  同时设置按钮的两种状态下的图片
 */
- (void)setImageForAllStateWithImage:(UIImage *)image;
/**
 *  同时设置按钮的两种状态下的图片
 */
- (void)setImageForAllStateWithImageName:(NSString *)imageName;

/**
 *  同时设置按钮的两种状态下的文字
 */
- (void)setTitleForAllStateWithString:(NSString *)title;

/**
 *  同时设置按钮的两种状态下的文字颜色
 */
- (void)setTitleColorForAllStateWithColor:(UIColor *)color;


@end

