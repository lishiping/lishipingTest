//
//  SPSocketManager.m
//  lishipingTest
//
//  Created by 164749 on 2018/12/27.
//  Copyright © 2018年 shiping1. All rights reserved.
//

#import "SPSocketManager.h"

@implementation SPSocketManager

+ (instancetype)sharedInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

@end
