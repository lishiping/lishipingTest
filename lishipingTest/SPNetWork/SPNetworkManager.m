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
#import "SPUser.h"
#import <SPCategory/NSString+SPEnCode.h>

@interface SPNetworkManager()

@property (nonatomic, strong) AFHTTPSessionManager *  afHTTPSessionManager;//AFNHTTP网络请求对象


@end

@implementation SPNetworkManager

+ (instancetype)manager
{
    static SPNetworkManager *gs_manager = nil;
    if (!gs_manager)
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            gs_manager = [[[self class] alloc] init];
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            gs_manager.afHTTPSessionManager =manager;
            [gs_manager defaultConfig];
        });
    }
    return gs_manager;
}

//默认的设置都可以在这里设置
-(void)defaultConfig
{
    // 设置超时时间
    [self.afHTTPSessionManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    self.afHTTPSessionManager.requestSerializer.timeoutInterval = 30.0f;
    [self.afHTTPSessionManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    //设置版本
    self.appVersion = SP_APP_VERSION;
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
    
    NSString *urlStr = [self urlStringFromPath:path host:host];
    
    if (urlStr.length==0) {
        completionBlock(nil,nil,[NSError errorWithDomain:@"url is nil" code:-2 userInfo:nil]);
    }
    
    
    NSDictionary *param = [self parametersAddOther:parameters];
    
    return [self.afHTTPSessionManager GET:urlStr parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"错误 = %@",[responseObject description]);
        completionBlock(task,responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        NSLog(@"错误 = %@",error);
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
    
    NSString *urlStr = [self urlStringFromPath:path host:host];
    
    if (urlStr.length==0) {
        completionBlock(nil,nil,[NSError errorWithDomain:@"url is nil" code:-2 userInfo:nil]);
    }
    
    NSDictionary *param = [self parametersAddOther:parameters];
    
    return  [self.afHTTPSessionManager POST:urlStr parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"响应 = %@",responseObject);
        completionBlock(task,responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        NSLog(@"错误 = %@",error);
        
        //如果想要在这里做全局的错误拦截弹出页面就在这里做好了，例如
        NSString *errorurlString =[error.userInfo objectForKey:@"errorurl"];
        if (error.code==20034 && [errorurlString isKindOfClass:NSString.class] &&errorurlString.length>0)
        {
            SP_INAPP_OPEN_URL_STRING(errorurlString)
        }
        
        completionBlock(task,nil,error);
    }];
}

-(NSString*)urlStringFromPath:(NSString *)path
                         host:(NSString *)host
{
    //如果服务器地址不存在或者不是NSString等默认选择内部设定的服务器地址
    if (!host || ![host isKindOfClass:[NSString class]] || host.length==0) {
        host = self.host;
    }
    
    NSString *urlStr = host;
    if ([path isKindOfClass:[NSString class]] && path.length>0) {
        urlStr = [urlStr stringByAppendingPathComponent:path];
    }
    
    return urlStr;
}


/**
 额外的参数可以放在这里面，例如城市定位，定位信息，参数校验，版本版本信息，用户信息
 */
-(NSDictionary*)parametersAddOther:(NSDictionary*)parameters
{
    if (parameters && [parameters isKindOfClass:[NSDictionary class]])
    {
        NSMutableArray *ret = [parameters mutableCopy];
        
        [ret addObject:@{
                         @"uid":[SPUser currentUser].uid,
                         @"city":self.city,
                         @"cityID":@(self.cityID),
                         @"app_version":self.appVersion
                         }];
        
        return [ret copy];
        
//        //这一步是为了整理参数排序计算md5值校验可以选用
//        NSString *tempStr = [[NSString alloc] stringForHTTPBySortParameters:parameters];
//        tempStr.md5.lowercaseString//这个md5值可以加在参数里
        
    }
    
    return nil;
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


@end
