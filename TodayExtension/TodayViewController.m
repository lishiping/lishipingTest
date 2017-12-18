//
//  TodayViewController.m
//  TodayExtension
//
//  Created by shiping1 on 2017/11/28.
//  Copyright © 2017年 shiping1. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import <Masonry/Masonry.h>

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    UIView *view = [[UIView alloc] init];
    
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
     
     [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
         make.right.mas_equalTo(-40);
        make.height.mas_equalTo(40);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

@end
