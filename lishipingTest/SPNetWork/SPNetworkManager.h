//
//  SPNetworkManager.h
//  lishipingTest
//
//  Created by shiping1 on 2017/12/6.
//  Copyright © 2017年 shiping1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPNetworkManager : NSObject

@property (nonatomic, copy) NSString * _Nonnull host;//默认的host服务器地址
@property (nonatomic, assign) NSTimeInterval timeoutInterval;//网络超时时间
@property (nonatomic, assign) NSTimeInterval timestamp; //时间戳

@property (nonatomic, copy) NSString * _Nullable city;//请求参数的城市名称
@property (nonatomic, assign) NSUInteger cityID; //请求参数的城市ID

+ (instancetype _Nonnull )manager;

-(NSURLSessionDataTask*_Nonnull)getWithPath:(NSString *_Nonnull)path
                                 parameters:(NSDictionary *_Nullable)parameters
                            completionBlock:(nullable void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject, NSError * _Nullable error))completionBlock;


/**
 在AFN基础上封装了一层，好处：
 1.将两个回调合并为一个回调,因为有时候要在两个回调里面都写progressHUD的停止方法，合并为一个只需要写一次
 2.将host主机地址放在方法内部使用参数

 @param path 接口路径
 @param host 接口主机地址，设置nil的时候默认使用单例提供的
 @param parameters 请求参数
 @param completionBlock 请求完成回调
 @return 会话任务
 */
-(NSURLSessionDataTask*_Nonnull)getWithPath:(NSString *_Nonnull)path
                                       host:(NSString *_Nullable)host
                                 parameters:(NSDictionary *_Nullable)parameters
                            completionBlock:(nullable void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject, NSError * _Nullable error))completionBlock;

-(NSURLSessionDataTask*_Nonnull)postWithPath:(NSString *_Nonnull)path
                                  parameters:(NSDictionary *_Nullable)parameters
                             completionBlock:(nullable void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject, NSError * _Nullable error))completionBlock;

-(NSURLSessionDataTask*_Nonnull)postWithPath:(NSString *_Nonnull)path
                                        host:(NSString *_Nullable)host
                                  parameters:(NSDictionary *_Nullable)parameters
                             completionBlock:(nullable void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject, NSError * _Nullable error))completionBlock;

@end
