//
//  UIDevice+SPOrientation.h
//  ApolloApi
//
//  Created by lishiping on 2020/8/3.
//  Copyright © 2020 wangpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (SPOrientation)

//强制转换屏幕因为iPhone键盘的accessinputview有问题会引起横屏有问题，这个方法慎用，在特殊情况使用，屏幕旋转最好使用NavViewController类配合使用的
+(void)forcedRotate:(UIInterfaceOrientation)orientation;

@end

NS_ASSUME_NONNULL_END
