//
//  SPAutoPopView.m
//  jgdc
//
//  Created by lishiping on 2019/9/17.
//  Copyright © 2019 QingClass. All rights reserved.
//

#import "SPAutoPopView.h"

@interface SPAutoPopView ()

@end

@implementation SPAutoPopView

- (instancetype)initWithBoxViewMarginTop:(CGFloat)marginTop
{
    if (self = [super init]) {
        self.marginTop = marginTop;
        self.animateDuration=0.2f;
        self.frame = SP_SCREEN_BOUND;
        self.maskView = [[UIView alloc] initWithFrame:self.bounds];
        self.maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
        [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGuesture:)]];
        [self addSubview:self.maskView];
        
        self.boxView = [[UIView alloc] initWithFrame:CGRectMake(0, SP_SCREEN_HEIGHT,SP_SCREEN_WIDTH, SP_SCREEN_HEIGHT-marginTop)];
        self.boxView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.boxView];
    }
    return self;
}

- (void)handleGuesture:(UITapGestureRecognizer *)sender {
    [self dismissAnimateWithCompletion:nil];
}

-(void)show
{
    [self showAnimateWithCompletion:self.showAnimateCompletion];
}

-(void)dismiss
{
    [self dismissAnimateWithCompletion:self.dismissAnimateCompletion];
}

- (void)showAnimateWithCompletion:(SPBOOLBlock)completion
{
    [SP_GET_ROOT_VC.view addSubview:self];
    [UIView animateWithDuration:self.animateDuration
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.boxView.mj_y = SP_SCREEN_HEIGHT-self.boxView.mj_h;
                     }
                     completion:completion];
}

- (void)dismissAnimateWithCompletion:(SPBOOLBlock)completion
{
    [UIView animateWithDuration:self.animateDuration
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.boxView.mj_y = SP_SCREEN_HEIGHT;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                         if (completion) {
                             completion(finished);
                         }
                     }];
}

@end





