//
//  SPNetworkManager.h
//  lishipingTest
//
//  Created by shiping1 on 2017/12/6.
//  Copyright © 2017年 shiping1. All rights reserved.
//


/*
 苹果提供相关错误码如下:
 
 enum
 {
 NSURLErrorUnknown = -1,
 NSURLErrorCancelled = -999,
 NSURLErrorBadURL = -1000,
 NSURLErrorTimedOut = -1001,"请求超时"
 NSURLErrorUnsupportedURL = -1002,
 NSURLErrorCannotFindHost = -1003,"未能找到使用指定主机名的服务器。"
 NSURLErrorCannotConnectToHost = -1004,
 NSURLErrorDataLengthExceedsMaximum = -1103,
 NSURLErrorNetworkConnectionLost = -1005,
 NSURLErrorDNSLookupFailed = -1006,
 NSURLErrorHTTPTooManyRedirects = -1007,
 NSURLErrorResourceUnavailable = -1008,
 NSURLErrorNotConnectedToInternet = -1009,
 NSURLErrorRedirectToNonExistentLocation = -1010,
 NSURLErrorBadServerResponse = -1011,
 NSURLErrorUserCancelledAuthentication = -1012,
 NSURLErrorUserAuthenticationRequired = -1013,
 NSURLErrorZeroByteResource = -1014,
 NSURLErrorCannotDecodeRawData = -1015,
 NSURLErrorCannotDecodeContentData = -1016,
 NSURLErrorCannotParseResponse = -1017,
 NSURLErrorInternationalRoamingOff = -1018,
 NSURLErrorCallIsActive = -1019,
 NSURLErrorDataNotAllowed = -1020,
 NSURLErrorRequestBodyStreamExhausted = -1021,
 NSURLErrorFileDoesNotExist = -1100,
 NSURLErrorFileIsDirectory = -1101,
 NSURLErrorNoPermissionsToReadFile = -1102,
 NSURLErrorSecureConnectionFailed = -1200,
 NSURLErrorServerCertificateHasBadDate = -1201,
 NSURLErrorServerCertificateUntrusted = -1202,
 NSURLErrorServerCertificateHasUnknownRoot = -1203,
 NSURLErrorServerCertificateNotYetValid = -1204,
 NSURLErrorClientCertificateRejected = -1205,
 NSURLErrorClientCertificateRequired = -1206,
 NSURLErrorCannotLoadFromNetwork = -2000,
 NSURLErrorCannotCreateFile = -3000,
 NSURLErrorCannotOpenFile = -3001,
 NSURLErrorCannotCloseFile = -3002,
 NSURLErrorCannotWriteToFile = -3003,
 NSURLErrorCannotRemoveFile = -3004,
 NSURLErrorCannotMoveFile = -3005,
 NSURLErrorDownloadDecodingFailedMidStream = -3006,
 NSURLErrorDownloadDecodingFailedToComplete = -3007
 }
*/



#import <Foundation/Foundation.h>

@interface SPNetworkManager : NSObject

@property (nonatomic, copy) NSString * _Nonnull host;//默认的host服务器地址
@property (nonatomic, assign) NSTimeInterval timestamp; //时间戳

@property (nonatomic, copy) NSString * _Nullable city;//请求参数的城市名称
@property (nonatomic, assign) NSUInteger cityID; //请求参数的城市ID

@property (nonatomic, copy) NSString * _Nullable appVersion;//当前APP版本

+ (instancetype _Nonnull )manager;

-(NSURLSessionDataTask*_Nonnull)getWithPath:(NSString *_Nonnull)path
                                 parameters:(NSDictionary *_Nullable)parameters
                            completionBlock:(nullable void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject, NSError * _Nullable error))completionBlock;


/**
 在AFN基础上封装了一层，好处：
 1.将成功和失败两个回调合并为一个回调,因为有时候要在两个回调里面都写progressHUD的停止方法，合并为一个只需要写一次
 2.一个回调里面在使用正确数据之前要判断error是否有值，如果error有值说明本次网络请求返回出错了，处理出错信息
 3.只有当error==nil的时候说明网络请求没有错误，这时候处理正确参数
 4.将host主机地址放在方法内部使用参数，为的是服务器主机地址能够切换，可以控制APP访问的是测试服务器还是正式服务器
 5.如果遇到某些接口服务器地址不同于内部提供的服务器地址，可以使用host参数传递
 
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
