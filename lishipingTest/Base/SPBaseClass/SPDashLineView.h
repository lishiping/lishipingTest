//
//  SPDashLineView.h
//  BaseLibs
//
//  Created by shiping li on 2018/5/29.
//

/*本类是绘制虚线和实线直线的类*/

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SPLineTypeDashLineDefault,//默认虚线
    SPLineTypeStraightLine//实线
} WBLineType;

@interface SPDashLineView : UIView
// 如果不指定 lineType，默认绘制虚线，否则为实线
@property (nonatomic, assign) WBLineType lineType;

/**
 线条宽度 lineWidth 默认 1
 线条颜色 lineColor 默认 blackColor
 偏移点数 movePoint 默认 0
 绘制点数 drawPoint 默认 5
 跳过点数 stepPoint 默认 3
 
 当视图宽大于高，水平虚线
 当视图高大于宽，竖直虚线
 当视图宽高相等，竖直虚线
 */
@property (nonatomic, assign)  CGFloat  lineWidth;
@property (nonatomic, strong)  UIColor *lineColor;
@property (nonatomic, assign)  CGFloat  movePoint;
@property (nonatomic, assign)  CGFloat  drawPoint;
@property (nonatomic, assign)  CGFloat  stepPoint;

@end
