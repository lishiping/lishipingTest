//
//  SPAutoPopView.h
//  jgdc
//
//  Created by lishiping on 2019/9/17.
//  Copyright © 2019 QingClass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+MJExtension.h"

@interface SPAutoPopView : UIView

/**
 盒子视图，是透明视图下方的内容
 */
@property (nonatomic, strong) UIView *boxView;

/**
 透明视图，可点击主动消失
 */
@property (nonatomic, strong) UIView *maskView;

/**
 盒子视图距离顶部间距，也就是上方半透明视图高度
 */
@property (nonatomic, assign) CGFloat marginTop;

/**
 动画时长
 */
@property (nonatomic, assign) CGFloat animateDuration;

/**
 展示动画完成回调
 */
@property (nonatomic, copy) SPBOOLBlock showAnimateCompletion;

/**
 消失动画完成回调
 */
@property (nonatomic, copy) SPBOOLBlock dismissAnimateCompletion;


/**
 初始化方法，一定要传一个盒子距离顶部的高度，这样才能显示看出视图是弹出来的

 @param marginTop 盒子视图上方间距
 @return 该自动弹出视图对象
 */
-(instancetype)initWithBoxViewMarginTop:(CGFloat)marginTop;

/**
 显示方法
 */
-(void)show;

/**
 调用小时方法
 */
-(void)dismiss;

@end
