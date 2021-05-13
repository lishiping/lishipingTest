//
//  AKLMainViewController+LGLDebug.m
//  LGLApolloApi
//
//  Created by lishiping on 2021/1/19.
//  Copyright © 2021 lgl. All rights reserved.
//

#import "AKLMainViewController+LGLDebug.h"

#if DEBUG
#import <objc/runtime.h>
#endif

@implementation AKLMainViewController (LGLDebug)

#if DEBUG
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[self class] lgl_swizzleInstanceMethodWithOriginSel:@selector(viewWillAppear:) swizzledSel:@selector(lgl_viewWillAppear:)];
    [[self class] lgl_swizzleInstanceMethodWithOriginSel:@selector(viewWillDisappear:) swizzledSel:@selector(lgl_viewWillDisappear:)];
    });
}

+ (void)lgl_swizzleInstanceMethodWithOriginSel:(SEL)oriSel swizzledSel:(SEL)swiSel {
    Method originAddObserverMethod = class_getInstanceMethod(self, oriSel);
    Method swizzledAddObserverMethod = class_getInstanceMethod(self, swiSel);
    if (!originAddObserverMethod || !swizzledAddObserverMethod) {
        return;
    }
    method_exchangeImplementations(originAddObserverMethod, swizzledAddObserverMethod);
}

- (void)lgl_viewWillAppear:(BOOL)animated
{
    [self lgl_viewWillAppear:animated];
    //页面消失发送通知隐藏工具条
    [[NSNotificationCenter defaultCenter] postNotificationName:@"lgl_viewWillAppear" object:nil];
}

- (void)lgl_viewWillDisappear:(BOOL)animated
{
    [self lgl_viewWillDisappear:animated];
    //页面消失发送通知隐藏工具条
    [[NSNotificationCenter defaultCenter] postNotificationName:@"lgl_viewWillDisappear" object:nil];
}

#endif

@end
