//
//  LSPDebugView.h
//  ApolloApi
//
//  Created by lishiping on 2020/8/15.
//  Copyright © 2020 新东方. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LSPDebugView_Width [UIScreen mainScreen].bounds.size.height *4.0/3.0
#define LSPDebugView_Height [UIScreen mainScreen].bounds.size.height

NS_ASSUME_NONNULL_BEGIN

@interface LSPDebugView : UIView

-(void)addLog:(NSArray*)logArr;

@end

NS_ASSUME_NONNULL_END
