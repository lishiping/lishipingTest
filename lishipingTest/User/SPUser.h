//
//  SPUser.h
//  lishipingTest
//
//  Created by shiping li on 2017/12/27.
//  Copyright © 2017年 shiping1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPUser : NSObject

@property(nonatomic,copy)NSString *username;//用户名字
@property(nonatomic,copy)NSString *uid; //用户id
@property(nonatomic,copy)NSString *phoneNumber;//用户电话
@property(nonatomic,assign)BOOL isGuest;//是否是游客用户

+ (instancetype)manager;

//返回当前用户
+ (SPUser*)currentUser;

//检查是否登录，如果未登录则要弹出登录页
+ (SPUser*)checkUserAndPresentLoginVC;

@end
