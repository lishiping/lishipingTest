//
//  WBHotTodayTableViewCell.m
//  Weibo
//
//  Created by shiping1 on 2017/11/27.
//  Copyright © 2017年 Sina. All rights reserved.
//

#import "WBHotTodayTableViewCell.h"
#import "WBHotTodayManager.h"

@interface WBHotTodayTableViewCell ()

@property (nonatomic, weak) NSURLSessionDownloadTask *imageDownloadTask;

@end

@implementation WBHotTodayTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    [self setupUI];
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setupUI
{
    self.abstractImageView = [[UIImageView alloc] init];
    self.abstractImageView.translatesAutoresizingMaskIntoConstraints = NO;
    //    self.abstractImageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.abstractImageView];
    
    //图片的约束
    NSLayoutConstraint *r1 = [NSLayoutConstraint
                              constraintWithItem:self.abstractImageView
                              attribute:NSLayoutAttributeRight
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.contentView
                              attribute:NSLayoutAttributeRight
                              multiplier:1 constant:-30];
    
    NSLayoutConstraint *w1 = [NSLayoutConstraint
                              constraintWithItem:self.abstractImageView
                              attribute:NSLayoutAttributeWidth
                              relatedBy:NSLayoutRelationEqual
                              toItem:nil
                              attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1 constant:102];
    
    NSLayoutConstraint *h1 = [NSLayoutConstraint
                              constraintWithItem:self.abstractImageView
                              attribute:NSLayoutAttributeHeight
                              relatedBy:NSLayoutRelationEqual
                              toItem:nil
                              attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1 constant:70];
    
    NSLayoutConstraint *centerY1 = [NSLayoutConstraint
                                    constraintWithItem:self.abstractImageView
                                    attribute:NSLayoutAttributeCenterY
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                    attribute:NSLayoutAttributeCenterY
                                    multiplier:1 constant:0];
    
    [self.contentView addConstraints:@[r1,w1,h1,centerY1]];
    
    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.font = [UIFont systemFontOfSize:14];
    self.contentLabel.numberOfLines = 2;
    self.contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.contentLabel.text = @"";
    [self.contentView addSubview:self.contentLabel];
    
    //内容约束
    NSLayoutConstraint *l2 = [NSLayoutConstraint
                              constraintWithItem:self.contentLabel
                              attribute:NSLayoutAttributeLeft
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.contentView
                              attribute:NSLayoutAttributeLeft
                              multiplier:1 constant:10];
    
    NSLayoutConstraint *r2 = [NSLayoutConstraint
                              constraintWithItem:self.contentLabel
                              attribute:NSLayoutAttributeRight
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.abstractImageView
                              attribute:NSLayoutAttributeLeft
                              multiplier:1 constant:-10];
    
    NSLayoutConstraint *t2 = [NSLayoutConstraint
                              constraintWithItem:self.contentLabel
                              attribute:NSLayoutAttributeTop
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.abstractImageView
                              attribute:NSLayoutAttributeTop
                              multiplier:1 constant:0];
    
    NSLayoutConstraint *h2 = [NSLayoutConstraint
                              constraintWithItem:self.contentLabel
                              attribute:NSLayoutAttributeHeight
                              relatedBy:NSLayoutRelationEqual
                              toItem:nil
                              attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1 constant:50];
    
    [self.contentView addConstraints:@[l2,r2,t2,h2]];
    
    
    self.commentLabel = [[UILabel alloc] init];
    self.commentLabel.backgroundColor = [UIColor redColor];
    self.commentLabel.font = [UIFont systemFontOfSize:12];
    self.commentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.commentLabel.text = @"";
    self.commentLabel.textColor = [[self class] colorWithHexString:@"#636363"];
    [self.contentView addSubview:self.commentLabel];
    
    //评论和时间约束
    NSLayoutConstraint *l3 = [NSLayoutConstraint
                              constraintWithItem:self.commentLabel
                              attribute:NSLayoutAttributeLeft
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.contentView
                              attribute:NSLayoutAttributeLeft
                              multiplier:1 constant:10];
    
    NSLayoutConstraint *r3 = [NSLayoutConstraint
                              constraintWithItem:self.commentLabel
                              attribute:NSLayoutAttributeRight
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.contentLabel
                              attribute:NSLayoutAttributeRight
                              multiplier:1 constant:0];
    
    NSLayoutConstraint *b3 = [NSLayoutConstraint
                              constraintWithItem:self.commentLabel
                              attribute:NSLayoutAttributeBottom
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.abstractImageView
                              attribute:NSLayoutAttributeBottom
                              multiplier:1 constant:0];
    
    NSLayoutConstraint *h3 = [NSLayoutConstraint
                              constraintWithItem:self.commentLabel
                              attribute:NSLayoutAttributeHeight
                              relatedBy:NSLayoutRelationEqual
                              toItem:nil
                              attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1 constant:20];
    
    
    [self.contentView addConstraints:@[l3,r3,b3,h3]];
    
    //    self.timeLabel = [[UILabel alloc] init];
    //    self.timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    ////    self.timeLabel.backgroundColor = [UIColor redColor];
    //    self.timeLabel.font = [UIFont systemFontOfSize:12];
    //    self.timeLabel.text = @"";
    //    self.timeLabel.textColor = [[self class] colorWithHexString:@"#636363"];
    //    [self.contentView addSubview:self.timeLabel];
    //
    //
    //    NSLayoutConstraint *l4 = [NSLayoutConstraint
    //                              constraintWithItem:self.timeLabel
    //                              attribute:NSLayoutAttributeLeft
    //                              relatedBy:NSLayoutRelationEqual
    //                              toItem:self.commentLabel
    //                              attribute:NSLayoutAttributeRight
    //                              multiplier:1 constant:0];
    //
    //    NSLayoutConstraint *r4 = [NSLayoutConstraint
    //                              constraintWithItem:self.timeLabel
    //                              attribute:NSLayoutAttributeRight
    //                              relatedBy:NSLayoutRelationEqual
    //                              toItem:self.contentLabel
    //                              attribute:NSLayoutAttributeRight
    //                              multiplier:1 constant:0];
    //
    //    NSLayoutConstraint *b4 = [NSLayoutConstraint
    //                              constraintWithItem:self.timeLabel
    //                              attribute:NSLayoutAttributeBottom
    //                              relatedBy:NSLayoutRelationEqual
    //                              toItem:self.abstractImageView
    //                              attribute:NSLayoutAttributeBottom
    //                              multiplier:1 constant:0];
    //
    //    NSLayoutConstraint *h4 = [NSLayoutConstraint
    //                              constraintWithItem:self.timeLabel
    //                              attribute:NSLayoutAttributeHeight
    //                              relatedBy:NSLayoutRelationEqual
    //                              toItem:nil
    //                              attribute:NSLayoutAttributeNotAnAttribute
    //                              multiplier:1 constant:20];
    //
    //
    //    [self.contentView addConstraints:@[l4,r4,b4,h4]];
    //
}

-(void)setInfoDic:(NSDictionary *)infoDic
{
    _infoDic = infoDic;
    
    //内容
    self.contentLabel.text = [infoDic objectForKey:@"text"]?:@"";
    
    //评论
    NSString *commentStr = [NSString stringWithFormat:NSLocalizedString(@"%@ 评论", nil),[infoDic objectForKey:@"comments_count"]] ;
    
    //时间
    NSString *timeStr = [self generalRelativeFormattedStringWithDate:[self dateWithLocalNaturalLanguageString:[infoDic objectForKey:@"created_at"]]];
    
    commentStr = [commentStr stringByAppendingString:[NSString stringWithFormat:@"   %@",timeStr]];
    
    self.commentLabel.text =commentStr;
    
    //加载图片
    NSString *urlstr = [infoDic objectForKey:@"thumbnail_pic"];
    
    [self loadImageWithURL:urlstr];
}

- (void)loadImageWithURL:(NSString*)imageURL
{
    if (imageURL)
    {
        __weak __typeof(self) weakSelf = self;
        self.imageDownloadTask = [[WBHotTodayManager sharedInstance] loadImageWithURL:imageURL  completionHandler:^(UIImage *image, NSError *error) {
            if (!error && image)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.abstractImageView setImage:image];
                });
            }else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.abstractImageView setImage:nil];
                });
            }
        }];
    }
}

+ (UIColor *)colorWithHexString:(NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"] || [cString hasPrefix:@"0x"])
    {
        cString = [cString substringFromIndex:2];
    }
    else if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

- (NSString *)generalRelativeFormattedStringWithDate:(NSDate*)relativedDate
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay;
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    NSDateComponents *nowComponents = [calendar components:unitFlags fromDate:[NSDate date]];
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:relativedDate];
    NSDateComponents *yesterdayComponents = [calendar components:unitFlags fromDate:[[NSDate date] dateByAddingTimeInterval:(-24*60*60)]];
    
    NSString *formattedString = nil;
    
    if ([nowComponents year] == [dateComponents year] &&
        [nowComponents month] == [dateComponents month] &&
        [nowComponents day] == [dateComponents day])                // 今天
    {
        int diff = [relativedDate timeIntervalSinceNow];
        if (diff <= 0 && diff > -60 * 60 * 24)                        // 一天之内.
        {
            int min = -diff / 60;
            
            if (min == 0)
            {
                min = 1;
            }
            
            if (min <= 10)                                          //10分钟
            {
                formattedString = NSLocalizedString(@"刚刚", nil);
            }
            else if (min <= 59)                                     //一小时内
            {
                formattedString = [NSString stringWithFormat:NSLocalizedString(@"%d分钟前", nil), min];
            }
            else
            {
                int hour = min / 60;
                formattedString = [NSString stringWithFormat:NSLocalizedString(@"%d小时前", nil), hour];
            }
        }
        else if (diff > 0)
        {
            formattedString = [NSString stringWithFormat:NSLocalizedString(@"%d分钟前", nil), 1];
        }
    }
    else if([yesterdayComponents year] == [dateComponents year] &&
            [yesterdayComponents month] == [dateComponents month] &&
            [yesterdayComponents day] == [dateComponents day])          // 昨天
    {
        [dateFormatter setDateFormat:NSLocalizedString(@"'昨天 'HH:mm", nil)];
        formattedString = [dateFormatter stringFromDate:relativedDate];
    }
    else
    {
        NSLocale *mainlandChinaLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        [dateFormatter setLocale:mainlandChinaLocale];
        
        if ([nowComponents year] == [dateComponents year])
        {
            [dateFormatter setDateFormat:@"M-d"];
        }
        else
        {
            [dateFormatter setDateFormat:@"yy-M-d"];
        }
        
        formattedString = [dateFormatter stringFromDate:relativedDate];
    }
    
    return formattedString;
    
}

- (NSDate *)dateWithLocalNaturalLanguageString:(NSString *)timeString
{
    time_t timestamp;
    
    struct tm created;
    time_t now;
    time(&now);
    
    if (timeString)
    {
        if (strptime([timeString UTF8String], "%a %b %d %H:%M:%S %z %Y", &created) == NULL)
        {
            if(NULL == strptime([timeString UTF8String], "%a, %d %b %Y %H:%M:%S %z", &created)){
                return nil;
            }
        }
        timestamp = mktime(&created);
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
        return date;
    }
    
    return nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
