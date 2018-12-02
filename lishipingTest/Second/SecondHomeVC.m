//
//  SecondHomeVC.m
//  lishipingTest
//
//  Created by shiping li on 2018/11/28.
//  Copyright © 2018年 shiping1. All rights reserved.
//

#import "SecondHomeVC.h"
#import <UITableViewCell+SPReuseIdentifier.h>

@interface SecondHomeVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *tableViewDataArr;

@end

@implementation SecondHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:UITableViewCell.reuseIdentifier];
    
    self.tableViewDataArr = [[NSArray alloc] initWithObjects:@"GCD测试", nil];
    
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
            [self testGCD];
            break;
            
        default:
            break;
    }
}
//- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
//    <#code#>
//}

//- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
//    <#code#>
//}
//
//- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
//    <#code#>
//}
//
//- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
//    <#code#>
//}
//
//- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
//    <#code#>
//}

//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
//    <#code#>
//}
//
//- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
//    <#code#>
//}
//
//- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
//    <#code#>
//}
//
//- (void)setNeedsFocusUpdate {
//    <#code#>
//}
//
//- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
//    <#code#>
//}
//
//- (void)updateFocusIfNeeded {
//    <#code#>
//}


-(void)testGCD
{
    SP_LOG(@"测试GCD")
    
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.GCDDemo.concurrentQueue",DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t serialQueue = dispatch_queue_create("com.GCDDemo.serialQueue", DISPATCH_QUEUE_SERIAL);

//    SP_LOG(@"1")
//    dispatch_sync(concurrentQueue, ^{
//
//        SP_LOG(@"2")
//
//        dispatch_sync(concurrentQueue, ^{
//            SP_LOG(@"3")
//
//        });
//        SP_LOG(@"4")
//
//
//    });
//    SP_LOG(@"5")
//
//    //输出12345
    
    
//    SP_LOG(@"1")
//    dispatch_async(concurrentQueue, ^{
//
//        SP_LOG(@"2")
//
//        dispatch_async(concurrentQueue, ^{
//            SP_LOG(@"3")
//        });
//        SP_LOG(@"4")
//
//    });
//    SP_LOG(@"5")
//
//    //输出15243
    
//    SP_LOG(@"1")
//    dispatch_async(concurrentQueue, ^{
//
//        SP_LOG(@"2")
//
//        dispatch_sync(concurrentQueue, ^{
//            SP_LOG(@"3")
//        });
//        SP_LOG(@"4")
//
//    });
//    SP_LOG(@"5")
//
//    //输出15234
    
//    SP_LOG(@"1")
//    dispatch_sync(concurrentQueue, ^{
//
//        SP_LOG(@"2")
//
//        dispatch_async(concurrentQueue, ^{
//            SP_LOG(@"3")
//        });
//        SP_LOG(@"4")
//
//    });
//    SP_LOG(@"5")
//
//    //输出12435
    
//    SP_LOG(@"1")
//    dispatch_async(serialQueue, ^{
//
//        SP_LOG(@"2")
//
//        dispatch_async(serialQueue, ^{
//            SP_LOG(@"3")
//        });
//        SP_LOG(@"4")
//
//    });
//    SP_LOG(@"5")
//
//    //输出15243
    
    
    
//    SP_LOG(@"1")
//    dispatch_sync(serialQueue, ^{
//
//        SP_LOG(@"2")
//
//        dispatch_sync(serialQueue, ^{
//            SP_LOG(@"3")
//        });
//        SP_LOG(@"4")
//
//    });
//    SP_LOG(@"5")
//
//    //输出15243
    

    
    for (int i = 0; i<50; i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
           
//            SP_LOG(@"%@",[NSThread currentThread])
            sleep(10000);
        });
    }
}
@end
