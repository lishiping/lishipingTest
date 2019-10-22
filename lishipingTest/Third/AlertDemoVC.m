//
//  AlertDemoVC.m
//  lishipingTest
//
//  Created by lishiping on 2019/10/10.
//  Copyright © 2019 shiping1. All rights reserved.
//

#import "AlertDemoVC.h"
#import "SPAlert.h"
#import <UIKit/UIKit.h>
#import "UILabel+SPAction.h"
#import "SPSuperActionSheet.h"

@interface AlertDemoVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *tableViewDataArr;
@end

@implementation AlertDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:UITableViewCell.reuseIdentifier];
    
    self.tableViewDataArr = [[NSArray alloc] initWithObjects:@"警告框一个按钮",@"警告框二个按钮",@"警告框自定义",@"sheet一个按钮",@"sheet二个按钮",@"sheet自定义", nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
//            [self testGCD];
            [self sp_showAlertView_title:@"标题" message:@"详细信息" ok_title:@"更新" ok_block:^(UIAlertAction * _Nullable action) {
        
            }];
            break;
        case 1:
//            [self testTimeTransfer];
            [self sp_showAlertView_title:@"标题" message:@"详细信息" ok_title:@"确认" cancel_title:@"取消" ok_block:^(UIAlertAction * _Nullable action) {
                
            } cancel_block:^(UIAlertAction * _Nullable action) {
                
            }];
            break;
        case 2:
            [self showDIYView];
            break;
        case 3:
            [self sp_showActionSheet_title:@"标题" message:@"详细信息" ok_title:@"确认" cancel_title:@"取消" ok_block:^(UIAlertAction * _Nullable action) {
                
            } cancel_block:^(UIAlertAction * _Nullable action) {
                
            }];
            break;
        case 4:
            [self sp_showActionSheet_title:@"标题" message:@"详细信息" ok_title_default:@"确认" cancel_title:@"取消" ok_block:^(UIAlertAction * _Nullable action) {
                
            } cancel_block:^(UIAlertAction * _Nullable action) {
                
            }];
            break;
        case 5:
            [self showSheetDIYView];

            break;
        default:
            break;
    }
}

-(void)showDIYView
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    label.text = @"自定义的视图";
    label.backgroundColor = [UIColor greenColor];
    label.layer.cornerRadius=4;
    label.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    SP_WEAK(label)
    [label sp_label_onClickBlock:^(id object) {
        [weak_label removeFromSuperview];
    }];
//    [SPAlert sp_showAlertView_view:label];
}

-(void)showSheetDIYView
{
    
    SPSuperActionSheet *sheet = [[SPSuperActionSheet alloc] initWithArray:@[@"1",@"2",@"3",@"4"] clickCellIndexBlock:^(NSInteger integer) {
    }];
    [sheet show];
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
