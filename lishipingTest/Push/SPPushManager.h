//
//  SPPushManager.h
//  lishipingTest
//
//  Created by shiping li on 2017/12/27.
//  Copyright © 2017年 shiping1. All rights reserved.
//

//存放推送通知相关代码

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SPPushManager : NSObject

/**
 检查通知授权状态的方法，该方法只是检查状态，注意block回调可能在子线程
 
 @param block succeed==YES,通知开启，succeed==NO,通知关闭
 */
+(void)checkNotificationAuthorizationStatusWithCompletionHandler:(void(^)(BOOL succeed))block;

@end
