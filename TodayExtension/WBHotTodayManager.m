//
//  WBHotTodayManager.m
//  Weibo
//
//  Created by shiping1 on 2017/11/29.
//  Copyright © 2017年 Sina. All rights reserved.
//

#import "WBHotTodayManager.h"
#import <Security/Security.h>

@implementation WBHotTodayManager

+ (instancetype)sharedInstance
{
    static WBHotTodayManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (NSURLSession*)defaultSession
{
    if (!_defaultSession)
    {
        _defaultSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return _defaultSession;
}

-(void)requestWBHotTodayData_block:(void (^)(NSDictionary *dic, NSError *err))block
{
    NSString *baseURL = @"http://10.13.130.66:8600/2/!/widget_coop";
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
//    NSString *uid = [self getUIDFromKeychain];
    
    [param setObject:@"1009230823760" forKey:@"uid"];
    
    NSString *path = [[self class] queryStringFromBaseURL:baseURL parameters:param encoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:path];
    
    NSURLSessionDataTask *userTask = [self.defaultSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error)
        {
            block(nil,[NSError errorWithDomain:@"出错了" code:-2 userInfo:nil]);
        }
        else
        {
            NSDictionary *jsondict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            NSLog(@"today response:%@", jsondict);
            if (error)
            {
                block(nil,[NSError errorWithDomain:@"出错了" code:-2 userInfo:nil]);
            }
            else
            {
                block(jsondict,error);
            }
        }
    }];
    
    [userTask resume];
}


- (NSURLSessionDownloadTask*)loadImageWithURL:(NSString *)URL completionHandler:(void (^)(UIImage *, NSError *))completionHandler
{
    NSURL *url = [NSURL URLWithString:URL];
    NSURLSessionDownloadTask *downloadTask = [self.defaultSession downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        if (completionHandler)
        {
            NSData *imageData = [NSData dataWithContentsOfURL:location];
            UIImage *image = nil;
            if (imageData)
            {
                image = [UIImage imageWithData:imageData];
            }
            completionHandler(image, error);
        }
    }];
    [downloadTask resume];
    return downloadTask;
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
