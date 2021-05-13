//
//  LSPDebugView.m
//  ApolloApi
//
//  Created by lishiping on 2020/8/15.
//  Copyright © 2020 新东方. All rights reserved.
//

#import "LSPDebugView.h"
#import "NSString+SPSize.h"
#import "UIButton+SPAction.h"
#import <Masonry/Masonry.h>

@interface LSPDebugViewModel : NSObject

@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) CGFloat height;

@end

@implementation LSPDebugViewModel

@end

@interface LSPDebugViewCell : UITableViewCell

@property (nonatomic, strong) LSPDebugViewModel *model;
@property (nonatomic, strong) UILabel *noticeLabel;

/// 获取当前cell缓存高度
/// @param model 根据数据模型计算
+(CGFloat)getHeight:(LSPDebugViewModel *)model;

@end

@implementation LSPDebugViewCell

+(CGFloat)getHeight:(LSPDebugViewModel *)model
{
    if (model.height>0) {
        return model.height;
    }
    CGSize size = [model.content sp_getSize_maxSize:CGSizeMake(LSPDebugView_Width, MAXFLOAT) font:[UIFont systemFontOfSize:10]];
    model.height = size.height;
    return model.height;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.noticeLabel = [[UILabel alloc] init];
        self.noticeLabel.textAlignment = NSTextAlignmentLeft;
        self.noticeLabel.font = [UIFont systemFontOfSize:10];
        self.noticeLabel.textColor = UIColor.greenColor;
        [self.noticeLabel sizeToFit];
        self.noticeLabel.numberOfLines = 0;
        [self.contentView addSubview:self.noticeLabel];
        [self.noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return self;
}
-(void)setModel:(LSPDebugViewModel *)model
{
    _model = model;
    self.noticeLabel.text = model.content;
}

@end

@interface LSPDebugView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *tableviewMArr;

@end

@implementation LSPDebugView

-(void)addLog:(NSArray *)logArr
{
    NSMutableArray *marr = [[NSMutableArray alloc] init];
    [logArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LSPDebugViewModel *model= [[LSPDebugViewModel alloc] init];
       model.content = obj;
       [marr addObject:model];
    }];
    self.tableviewMArr = marr;
    [self.tableview reloadData];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    UIButton *hideB = [UIButton buttonWithType:UIButtonTypeCustom];
    [hideB setTitle:@"隐藏" forState:UIControlStateNormal];
    __weak typeof(self) weak_self = self;
    [hideB sp_button_onClickBlock:^(id object) {
        [weak_self removeFromSuperview];
    }];
    [self addSubview:hideB];
    [hideB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(0);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshLog:) name:@"lsplog_refresh" object:nil];
    return self;
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)refreshLog:(NSNotification*)no
{
    NSString *string = no.object;
    LSPDebugViewModel *model = [[LSPDebugViewModel alloc] init];
    model.content = string;
    [self.tableviewMArr addObject:model];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.tableviewMArr.count-1 inSection:0];
    [self.tableview beginUpdates];
    [self.tableview insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableview endUpdates];
    [self.tableview scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

#pragma mark  - tableview delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableviewMArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LSPDebugViewModel *model = self.tableviewMArr[indexPath.row];
    return [LSPDebugViewCell getHeight:model];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LSPDebugViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(LSPDebugViewCell.class) forIndexPath:indexPath];
    LSPDebugViewModel *model = self.tableviewMArr[indexPath.row];
    cell.model = model;
    return cell;
}

- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        [_tableview registerClass:LSPDebugViewCell.class forCellReuseIdentifier:NSStringFromClass(LSPDebugViewCell.class)];
        _tableview.alwaysBounceVertical = YES;
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _tableview.allowsSelection = NO;
        _tableview.dataSource = self;
        _tableview.delegate = self;
    }
    return _tableview;
}

@end
