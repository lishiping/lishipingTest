//
//  TodayViewController.m
//  HotTodayExtension
//
//  Created by shiping1 on 2017/11/27.
//  Copyright © 2017年 Sina. All rights reserved.
//

#import "WBHotTodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "WBHotTodayTableViewCell.h"
#import "WBHotTodayManager.h"

@interface WBHotTodayViewController () <NCWidgetProviding,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *tableViewDataMArr; //tableview配置数据

@end

@implementation WBHotTodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //默认是大于ios10展开状态
    if ([[UIDevice currentDevice] systemVersion].floatValue >= 10) {
        self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
    }
    
    //加上模糊效果
    UIVibrancyEffect *blurEffect = [UIVibrancyEffect effectForBlurEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    UIVisualEffectView  *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [self.view addSubview:effectView];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-40) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    
    [_tableView registerClass:[WBHotTodayTableViewCell class] forCellReuseIdentifier:NSStringFromClass([WBHotTodayTableViewCell class])];
    [self.view addSubview:_tableView];
    
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreButton setTitle:NSLocalizedString(@"查看更多", nil) forState:UIControlStateNormal];
    moreButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [moreButton setTitleColor:[WBHotTodayTableViewCell colorWithHexString:@"#636363"] forState:UIControlStateNormal];
    [moreButton addTarget:self action:@selector(moreButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    moreButton.frame = CGRectMake(0, 330, self.view.frame.size.width, 40);
    [self.view addSubview:moreButton];
    [self.view bringSubviewToFront:moreButton];
    
    [[WBHotTodayManager sharedInstance] requestWBHotTodayData_block:^(NSDictionary *dic, NSError *error) {
        
        NSLog(@"获取的数据%@",dic);
        
        self.tableViewDataMArr = [[dic objectForKey:@"statuses"] mutableCopy];
        
        [self.tableView reloadData];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSDictionary *dic = [self.tableViewDataMArr objectAtIndex:indexPath.row];
    
    NSString *midStr = [dic objectForKey:@"mid"];
    
    NSString *scheme = [NSString stringWithFormat:@"sinaweibo://gotohome/?push_mid=%@&groupType=1",midStr?:@""];
    
    [self.extensionContext openURL:[NSURL URLWithString:scheme] completionHandler:^(BOOL success){}];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

#pragma -mark UITableViewDataSoure


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr =  self.tableViewDataMArr;
    return arr.count;
    //    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBHotTodayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([WBHotTodayTableViewCell class])];
    if (!cell)
    {
        cell = [[WBHotTodayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([WBHotTodayTableViewCell class])];
    }
    
    NSDictionary *dic = [self.tableViewDataMArr objectAtIndex:indexPath.row];
    
    [cell setInfoDic:dic];
    
    return cell;
}

#pragma mark - 点击更多事件
-(void)moreButtonClick:(id)sender
{
    //跳到首页热门流
    NSString *scheme = [NSString stringWithFormat:@"sinaweibo://gotohome?grouptype=1"];
    
    [self.extensionContext openURL:[NSURL URLWithString:scheme] completionHandler:^(BOOL success){}];
}


#pragma - mark NCWidgetProviding
#ifdef __IPHONE_10_0
- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize {
    
    if (activeDisplayMode == NCWidgetDisplayModeCompact) {
        self.preferredContentSize = CGSizeMake(maxSize.width, 110);
    } else {
        self.preferredContentSize = CGSizeMake(maxSize.width, 370);
    }
}
#endif
- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    //    if (_hasSharedData) {
    //        [self getContentData:completionHandler];
    //    }else {
    completionHandler(NCUpdateResultNewData);
    //    }
}



@end
