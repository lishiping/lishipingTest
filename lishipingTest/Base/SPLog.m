//
//  SPLog.m
//  lishipingTest
//
//  Created by shiping li on 2020/5/23.
//  Copyright © 2020 shiping1. All rights reserved.
//

#import "SPLog.h"
#import "BaseLogFileManager.h"

@implementation SPLog

+(void)initialize
{
    // 添加DDASLLogger，你的日志语句将被发送到Xcode控制台
//    [DDLog addLogger:[DDTTYLogger sharedInstance]];

    // 添加DDTTYLogger，你的日志语句将被发送到Console.app
    [DDLog addLogger:[DDASLLogger sharedInstance]];

    // 添加DDFileLogger，你的日志语句将写入到一个文件中，默认路径在沙盒的Library/Caches/Logs/目录下，文件名为bundleid+空格+日期.log。
    //自定义文件路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *baseDir = paths.firstObject;
    NSString *logsDirectory = [baseDir stringByAppendingPathComponent:@"Logs"];
    BaseLogFileManager *file = [[BaseLogFileManager alloc] initWithLogsDirectory:logsDirectory];

    DDFileLogger *fileLogger = [[DDFileLogger alloc] initWithLogFileManager:file];
    [fileLogger setMaximumFileSize:(1024 * 1024)];
    fileLogger.rollingFrequency = 60 * 60 * 24;//24小时新建一个文件
    fileLogger.automaticallyAppendNewlineForCustomFormatters = YES;//每行日志加换行
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;//最多七个文件
    [DDLog addLogger:fileLogger];
}

+(BOOL)config
{
    return YES;
}

@end
