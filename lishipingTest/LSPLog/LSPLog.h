//
//  LSPLog.h
//  lishipingTest
//
//  Created by lishiping on 2020/5/23.
//  Copyright © 2020 lishiping. All rights reserved.
//  带有控制台打印和日志写入沙盒的日志功能组件,日志写入部分功能是由CocoaLumberjack提供
//  使用类方法的好处是防止外部更改里面的参数，而且不用初始化创建实例，只需要用的时候调用就行

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/CocoaLumberjack.h>

//通过在ApolloApi.framework的info.plist的isOpenLog开启和关闭日志功能
//#define LSP_IS_OPEN_LOG [[[NSBundle bundleWithIdentifier:@"com.banyu.koolearn.ApolloApi"] objectForInfoDictionaryKey:@"isOpenLog"] isEqualToString:@"true"]

//目前定义为只在DEBUG下开启这种日志本地写入系统功能，而且要个测试打包的时候都打成debug包，只有发布线上的时候才发release
#ifdef DEBUG

#define LSP_IS_OPEN_LOG YES

#else

#define LSP_IS_OPEN_LOG NO

#endif

#ifdef DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelDebug;
#else
static const DDLogLevel ddLogLevel = DDLogLevelDebug;
#endif

#define LSP_IS_OPEN_LOG_CONFIG [LSPLog config]

#ifdef LSP_IS_OPEN_LOG_CONFIG

//超级log日志，带有文件，行数，函数名的日志写入系统,可以写入.log文件，可以控制台打印，可以console打印
#define LSP_SUPER_LOG(...) {\
\
if ([LSPLog config]) {\
DDLogDebug(@"\n file:%s,\n line:%d,\n func:%s,\n %@\n\n", [[NSString stringWithFormat:@"%s", __FILE__].lastPathComponent UTF8String] ,__LINE__,__FUNCTION__, [NSString stringWithFormat:__VA_ARGS__]);\
[LSPLog consoleLog:[NSString stringWithFormat:@"time:%@ file:%s, line:%d, func:%s,\n%@\n",LSPLog.sp_stringDate, [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent.UTF8String ,__LINE__,__FUNCTION__, [NSString stringWithFormat:__VA_ARGS__]]];\
}\
}

#else

#define LSP_SUPER_LOG(...)

#endif


NS_ASSUME_NONNULL_BEGIN

@interface LSPLog : NSObject

/// 判断是否开启日志，并创建了日志文件
+(BOOL)config;

/// 日志点存在内存中
/// @param message 日志信息
+(void)consoleLog:(NSString *_Nullable)message;

/// 获得内存中所有log点
+(NSMutableArray*)getLogs;

+ (NSString *)sp_stringDate;

@end

NS_ASSUME_NONNULL_END
