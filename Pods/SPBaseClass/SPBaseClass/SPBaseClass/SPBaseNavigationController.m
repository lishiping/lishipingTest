//
//  SPBaseNavigationController.m
//  e-mail:83118274@qq.com
//
//  Created by lishiping on 16/11/11.
//  Copyright (c) 2016年 lishiping. All rights reserved.
//
//If you think this open source library is of great help to you, please open the URL to click the Star,your approbation can encourage me, the author will publish the better open source library for guys again
//如果您认为本开源库对您很有帮助，请打开URL给作者点个赞，您的认可给作者极大的鼓励，作者还会发布更好的开源库给大家

//github address//https://github.com/lishiping/SPWebView
//github address//https://github.com/lishiping/SPDebugBar
//github address//https://github.com/lishiping/SPFastPush
//github address//https://github.com/lishiping/SPMacro
//github address//https://github.com/lishiping/SafeData
//github address//https://github.com/lishiping/SPCategory
//github address//https://github.com/lishiping/SPBaseClass

#import "SPBaseNavigationController.h"
#import "SPBaseVC.h"

@interface SPBaseNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation SPBaseNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
}

//控制右滑手势返回上一页的方法
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //因为这个右滑手势是针对于NavigationController的功能，故我们这里在NavigationController实现
    if ([self.topViewController respondsToSelector:@selector(gestureRecognizerShouldBegin:)]) {
        //如果topViewController是我们的基类SPBaseVC及SPBaseVC的子类，控制是否右滑返回
        if ([self.topViewController isKindOfClass:SPBaseVC.class])
        {
            SPBaseVC *vc = (SPBaseVC *)self.topViewController;
            return [vc gestureRecognizerShouldBegin:gestureRecognizer];
        }else
        {
            //那如果其他的ViewController实现了UIGestureRecognizerDelegate协议里面的gestureRecognizerShouldBegin方法，也会执行识别到检测是否可以右滑返回
            return [self.topViewController performSelector:@selector(gestureRecognizerShouldBegin:) withObject:gestureRecognizer]?YES:NO;
        }
    }
    //如果topViewController不能检测到这个方法默认开启右滑返回
    return YES;
}

@end
