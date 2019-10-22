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
#import "SPURLRouter.h"
#import "RegisterVC.h"
#import "SPAlert.h"
#import "SPHUD.h"
#import <UIButton+WebCache.h>
#import <UIImage+SPGIF.h>
#import <UIImage+GIF.h>
#import <SafeData/NSArray+SPSafe.h>

typedef struct BTree
{
    int identificer;
  struct  BTree *first;
  struct  BTree *next;
  struct  BTree *parent;

} BTree;

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *tableViewDataArr;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"路由";
    self.view.backgroundColor = [UIColor greenColor];
    
    SP_LOG(@"比例%f",SP_SCREEN_SCALE)

//    [self blockTest];
    
//    [self printClass];
    
//    [self gcdTest];
    
//    UIButton *testbutton = [UIButton buttonWithType:UIButtonTypeCustom];
//    testbutton.frame = CGRectMake(50, 50, SP_ADJUST_WIDTH(300), SP_ADJUST_HEIGHT(50));
//    [testbutton setTitle:@"使用urlrouter的scheme方式打开" forState:UIControlStateNormal];
//    testbutton.backgroundColor = [UIColor redColor];
//    [testbutton addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:testbutton];
//
//    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    button2.frame = CGRectMake(50, 150, SP_ADJUST_WIDTH(300), SP_ADJUST_HEIGHT(50));
//    [button2 setTitle:@"使用页面跳转路由打开一个页面" forState:UIControlStateNormal];
//    button2.backgroundColor = [UIColor redColor];
//    [button2 addTarget:self action:@selector(button2OnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button2];
//
//    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
//    button3.frame = CGRectMake(50, 250, SP_ADJUST_WIDTH(300), SP_ADJUST_HEIGHT(50));
//    [button3 setTitle:@"在当前APP内部打开一个网页" forState:UIControlStateNormal];
//    button3.backgroundColor = [UIColor redColor];
//    [button3 addTarget:self action:@selector(button3OnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button3];
//
//
//    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
//    button4.frame = CGRectMake(50, 350, SP_ADJUST_WIDTH(300), SP_ADJUST_HEIGHT(50));
//    button4.backgroundColor = [UIColor redColor];
//    [button4 addTarget:self action:@selector(button3OnClick:) forControlEvents:UIControlEventTouchUpInside];
//
//    [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:@"https://h5.sinaimg.cn/upload/1055/471/2018/04/13/11.gif"] options:SDWebImageRetryFailed progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
//
//        UIImage *gifImage = [UIImage sp_animatedGIFWithData:data];
//        [button4 setImage:gifImage forState:UIControlStateNormal];
//        [button4 setTitle:@"在当前APP内部打开一个网页" forState:UIControlStateNormal];
//
//    }];
//
//
//    [self.view addSubview:button4];
    
    
    
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:UITableViewCell.reuseIdentifier];
    
    self.tableViewDataArr = [[NSArray alloc] initWithObjects:@"urlrouter打开内部页面",@"urlrouter打开外部应用",@"urlrouter打开微博应用",@"urlrouter内部打开一个网页",@"urlrouter无动画打开内部页面", nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self sp_navBar:BarStyle_BlackBGColor_WhiteTitle];
}


-(UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SP_SCREEN_WIDTH, SP_SCREEN_HEIGHT)];
    }
    return _tableView;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:[UITableViewCell reuseIdentifier]];
    
    NSString *str = [self.tableViewDataArr sp_arrayObjectAtIndex:indexPath.row];
    
    cell.textLabel.text = str;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableViewDataArr.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self btnOnClick:nil];
            break;
        case 1:
            [self button2OnClick:nil];
            break;
        case 2:
            [self button3OnClick:nil];
            break;
        case 3:
            SP_INAPP_OPEN_URL_STRING(@"https://www.baidu.com/")
            break;
        case 4:
            [self presentOnClick:nil];
        break;
        default:
            break;
    }
}

- (void)presentOnClick:(id)sender {

    //当appear_type=0或者不设置或者设置其他别的值该参数的时候，push推进去，当appear_type=1的时候，prsent弹出，
    //当animated=0的时候无动画，animated=1或者其他任何值或者不设置这个参数默认有动画
    NSString *urlString =@"lishiping://login?title=这里是登录页&username=lishiping&password=123456&appear_type=0&appear_type=1";
    
    SP_INAPP_OPEN_URL_STRING(urlString.getStringByurlEncode)
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
    
    SP_INAPP_OPEN_URL_STRING(urlString.getStringByurlEncode)
    
    //需要URL编码之后才能生成URL对象
//    SP_APP_OPEN_URL_STRING(urlString.getStringByurlEncode)
    

}

- (void)button2OnClick:(id)sender
{
    //简单弹出方式
    //    SP_PRESENT_VC_BY_CLASSNAME(@"RegisterVC", nil)
    
    //简单推出方式
//        SP_PUSH_VC_BY_CLASSNAME(@"RegisterVC", @{@"title":@"注册页面"})
    
//    推出对象
//    RegisterVC *registerVC = [[RegisterVC alloc] init];
//    SP_PUSH_VC(registerVC)
    
    //通过safari打开站外的地址
    SP_APP_OPEN_URL_STRING(@"https://www.baidu.com/")
    
}

- (void)button3OnClick:(id)sender
{
    //在本APP内部打开一个url
    //宏实现更方便
//    SP_INAPP_OPEN_URL_STRING(@"https://www.baidu.com/")
    
    SP_APP_OPEN_URL_STRING(@"sinaweibo://gotohome")
}


//-(void)testNetWorkRequest
//{
//    [SPHUD sp_showHUD];
//    [[SPNetworkManager manager] postWithPath:@"2/push/daily" host:nil parameters:nil completionBlock:^(NSURLSessionDataTask *task, id  _Nullable responseObject, NSError * _Nullable error) {
//        [SPHUD sp_hideHUD];
//
//    }];
//}

-(void)blockTest
{
//    void (^blk)(void) = ^{printf("Block\n");};
    
    NSString *a = @"testa";
    
    __block int x = 2;
//    NSLog(@"block前,a在堆中的地址%p,a在栈中的地址%p",a,&a);
    NSLog(@"block前,x在堆中的地址%p,x在栈中的地址%p",x,&x);

    void(^testBlock)(void) = ^(void){
//        NSLog(@"block内,a在堆中的地址%p,a在栈中的地址%p",a,&a);
        NSLog(@"block内,x在堆中的地址%p,x在栈中的地址%p",x,&x);

        NSLog(@"block内前,x==%d",x);

        x= 5;
        
        NSLog(@"block内后,x==%d",x);
        NSLog(@"block内后,x在堆中的地址%p,x在栈中的地址%p",x,&x);

    };


    testBlock();

    NSLog(@"block后前,x==%d",x);
    NSLog(@"block后前,x在堆中的地址%p,x在栈中的地址%p",x,&x);

        x = 3;
//        NSLog(@"block后,a在堆中的地址%p,a在栈中的地址%p",a,&a);
        NSLog(@"block后,x在堆中的地址%p,x在栈中的地址%p",x,&x);
        NSLog(@"block后,x==%d",x);
}

//测试打印类
-(void)printClass
{
    
    SP_LOG(@"[obj class]==%@",[self class]);
    
    SP_LOG(@"objc_getclass==%s",object_getClassName(self));
    
    SP_LOG(@"self.class==%@",self.class);

}

-(void)gcdTest
{
    dispatch_async(dispatch_get_main_queue(), ^{
       
        SP_LOG(@"A");

        dispatch_sync(dispatch_get_main_queue(), ^{
           
            SP_LOG(@"B");

        });
        
        SP_LOG(@"C");

    });
    
    SP_LOG(@"D");

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
