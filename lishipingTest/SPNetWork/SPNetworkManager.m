//
//  SPNetworkManager.m
//  lishipingTest
//
//  Created by shiping1 on 2017/12/6.
//  Copyright © 2017年 shiping1. All rights reserved.
//

#import "SPNetworkManager.h"
#import <AFHTTPSessionManager.h>
#import <SPMacro.h>

@implementation SPNetworkManager

+ (instancetype)manager
{
    static SPNetworkManager *gs_manager = nil;
    if (!gs_manager)
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            gs_manager = [[[self class] alloc] init];
        });
    }
    return gs_manager;
}

-(void)defaultConfig
{
    self.timeoutInterval =15;
    self.host = @"";
}


-(NSURLSessionDataTask*)getWithPath:(NSString *)path parameters:(NSDictionary *)parameters completionBlock:(void (^)(NSURLSessionDataTask *, id _Nullable, NSError * _Nullable))completionBlock
{
    
    return [self getWithPath:path host:self.host parameters:parameters completionBlock:completionBlock];
}

-(NSURLSessionDataTask*)getWithPath:(NSString *)path
                               host:(NSString *)host
                         parameters:(NSDictionary *)parameters
                    completionBlock:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject, NSError * _Nullable error))completionBlock
{
    SP_ASSERT_CLASS(path, NSString);
    SP_ASSERT_CLASS(host, NSString);
    
    if (!host || host.length==0) {
        host = self.host;
    }
    
    NSString *urlStr = host;
    if (path.length>0) {
        urlStr = [urlStr stringByAppendingPathComponent:path];
    }
    
    if (urlStr.length==0) {
        completionBlock(nil,nil,[NSError errorWithDomain:@"url is nil" code:-2 userInfo:nil]);
    }
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    return [manager GET:url.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"错误 = %@",[responseObject description]);
        completionBlock(task,responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"错误 = %@",error);
        completionBlock(task,nil,error);
    }];
}

-(NSURLSessionDataTask*)postWithPath:(NSString *)path parameters:(NSDictionary *)parameters completionBlock:(void (^)(NSURLSessionDataTask *, id _Nullable, NSError * _Nullable))completionBlock
{
    return [self postWithPath:path host:self.host parameters:parameters completionBlock:completionBlock];
}

-(NSURLSessionDataTask*)postWithPath:(NSString *)path
                                host:(NSString *)host
                          parameters:(NSDictionary *)parameters
                     completionBlock:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject, NSError * _Nullable error))completionBlock
{
    SP_ASSERT_CLASS(path, NSString);
    SP_ASSERT_CLASS(host, NSString);
    
    NSString *urlStr = host;
    if (path.length>0) {
        urlStr = [urlStr stringByAppendingPathComponent:path];
    }
    
    if (urlStr.length==0) {
        completionBlock(nil,nil,[NSError errorWithDomain:@"url is nil" code:-2 userInfo:nil]);
    }
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    return  [manager POST:url.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"响应 = %@",responseObject);
        completionBlock(task,responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"错误 = %@",error);
        completionBlock(task,nil,error);
    }];
}

+ (NSString*)queryStringFromBaseURL:(NSString*)baseURL parameters:(NSDictionary*)param encoding:(NSStringEncoding)encoding
{
    NSMutableArray *resultArray = [NSMutableArray array];
    [param enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([key isKindOfClass:[NSString class]])
        {
            [resultArray addObject:[NSString stringWithFormat:@"%@=%@",key,[obj description]]];
        }
    }];
    NSString *resultString = [resultArray componentsJoinedByString:@"&"];
    
    if ([baseURL rangeOfString:@"?"].location == NSNotFound)
    {
        resultString = [NSString stringWithFormat:@"%@?%@",baseURL,resultString];
    }
    else
    {
        resultString = [NSString stringWithFormat:@"%@%@",baseURL,resultString];
    }
    return [resultString stringByReplacingPercentEscapesUsingEncoding:encoding];
}

- (NSArray *)defaultURLKey:(NSDictionary*)param;
{
    // 对字典key排序，保证param的顺序不影响最后结果
    NSArray *arr = [[param allKeys] sortedArrayWithOptions:NSSortConcurrent
                                           usingComparator:^NSComparisonResult(id obj1, id obj2){
                                               if (([obj1 isKindOfClass:[NSString class]]) && ([obj2 isKindOfClass:[NSString class]]))
                                               {
                                                   return ([obj1 compare:obj2]);
                                               }
                                               return (NSOrderedSame);
                                           }];
    
    return arr;
}

@end
