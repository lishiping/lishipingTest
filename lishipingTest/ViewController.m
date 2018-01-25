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
#import <AFHTTPSessionManager.h>
#import <UIImageView+WebCache.h>
#import <SPFastPush/SPFastPush.h>

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
//    [[SPNetworkManager manager] postWithPath:@"2/!/widget_coop" host:@"http://10.13.130.66:8600" parameters:nil completionBlock:^(NSURLSessionDataTask *task, id  _Nullable responseObject, NSError * _Nullable error) {
//
//    }];
    
    
//    http://wx2.sinaimg.cn/or360/76a1b64dly1fjtw4932h7g20be0631ky.gif
    
//    [[SPNetworkManager manager] getWithPath:@"/or360/76a1b64dly1fjtw4932h7g20be0631ky.gif" host:@"http://wx2.sinaimg.cn" parameters:nil completionBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject, NSError * _Nullable error) {
//
//    }];
//
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
//
//    [manager GET:@"http://wx2.sinaimg.cn/or360/76a1b64dly1fjtw4932h7g20be0631ky.gif" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"打印一下%@",responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//    }];
    
    
    
    UIImageView *iv =[[UIImageView alloc] initWithFrame:CGRectMake(100, 300, 100,100)];
    iv.backgroundColor = [UIColor blueColor];
    [iv sd_setImageWithURL:@"https://wx3.sinaimg.cn/woriginal/63ef3b4egy1fnieeyooyvg20go0gob2e.gif" placeholderImage:nil];
    [self.view addSubview:iv];
    
    
    UIButton *testbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    testbutton.frame = CGRectMake(100, 100, SP_ADJUST_WIDTH(200), SP_ADJUST_HEIGHT(100));
    
    [testbutton setTitle:@"测试按钮" forState:UIControlStateNormal];
    
    testbutton.backgroundColor = [UIColor redColor];
    [testbutton addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:testbutton];
    
    
}


- (void)btnOnClick:(id)sender {
    
//    UIViewController *test = [[UIViewController alloc] init];
//    self.definesPresentationContext = YES;
//    test.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
//    test.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//    [self presentViewController:test animated:YES completion:nil];
    
    //当appear_type=0或者不设置或者设置其他别的值该参数的时候，push推进去，当appear_type=1的时候，prsent弹出，
    //当animated=0的时候无动画，animated=1或者其他任何值或者不设置这个参数默认有动画
    SP_APP_OPEN_URL_STRING(@"lishiping://login?title=nihao&appear_type=0&animated=1")
}

-(void)viewDidAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
