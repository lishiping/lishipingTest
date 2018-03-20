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
#import <SPCategory/UIViewController+SPHUD.h>
#import <UIViewController+SPUIAlertController.h>
#import <UIViewController+SPStatusBarStyle.h>
#import <UIViewController+SPNavigationBarStyle.h>
#import <NSString+SPEnCode.h>
#import "SPHandleOpenURLManager.h"
#import "RegisterVC.h"
#import "SPAlert.h"
#import "SPHUD.h"


@interface ViewController ()

@end

@implementation ViewController

- (id)init
{
    self = [super init];
    if (self) {
//        NSLog(@"%@", NSStringFromClass([self class]));
//        NSLog(@"%@", NSStringFromClass([super class]));
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"首页";
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
    
    
    [self sp_navBar:BarStyle_WhiteBGColor_BlackTitle];
    
    
    UIButton *testbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    testbutton.frame = CGRectMake(50, 50, SP_ADJUST_WIDTH(300), SP_ADJUST_HEIGHT(50));
    [testbutton setTitle:@"使用url的scheme方式打开" forState:UIControlStateNormal];
    testbutton.backgroundColor = [UIColor redColor];
    [testbutton addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testbutton];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(50, 150, SP_ADJUST_WIDTH(300), SP_ADJUST_HEIGHT(50));
    [button2 setTitle:@"使用路由打开一个页面" forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor redColor];
    [button2 addTarget:self action:@selector(button2OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(50, 250, SP_ADJUST_WIDTH(300), SP_ADJUST_HEIGHT(50));
    [button3 setTitle:@"在当前APP内部打开一个网页" forState:UIControlStateNormal];
    button3.backgroundColor = [UIColor redColor];
    [button3 addTarget:self action:@selector(button3OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
}


- (void)btnOnClick:(id)sender {
    
//    UIViewController *test = [[UIViewController alloc] init];
//    self.definesPresentationContext = YES;
//    test.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
//    test.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//    [self presentViewController:test animated:YES completion:nil];
    //    [self sp_showToast:@"大家好"];
    
    //    [self sp_showAlertView_title:@"标题" message:@"详细信息" ok_title:@"更新" ok_block:^(UIAlertAction * _Nullable action) {
    //
    //    }];
    
    
    //当appear_type=0或者不设置或者设置其他别的值该参数的时候，push推进去，当appear_type=1的时候，prsent弹出，
    //当animated=0的时候无动画，animated=1或者其他任何值或者不设置这个参数默认有动画
    NSString *urlString =@"lishiping://login?title=这里是登录页&username=lishiping&password=123456&appear_type=0&animated=1";
    
    SP_APP_OPEN_URL_STRING(urlString.getURLWithStringByurlEncode.absoluteString)
    
}

- (void)button2OnClick:(id)sender
{

    //简单弹出方式
//    SP_PRESENT_VC_BY_CLASSNAME(@"RegisterVC", nil)
    
    //简单推出方式
//    SP_PUSH_VC_BY_CLASSNAME(@"RegisterVC", @{@"title":@"注册页面"})
    
    //推出对象
//    RegisterVC *registerVC = [[RegisterVC alloc] init];
//    SP_PUSH_VC(registerVC)
    
//    [SPHUD sp_showHUD];
}

- (void)button3OnClick:(id)sender
{
    //打开一个url
    //类实现
    //    [SPHandleOpenURLManager application:nil openURL:[NSURL URLWithString:@"https://www.baidu.com/"] options:nil];
    
    //宏实现更方便
    SP_INAPP_OPEN_URL_STRING(@"https://mp.weixin.qq.com/s/2xT3AR8GJ4-vtBYKQhzqlw")
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
