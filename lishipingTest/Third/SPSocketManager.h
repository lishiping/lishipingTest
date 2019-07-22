//
//  SPSocketManager.h
//  lishipingTest
//
//  Created by 164749 on 2018/12/27.
//  Copyright © 2018年 shiping1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GCDAsyncSocket.h>

NS_ASSUME_NONNULL_BEGIN

@interface SPSocketManager : NSObject
@property (nonatomic, copy) NSString * _Nonnull host;//默认的host服务器地址
@property (nonatomic, copy) NSString * _Nonnull port;//默认的host服务器地址端口
@property(strong,nonatomic)  GCDAsyncSocket *socket;

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
