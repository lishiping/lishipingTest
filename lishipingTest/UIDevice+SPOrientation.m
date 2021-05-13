//
//  UIDevice+SPOrientation.m
//  ApolloApi
//
//  Created by lishiping on 2020/8/3.
//  Copyright © 2020 wangpeng. All rights reserved.
//

#import "UIDevice+SPOrientation.h"

@implementation UIDevice (SPOrientation)

+(void)forcedRotate:(UIInterfaceOrientation)orientation
{
    //使用消息转发强制旋转屏幕
    SEL selector = NSSelectorFromString(@"setOrientation:");
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
    [invocation setSelector:selector];
    [invocation setTarget:[UIDevice currentDevice]];
    //    int val = orientation;//旋转的方向
    [invocation setArgument:&orientation atIndex:2];
    [invocation invoke];
}

@end
