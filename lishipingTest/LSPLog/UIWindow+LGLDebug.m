//
//  UIWindow+LGLDebug.m
//  LGLApolloApi
//
//  Created by lishiping on 2021/1/14.
//  Copyright © 2021 lgl. All rights reserved.
//  无侵入式在window上增加调试工具
// 只在debug下开启日志实时显示功能和工具条功能

#if DEBUG

#import "UIWindow+LGLDebug.h"


#import "LSPLog.h"
#import "LSPDebugView.h"
#import <objc/runtime.h>
#import <XDFZXDebugTools_iOS/LLDebug.h>
#import <XDFZXDebugTools_iOS/LLWindowManager.h>
#import "LGLEnvConfig.h"
#import <SPFastPush/SPFastPush.h>
#import "AKLMainViewController.h"

//#endif

@interface UIWindow (LGLDebug)

@property(nonatomic,strong)LSPDebugView *lgl_debugView;

@end

@implementation UIWindow (LGLDebug)

//#if DEBUG
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[self class] lgl_swizzleInstanceMethodWithOriginSel:@selector(makeKeyAndVisible) swizzledSel:@selector(lgl_makeKeyAndVisible)];
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

- (void)lgl_makeKeyAndVisible {
    [self lgl_makeKeyAndVisible];
    [self lglDebug_configDebugTool];
}

-(void)lglDebug_configDebugTool{
    //三指长按弹出实时打印
    UILongPressGestureRecognizer *Long3 =[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showDebugView)];
    Long3.numberOfTouchesRequired = 3;
    [self addGestureRecognizer:Long3];
    
    //五指长按弹出工具条
    UILongPressGestureRecognizer *Long5 =[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showDebugTool)];
    Long5.numberOfTouchesRequired = 5;
    [self addGestureRecognizer:Long5];
    
    //四指长按隐藏工具条
    UILongPressGestureRecognizer *Long4 =[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(hideDebugTool)];
    Long4.numberOfTouchesRequired = 4;
    [self addGestureRecognizer:Long4];
    
    [self loadLLDebugTool];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configLLDebugToolIPAddress) name:@"lgl_viewWillAppear" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeAll) name:@"lgl_viewWillDisappear" object:nil];
}

#pragma mark - 工具条
-(void)loadLLDebugTool
{
    //lsp加入超级调试工具
    [LLConfig shared].entryWindowStyle = LLConfigEntryWindowStyleTitle;//默认浮窗样式条
    [LLConfig shared].shrinkToEdgeWhenInactive =NO;//不活跃不收缩
    //    [LLConfig shared].pingIPAddress =@"10.155.19.154";//测试延迟地址
//    [LLConfig shared].pingIPAddress =[LGLEnvConfig signalServer];//测试延迟地址
    [LLConfig shared].hideWhenInstall = YES;
    [LLConfig shared].doubleClickAction = LLDebugToolActionSandbox;//双击弹出文件模块
    [LLConfig shared].shakeToHide = NO;//摇动显示调试工具关闭
    [[LLDebugTool sharedTool] startWorking];
}

-(void)configLLDebugToolIPAddress
{
    //必须进入教室再执行要不然地址不准确
    [LLConfig shared].pingIPAddress =[LGLEnvConfig signalServer];//测试延迟地址
}

-(BOOL)isCanShowTool
{
    //为了不让工具侵入到其他页面，所以只有进入云教室才会显示,判断当前页面是云教室
    BOOL ret = NO;
    if ([[SPFastPush topVC] isMemberOfClass:AKLMainViewController.class]) {
        ret = YES;
    }
    return ret;
}

-(void)showDebugTool
{
    if (![self isCanShowTool]) {
        return;
    }
    if (!LLWindowManager.shared.isWindowShowed) {
        [[LLWindowManager shared] showEntryWindow];
    }
}

-(void)hideDebugTool
{
    [[LLWindowManager shared] hideEntryWindow];
}

-(void)removeAll
{
    [self hideDebugTool];
    if (self.lgl_debugView.superview) {
        [self.lgl_debugView removeFromSuperview];
    }
}
#pragma mark - 日志打印工具
- (void)showDebugView {
    if (![self isCanShowTool]) {
        return;
    }
    if (self.lgl_debugView.superview) {
        return;
    }
    if (!self.lgl_debugView) {
        self.lgl_debugView = [[LSPDebugView alloc] initWithFrame:CGRectMake(0, 0, LSPDebugView_Width, LSPDebugView_Height)];
        [self.lgl_debugView addLog:[LSPLog getLogs]];
    }
    [self addSubview:self.lgl_debugView];
    [self bringSubviewToFront:self.lgl_debugView];
}

- (LSPDebugView *)lgl_debugView
{
    return objc_getAssociatedObject(self, @selector(lgl_debugView));
}

- (void)setLgl_debugView:(LSPDebugView *)lgl_debugView
{
    objc_setAssociatedObject(self,
                             @selector(lgl_debugView),
                             lgl_debugView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end

#endif
