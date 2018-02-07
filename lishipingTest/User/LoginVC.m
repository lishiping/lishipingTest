//
//  LoginVC.m
//  lishipingTest
//
//  Created by shiping li on 2018/1/25.
//  Copyright © 2018年 shiping1. All rights reserved.
//

#import "LoginVC.h"

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
