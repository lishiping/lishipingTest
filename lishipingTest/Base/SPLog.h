//
//  SPLog.h
//  lishipingTest
//
//  Created by shiping li on 2020/5/23.
//  Copyright © 2020 shiping1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/CocoaLumberjack.h>
#import <SPMacro.h>

#ifdef DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelDebug;
#else
static const DDLogLevel ddLogLevel = DDLogLevelDebug;
#endif

//#if DEBUG
//
//#define LSP_SUPER_LOG(...) SP_SUPER_LOG(...)
//
//#else

//超级log日志，带有文件，行数，函数名的日志写入系统
#define LSP_SUPER_LOG(...) {\
\
if ([SPLog config]) {\
DDLogDebug(@"\n file:%s,\n line:%d,\n function:%s,\n %@\n\n", [[NSString stringWithFormat:@"%s", __FILE__].lastPathComponent UTF8String] ,__LINE__,__FUNCTION__, [NSString stringWithFormat:__VA_ARGS__]);\
}\
}




//#endif


NS_ASSUME_NONNULL_BEGIN

@interface SPLog : NSObject

+(BOOL)config;

@end

NS_ASSUME_NONNULL_END
