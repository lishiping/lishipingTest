//
//  WBHotTodayManager.h
//  Weibo
//
//  Created by shiping1 on 2017/11/29.
//  Copyright © 2017年 Sina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WBHotTodayManager : NSObject

@property (nonatomic, strong) NSURLSession *defaultSession;

@property (nonatomic, strong) NSDictionary *sharedParams;

@property (nonatomic, strong) NSString *uid;

+ (instancetype)sharedInstance;

//请求数据
-(void)requestWBHotTodayData_block:(void (^)(NSDictionary *dic,NSError *error))block;

//加载图片
- (NSURLSessionDownloadTask*)loadImageWithURL:(NSString *)URL completionHandler:(void (^)(UIImage *image,NSError *error))completionHandler;

@end
