//
//  XDFZXUIMenuController.m
//  LGLApolloApi
//
//  Created by lishiping on 2021/4/29.
//  Copyright © 2021 lgl. All rights reserved.
//

#import "XDFZXUIMenuController.h"

@interface XDFZXUIMenuController()

@property(nonatomic,strong) UIView *insertView;
@property(nonatomic,weak) UIView *targetView;

@end

@implementation XDFZXUIMenuController

+ (instancetype)sharedMenuController
{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

- (void)insertView:(UIView *)view
{
    self.insertView = view;
}
- (void)showMenuFromView:(UIView *)targetView rect:(CGRect)targetRect
{
    self.targetView = targetView;
    [self.targetView addSubview:self.insertView];
    self.insertView.frame = targetRect;
    [self addObserver:self forKeyPath:@"focused" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
}

- (void)hideMenu
{
    [self.insertView removeFromSuperview];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"focused"]) {
        bool isFirstResponder = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
        if (isFirstResponder) {
            [self hideMenu];
        }
    }
}

@end
