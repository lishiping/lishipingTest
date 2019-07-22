//
//  ThirdVC.m
//  lishipingTest
//
//  Created by 164749 on 2018/12/27.
//  Copyright © 2018年 shiping1. All rights reserved.
//

#import "ThirdVC.h"
#import "YBCustomCameraVC.h"
#import <GCDAsyncSocket.h>
#import "SPSocketManager.h"

@interface ThirdVC ()<GCDAsyncSocketDelegate,UITextFieldDelegate>

@property(strong, nonatomic) UITextView *status;
@property(strong, nonatomic) UILabel *socketServerURLLabel;
@property(strong, nonatomic) UITextField *message;

@end

@implementation ThirdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(0, 50, SP_SCREEN_WIDTH, 48);
    label.text = self.serverURL;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor redColor];
    [self.view addSubview:label];
    
    _socketServerURLLabel = [UILabel new];
    _socketServerURLLabel.frame = CGRectMake(0, 100, SP_SCREEN_WIDTH, 48);
    _socketServerURLLabel.text =[NSString stringWithFormat:@"%@:%@",[SPSocketManager sharedInstance].host,[SPSocketManager sharedInstance].port];
    _socketServerURLLabel.textAlignment = NSTextAlignmentCenter;
    _socketServerURLLabel.textColor = [UIColor redColor];
    [self.view addSubview:_socketServerURLLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 150, SP_SCREEN_WIDTH, 48);
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"打开相机" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *linkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    linkButton.frame = CGRectMake(0, 200, SP_SCREEN_WIDTH, 48);
    linkButton.backgroundColor = [UIColor redColor];
    [linkButton setTitle:@"连接服务器" forState:UIControlStateNormal];
    [linkButton addTarget:self action:@selector(connect:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:linkButton];
    
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.frame = CGRectMake(SP_SCREEN_WIDTH-50, 250, 50, 48);
    sendButton.backgroundColor = [UIColor redColor];
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendButton];
    
    [self.view addSubview:self.status];
    [self.view addSubview:self.message];
    
//    NSString *string  = @"下述价格为票面价格，欧洲铁车票每张收取25元出票费，纸质票需另收取每订单20元快递费。";
//    CGSize size = [string sp_getSize_maxSize:CGSizeMake(SP_SCREEN_WIDTH, INT_MAX) font:[UIFont systemFontOfSize:12]];
//    SP_LOG(@"dhahd")

}

-(void)viewWillAppear:(BOOL)animated
{
    _socketServerURLLabel.text =[NSString stringWithFormat:@"%@:%@",[SPSocketManager sharedInstance].host,[SPSocketManager sharedInstance].port];
}

-(void)buttonClick:(id)sender
{        
    YBCustomCameraVC *vc = [[YBCustomCameraVC alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)connect:(id)sender
{
    [SPSocketManager sharedInstance].socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    //socket.delegate = self;
    NSError *err = nil;
    if(![[SPSocketManager sharedInstance].socket connectToHost:[SPSocketManager sharedInstance].host onPort:[[SPSocketManager sharedInstance].port intValue] error:&err])
    {
        [self addText:err.description];
    }else
    {
        NSLog(@"ok");
        [self addText:@"打开端口"];
    }
}

- (void)send:(id)sender {
    
    [[SPSocketManager sharedInstance].socket writeData:[_message.text dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];

    [self addText:[NSString stringWithFormat:@"我:%@",_message.text]];
    [_message resignFirstResponder];
    [[SPSocketManager sharedInstance].socket readDataWithTimeout:-1 tag:0];
    
    NSString *string = @"#$#$";
    
    [[SPSocketManager sharedInstance].socket writeData:[string dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
    [[SPSocketManager sharedInstance].socket readDataWithTimeout:-1 tag:0];
}

-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    [self addText:[NSString stringWithFormat:@"连接到:%@",host]];
    [[SPSocketManager sharedInstance].socket readDataWithTimeout:-1 tag:0];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    
}

-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *newMessage = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [self addText:[NSString stringWithFormat:@"%@:%@",sock.connectedHost,newMessage]];
    
    //[socket readDataWithTimeout:-1 tag:0];
}

-(void)addText:(NSString *)str
{
    _status.text = [_status.text stringByAppendingFormat:@"%@\n",str];
}

-(UITextView*)status
{
    if (!_status) {
        _status = [[UITextView alloc] initWithFrame:CGRectMake(0, 300, SP_SCREEN_WIDTH, 300)];
        _status.scrollEnabled = YES;
        _status.editable = NO;
        _status.backgroundColor = [UIColor blueColor];
    }
    return _status;
}

-(UITextField*)message
{
    if (!_message) {
        _message = [[UITextField alloc] initWithFrame:CGRectMake(0, 250, SP_SCREEN_WIDTH-50, 48)];
        _message.backgroundColor = [UIColor greenColor];
    }
    return _message;
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
