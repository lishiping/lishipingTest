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
    //判断有uid才有用户
    return [SPUser manager].uid.length>0?[self manager]:nil;
}

+ (SPUser*)checkUserAndPresentLoginVC
{
    if (![self currentUser]) {
        NSString *urlString =@"lishiping://login?&username=lishiping&password=123456&appear_type=0&animated=1";
        SP_APP_OPEN_URL_STRING(urlString)
        
        return nil;
    }
    else
    {
        return  [self currentUser];
    }
}

@end
