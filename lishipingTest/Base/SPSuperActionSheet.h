//
//  SPSuperActionSheet.h
//  jgdc
//
//  Created by lishiping on 2019/9/25.
//  Copyright © 2019 QingClass. All rights reserved.
//

#import "SPAutoPopView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SPSuperActionSheet : SPAutoPopView

- (instancetype)initWithArray:(NSArray*)array clickCellIndexBlock:(SPIntegerBlock)clickCellIndexBlock;

@end

NS_ASSUME_NONNULL_END
