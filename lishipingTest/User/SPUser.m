//
//  SPUser.m
//  lishipingTest
//
//  Created by shiping li on 2017/12/27.
//  Copyright © 2017年 shiping1. All rights reserved.
//

#import "SPUser.h"

@implementation SPUser


+ (instancetype)manager
{
    static SPUser *gs_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gs_manager = [[[self class] alloc] init];
    });
    return gs_manager;
}

+ (SPUser*)currentUser
{
   return [SPUser manager];
}

@end
