//
//  XDFZXUIMenuController.h
//  LGLApolloApi
//
//  Created by lishiping on 2021/4/29.
//  Copyright © 2021 lgl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XDFZXUIMenuController : NSObject

@property(class, nonatomic, readonly) XDFZXUIMenuController *sharedMenuController;

//@property(nonatomic,getter=isMenuVisible) BOOL menuVisible;        // default is NO
- (void)insertView:(UIView*)view;
- (void)showMenuFromView:(UIView *)targetView rect:(CGRect)targetRect;
- (void)hideMenu;

//@property(nonatomic,readonly) CGRect menuFrame;

@end

NS_ASSUME_NONNULL_END
