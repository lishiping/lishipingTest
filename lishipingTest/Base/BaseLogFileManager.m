//
//  BaseLogFileManager.m
//  lishipingTest
//
//  Created by lishiping on 2020/5/23.
//  Copyright © 2020 lishiping. All rights reserved.
//

#import "BaseLogFileManager.h"

@implementation BaseLogFileManager

-(NSString *)newLogFileName {
    NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
    NSString *timeStamp = [self getTimestamp];

    return [NSString stringWithFormat:@"%@_ClassRoomSDK_%@.log", appName, timeStamp];
}
-(NSString*)logFileHeader
{
    return @"这里是阿波罗教室日志系统\n\n";
}

-(BOOL)isLogFile:(NSString *)fileName {
    return NO;
}

-(NSString *)getTimestamp {
    static dispatch_once_t onceToken;
    static NSDateFormatter *dateFormatter;
    dispatch_once(&onceToken, ^{
        dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"YYYY.MM.dd-HH:mm:ss"];
    });

    return [dateFormatter stringFromDate:NSDate.date];
}

@end
