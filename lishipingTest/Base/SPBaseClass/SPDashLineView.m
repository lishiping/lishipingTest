//
//  SPDashLineView.m
//  BaseLibs
//
//  Created by shiping li on 2018/5/29.
//

#import "SPDashLineView.h"

@implementation SPDashLineView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        // 由于设置的是直线或虚线，直接设置背景颜色为透明
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef context  = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGFloat width  = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    if (width > height)
    {
        CGPathMoveToPoint(path, nil, 0, height / 2.f);
        CGPathAddLineToPoint(path, nil, width, height / 2.f);
    }
    else
    {
        CGPathMoveToPoint(path, nil, width / 2.f, 0);
        CGPathAddLineToPoint(path, nil, width / 2.f, height);
    }
    
    CGContextAddPath(context, path);
    //设置虚线颜色
    CGContextSetStrokeColorWithColor(context, self.lineColor ? self.lineColor.CGColor : [UIColor blackColor].CGColor);
    //设置虚线宽度
    CGContextSetLineWidth(context, self.lineWidth == 0 ? 1 : self.lineWidth);
    
    if (self.lineType == SPLineTypeDashLineDefault)
    {
        //设置虚线排列的宽度间隔:下面的arr中的数字表示先绘制5个点再绘制3个点
        CGFloat lengths[2] = {self.drawPoint == 0 ? 5 : self.drawPoint, self.stepPoint == 0 ? 3 : self.stepPoint};
        //下面最后一个参数“2”代表排列的个数。
        CGContextSetLineDash(context, self.movePoint == 0 ? 0 : -self.movePoint, lengths, 2);
    }
    
    CGContextDrawPath(context, kCGPathFillStroke);
}

- (void)setLineType:(WBLineType)lineType
{
    _lineType = lineType;
    [self setNeedsDisplay];
}

- (void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
    [self setNeedsDisplay];
}

- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    [self setNeedsDisplay];
}

- (void)setMovePoint:(CGFloat)movePoint
{
    _movePoint = movePoint;
    [self setNeedsDisplay];
}

- (void)setDrawPoint:(CGFloat)drawPoint
{
    _drawPoint = drawPoint;
    [self setNeedsDisplay];
}

- (void)setStepPoint:(CGFloat)stepPoint
{
    _stepPoint = stepPoint;
    [self setNeedsDisplay];
}

@end
