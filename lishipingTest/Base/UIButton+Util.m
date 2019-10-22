//
//  UIButton+Util.m
//  jgdc
//
//  Created by QingClass on 2018/11/13.
//  Copyright © 2018 QingClass. All rights reserved.
//

#import "UIButton+Util.h"
#import <objc/runtime.h>

//static char * const j_eventIntervalKey = "j_eventIntervalKey";
//static char * const eventUnavailableKey = "eventUnavailableKey";

//@interface UIButton (Util)

//@property (nonatomic, assign) BOOL eventUnavailable;

//@end

@implementation UIButton (Util)

//+ (void)load {
//    Method method = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
//    Method j_method = class_getInstanceMethod(self, @selector(j_sendAction:to:forEvent:));
//    method_exchangeImplementations(method, j_method);
//}
//
//#pragma mark - Action
//- (void)j_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
//    if (self.eventUnavailable == NO) {
//        self.eventUnavailable = YES;
//        [self j_sendAction:action to:target forEvent:event];
//        [self performSelector:@selector(setEventUnavailable:) withObject:@(NO) afterDelay:self.j_eventInterval];
//    }
//}
//#pragma mark - Setter & Getter
//- (NSTimeInterval)j_eventInterval {
//    return [objc_getAssociatedObject(self, j_eventIntervalKey) doubleValue];
//}
//- (void)setJ_eventInterval:(NSTimeInterval)j_eventInterval {
//    objc_setAssociatedObject(self, j_eventIntervalKey, @(j_eventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//- (BOOL)eventUnavailable {
//    return [objc_getAssociatedObject(self, eventUnavailableKey) boolValue];
//}
//- (void)setEventUnavailable:(BOOL)eventUnavailable {
//    objc_setAssociatedObject(self, eventUnavailableKey, @(eventUnavailable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}

#pragma mark - PublicMethod
/**
 *  同时设置按钮的两种状态下的图片
 */
- (void)setImageForAllStateWithImage:(UIImage *)image {
    [self setImage:image forState:UIControlStateNormal];
    [self setImage:image forState:UIControlStateHighlighted];
}
/**
 *  同时设置按钮的两种状态下的图片
 */
- (void)setImageForAllStateWithImageName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    [self setImageForAllStateWithImage:image];
}

/**
 *  同时设置按钮的两种状态下的文字
 */
- (void)setTitleForAllStateWithString:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateHighlighted];
}

/**
 *  同时设置按钮的两种状态下的颜色
 */
- (void)setTitleColorForAllStateWithColor:(UIColor *)color {
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setTitleColor:[color colorWithAlphaComponent:0.4] forState:UIControlStateHighlighted];
}

@end
