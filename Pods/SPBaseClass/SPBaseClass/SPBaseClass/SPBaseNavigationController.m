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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //如果topViewController是我们的基类SPBaseVC及SPBaseVC的子类，控制是否右滑返回
    if ([self.topViewController isKindOfClass:[SPBaseVC class]] &&
        [self.topViewController respondsToSelector:@selector(gestureRecognizerShouldBegin:)]) {
        
        SPBaseVC *vc = (SPBaseVC *)self.topViewController;
        return [vc gestureRecognizerShouldBegin:gestureRecognizer];
    }
    //如果topViewController不是我们的基类默认开启右滑返回
    return YES;
}

@end
