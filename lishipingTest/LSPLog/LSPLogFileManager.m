//
//  LSPLogFileManager.m
//  lishipingTest
//
//  Created by lishiping on 2020/5/23.
//  Copyright © 2020 lishiping. All rights reserved.
//

#import "LSPLogFileManager.h"
#import "LSPAppInfoHelper.h"
#import "LGLApolloApiConfig.h"
#import "LGLVersionTool.h"

@implementation LSPLogFileManager

-(NSString *)newLogFileName {
    NSString *timeStamp = [self getTimestamp];
    return [NSString stringWithFormat:@"LGLApolloApi_v%@_%@.log",LGLApolloApiConfig.LGLSDKVersionString, timeStamp];
}


/// 在日志头上加入基本信息，这里是唯一和业务耦合的代码，去除这段代码，可以成一个单独的技术功能系统
-(NSString*)logFileHeader
{
    //这里加入日志头部信息，例如手机的基本信息和用户信息
    NSMutableString *mString = [NSMutableString stringWithString:@"这里是小组课教室日志系统\n\n手机信息:\n"];
    NSMutableArray *info = [[LSPAppInfoHelper shared] appInfos];

    for (NSArray *obj in info) {
        for (NSDictionary *oo in obj) {
            for (NSString *key in oo.allKeys) {
                [mString appendFormat:@"%@=%@\n",key,oo[key]];
            }
        }
    }
    
    NSArray *arrInfo = [LGLVersionTool sdkInfo];
    for (int i =0 ; i<arrInfo.count; i++) {
        [mString appendFormat:@"\n%@",arrInfo[i]];
    }
    
    [mString appendFormat:@"\n\n"];

    return mString;
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
