//
//  WBHotTodayTableViewCell.h
//  Weibo
//
//  Created by shiping1 on 2017/11/27.
//  Copyright © 2017年 Sina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBHotTodayTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *abstractImageView;//摘要图片
@property(nonatomic,strong)UILabel *contentLabel;//内容
@property(nonatomic,strong)UILabel *commentLabel;//评论数和时间
//@property(nonatomic,strong)UILabel *timeLabel;//时间

@property(nonatomic,strong)NSDictionary *infoDic;//配置数据

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

//绑定数据
-(void)setInfoDic:(NSDictionary *)infoDic;

//颜色函数
+ (UIColor *)colorWithHexString:(NSString *)color;

@end
