//
//  SPSuperActionSheet.m
//  jgdc
//
//  Created by lishiping on 2019/9/25.
//  Copyright © 2019 QingClass. All rights reserved.
//

#import "SPSuperActionSheet.h"
#import "UIButton+Util.h"
#import "UIButton+SPAction.h"

#define cellHeight 56.0f
@interface SPSuperActionSheet ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *tableViewArr;
@property (nonatomic, strong) UIButton *cancelB;//取消
@property (nonatomic, copy) SPIntegerBlock clickCellIndexBlock;

@end
@implementation SPSuperActionSheet

- (instancetype)initWithArray:(NSArray*)array clickCellIndexBlock:(SPIntegerBlock)clickCellIndexBlock
{
    CGFloat top = SP_SCREEN_HEIGHT-cellHeight-20-array.count*cellHeight;
    self = [super initWithBoxViewMarginTop:top];
    self.tableViewArr = array.mutableCopy;
    self.clickCellIndexBlock=clickCellIndexBlock;
    [self addSubView];
    return self;
}

-(void)addSubView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SP_SCREEN_WIDTH, SP_SCREEN_HEIGHT-self.marginTop)];
    view.backgroundColor = [UIColor clearColor];
    
    [self.boxView addSubview:view];
    [view addSubview:self.tableView];
    [view addSubview:self.cancelB];
}

-(void)show
{
    [super show];
    [self.tableView reloadData];
}

#pragma mark - lazy

- (UIButton *)cancelB {
    if (_cancelB == nil) {
        SP_WEAK_SELF
        _cancelB = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelB.backgroundColor = [UIColor whiteColor];
        _cancelB.frame = CGRectMake(16, self.boxView.mj_h-cellHeight-10, SP_SCREEN_WIDTH-32, cellHeight);
        [_cancelB setTitleForAllStateWithString:@"取消"];
        [_cancelB setTitleColorForAllStateWithColor:UIColor.blueColor];
        _cancelB.layer.cornerRadius = 10;
        [_cancelB sp_button_onClickBlock:^(id object) {
            [weak_self dismiss];
        }];
    }
    return _cancelB;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(16, 0, SP_SCREEN_WIDTH-32,SP_SCREEN_HEIGHT-self.marginTop-cellHeight-20) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.pagingEnabled = NO;
        _tableView.separatorStyle =UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
//        _tableView.allowsSelection =NO;
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"UITableViewCell"];
        
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.layer.cornerRadius = 10;
    }
    return _tableView;
}

#pragma mark - tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableViewArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *string = [self.tableViewArr objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = string;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.clickCellIndexBlock) {
        self.clickCellIndexBlock(indexPath.row);
    }
    [self dismiss];
}
@end

