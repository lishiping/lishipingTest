//
//  LSPLog.m
//  lishipingTest
//
//  Created by lishiping on 2020/5/23.
//  Copyright © 2020 lishiping. All rights reserved.
//

#import "LSPLog.h"
#import "LSPLogFileManager.h"

static BOOL gs_isConfig;
static NSMutableArray *gs_logMArr;

@implementation LSPLog

+(void)createLogFile
{
    // 添加DDASLLogger，你的日志语句将被发送到Xcode控制台
//    [DDLog addLogger:[DDTTYLogger sharedInstance]];

    // 添加DDTTYLogger，你的日志语句将被发送到Console.app
    [DDLog addLogger:[DDASLLogger sharedInstance]];

    //添加DDFileLogger，你的日志语句将写入到一个文件中，默认路径在沙盒的Library/Caches/Logs/目录下，文件名为bundleid+空格+日期.log。
    //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    //NSString *logsDirectory = [baseDir stringByAppendingPathComponent:@"Logs"];

    //自定义文件路径，路径Document文件夹，因为这个文件可以使用iTunes导出文件
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    LSPLogFileManager *file = [[LSPLogFileManager alloc] initWithLogsDirectory:path];
    DDFileLogger *fileLogger = [[DDFileLogger alloc] initWithLogFileManager:file];
    fileLogger.automaticallyAppendNewlineForCustomFormatters = YES;//每行日志加换行
    //下面用默认的
//    [fileLogger setMaximumFileSize:(1024 * 1024 * 10)];//最大10MB
//    fileLogger.rollingFrequency = 60 * 60 * 24;//24小时新建一个文件
//    fileLogger.logFileManager.maximumNumberOfLogFiles = 3;//最多个文件
    [DDLog addLogger:fileLogger];
    
    gs_logMArr = [[NSMutableArray alloc] init];
}

+(BOOL)config
{
    if (LSP_IS_OPEN_LOG && !gs_isConfig) {
        //开启日志，创建文件
        gs_isConfig = YES;
        [self createLogFile];
    }
    return LSP_IS_OPEN_LOG;
}


+(void)consoleLog:(NSString *)log
{
    if ([log isKindOfClass:NSString.class] && log.length > 0) {
        @synchronized (self) {
            //写入内存缓存
            [gs_logMArr addObject:log];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"lsplog_refresh" object:log];
        }
    }
}

+(NSMutableArray*)getLogs
{
    return gs_logMArr;
}

+ (NSString *)sp_stringDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss.SSS"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    return dateString;
}

@end
