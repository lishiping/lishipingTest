//
//  ViewController.m
//  lishipingTest
//
//  Created by shiping1 on 2017/11/2.
//  Copyright © 2017年 shiping1. All rights reserved.
//

#import "ViewController.h"
#import "SPNetworkManager.h"
#import <SPSafeData.h>

#define IOS8 ([[[UIDevice currentDevice] systemVersion] doubleValue] >=8.0 ? YES : NO)

@interface ViewController ()

@end

@implementation ViewController

- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"%@", NSStringFromClass([self class]));
        NSLog(@"%@", NSStringFromClass([super class]));
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor greenColor];
    
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//
//    [param setObject:@"1009230823760" forKey:@"uid"];
//
//    [[SPNetworkManager manager] postWithPath:@"2/!/widget_coop" host:@"http://10.13.130.66:8600" parameters:param completionBlock:^(NSURLSessionDataTask *task, id  _Nullable responseObject, NSError * _Nullable error) {
//
//    }];
    
    
    UIButton *testbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    testbutton.frame = CGRectMake(100, 100, 100, 50);
    
    [testbutton setTitle:@"测试按钮" forState:UIControlStateNormal];
    
    testbutton.backgroundColor = [UIColor redColor];
    [testbutton addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:testbutton];
    
    
    
    if (IOS8) { //iOS8以上包含iOS8
        if ([[UIApplication sharedApplication] currentUserNotificationSettings].types  == UIRemoteNotificationTypeNone) {
        }
    }else{ // ios7 一下
        if ([[UIApplication sharedApplication] enabledRemoteNotificationTypes]  == UIRemoteNotificationTypeNone) {
        }
    }
    
}


- (void)btnOnClick:(id)sender {
    
    UIViewController *test = [[UIViewController alloc] init];
    self.definesPresentationContext = YES;
    test.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
    test.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:test animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
