//
//  SPAppDelegate.h
//  Wing
//
//  Created by lishiping on 2017/12/28.
//  Copyright © 2017年 AMAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//SPAppManager

/**
 遵循UIApplicationDelegate协议；
 微APP，类似于AppDelegate
 单例，在被第⼀次调⽤时创建；
 职责：响应⽣命周期
 */
@interface SPAppDelegate : UIResponder

+ (instancetype)sharedInstance;

@end

