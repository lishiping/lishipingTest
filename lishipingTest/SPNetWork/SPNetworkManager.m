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
#import <SPSafeData.h>
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
    
//    NSURL *url = [NSURL fileURLWithPath:@"sinaweibo://gotohome?isWidget=1&luicode=%@&widgetActionType=4&lfid=iphone_widget_dongtai_171215"];
    
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
//        NSString *tempStr = [self stringForHTTPBySortParameters:parameters];
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


//对请求参数排序并生成字符串，为了计算md5值
- (NSString *)stringForHTTPBySortParameters:(NSDictionary*)param;
{
    NSString *ret = nil;
    NSArray *arr = [self sortedParametersKey:param];
    if (arr.count > 0)
    {
        NSMutableArray *mArr = [NSMutableArray array];
        
        for (NSString *key in arr)
        {
            NSString *str = [NSString stringWithFormat:@"%@=%@", key, [param safe_stringForKey:key]];
            [mArr addObject:str];
        }
        
        //数组中间加上地址符
        ret = [mArr componentsJoinedByString:@"&"];
    }
    return ret;
}

//对参数的key排序有时候为了计算参数的md5值与服务端统一所以要排序
- (NSArray *)sortedParametersKey:(NSDictionary*)param;
{
    // 对字典key排序，保证param的顺序不影响最后结果
    NSArray *arr = [[param allKeys] sortedArrayWithOptions:NSSortConcurrent
                                           usingComparator:^NSComparisonResult(id obj1, id obj2){
                                               if (([obj1 isKindOfClass:[NSString class]]) &&
                                                   ([obj2 isKindOfClass:[NSString class]]))
                                               {
                                                   return ([obj1 compare:obj2]);
                                               }
                                               return (NSOrderedSame);
                                           }];
    return arr;
}


@end
