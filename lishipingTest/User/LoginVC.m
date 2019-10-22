//
//  LoginVC.m
//  lishipingTest
//
//  Created by shiping li on 2018/1/25.
//  Copyright © 2018年 shiping1. All rights reserved.
//

#import "LoginVC.h"
#import <UIImageView+WebCache.h>
#import <UIView+WebCache.h>

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    UILabel *usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, SP_ADJUST_WIDTH(200), SP_ADJUST_HEIGHT(50))];
    
    UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, SP_ADJUST_WIDTH(200), SP_ADJUST_HEIGHT(50))];

    [self.view addSubview:usernameLabel];
    
    [self.view addSubview:passwordLabel];
    
    usernameLabel.text = self.username;
    
    passwordLabel.text = self.password;
    
    SP_LOG(@"用户名密码username=%@，password=%@",_username,_password)
    
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(100, 300, 200, 200)];
    
    [self.view addSubview:iv];
//    [iv sd_setShowActivityIndicatorView:YES];

    
    [iv sd_setImageWithURL:[NSURL URLWithString:@"http://wx2.sinaimg.cn/or360/76a1b64dly1fjtw4932h7g20be0631ky.gif"] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        SP_LOG(@"宽==%f,高==%f",image.size.width,image.size.height)
    }];
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 500, 200, 200)];
//
//    [self.view addSubview:view];
//
//    [view sd_setShowActivityIndicatorView:YES];
//
//    [view sd_internalSetImageWithURL:[NSURL URLWithString:@"http://wx2.sinaimg.cn/or360/76a1b64dly1fjtw4932h7g20be0631ky.gif"]
//               placeholderImage:nil
//                        options:nil
//                   operationKey:nil
//                  setImageBlock:nil
//                       progress:progressBlock
//                      completed:completedBlock];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
