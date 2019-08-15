//
//  SecondHomeVC.m
//  lishipingTest
//
//  Created by shiping li on 2018/11/28.
//  Copyright © 2018年 shiping1. All rights reserved.
//

#import "SecondHomeVC.h"
#import <UITableViewCell+SPReuseIdentifier.h>
#import "People.h"
#import "People+eatB.h"
#import "Animal.h"
#import "Animal+eatA.h"
static int C = 8;
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
    
    self.tableViewDataArr = [[NSArray alloc] initWithObjects:@"GCD测试",@"时间转换",@"类别多方法测试",@"多线程",@"block测试", nil];
    
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
        case 1:
            [self testTimeTransfer];
            break;
        case 2:
            [self testCategory];
            break;
        case 4:
            [self blockFunc3];
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
//    //输出12死锁

//        dispatch_async(serialQueue, ^{
//            SP_LOG(@"2")
//            dispatch_sync(serialQueue, ^{
//                SP_LOG(@"3")
//            });
//            SP_LOG(@"4")
//        });
//        SP_LOG(@"5")
    //
    //    //输出12死锁
    
    
//    for (int i = 0; i<100; i++) {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            SP_LOG(@"%d",i)
//
//            SP_LOG(@"%@",[NSThread currentThread])
//            sleep(10000);
//        });
//    }
    
    
//        dispatch_async(serialQueue, ^{
//            SP_LOG(@"1")
//            sleep(1);
//            SP_LOG(@"1thread=%@",[NSThread currentThread])
//
//        });
//
//    dispatch_async(serialQueue, ^{
//        SP_LOG(@"2")
//        sleep(1);
//        SP_LOG(@"2thread=%@",[NSThread currentThread])
//
//
//    });
//    dispatch_sync(serialQueue, ^{
//        SP_LOG(@"3")
//        sleep(1);
//        SP_LOG(@"3thread=%@",[NSThread currentThread])
//
//    });
}

-(void)testTimeTransfer
{
    [self nsstringConversionNSDate:@"06:00"];
}

-(NSDate *)nsstringConversionNSDate:(NSString *)dateStr
{
    
//    [NSDate date]获取的是GMT时间，要想获得某个时区的时间，以下代码可以解决这个问题
    
    NSDate *date = [NSDate date];

//    NSTimeZone *zone = [NSTimeZone timeZoneForSecondsFromGMT:28800];
    NSTimeZone *zone = [NSTimeZone defaultTimeZone];

    NSInteger interval = [zone secondsFromGMTForDate: date];

    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];

    NSLog(@"%@", localeDate);
    
    NSDate* currentDate = [[NSDate date] dateByAddingTimeInterval:[[NSTimeZone defaultTimeZone] secondsFromGMTForDate:[NSDate date]]];

    
    static const unsigned componentFlags = (NSCalendarUnitEra|
                                            NSCalendarUnitYear|
                                            NSCalendarUnitMonth |
                                            NSCalendarUnitDay |
                                            NSCalendarUnitWeekOfMonth |
                                            NSCalendarUnitWeekOfYear |
                                            NSCalendarUnitHour |
                                            NSCalendarUnitMinute |
                                            NSCalendarUnitSecond |
                                            NSCalendarUnitWeekday |
                                            NSCalendarUnitTimeZone|
                                            NSCalendarUnitWeekdayOrdinal);
    
    NSDateComponents *components = [[NSCalendar autoupdatingCurrentCalendar] components:componentFlags fromDate:currentDate];
    components.hour = 2;
    components.minute = 10;
    components.second = 40;
    components.timeZone = [NSTimeZone systemTimeZone];
    
    NSDate *now=  [[NSCalendar autoupdatingCurrentCalendar] dateFromComponents:components];
    
    NSDate *nowtt=  [[NSCalendar autoupdatingCurrentCalendar] dateBySettingHour:14 minute:10 second:40 ofDate:currentDate options:NSCalendarWrapComponents];

    return now;
}

-(void)testCategory{
//    People *p = [[People alloc] init];
//    [p eat];
    
//    [Animal test1];
    
    [[[Animal alloc] init] test];
}

-(void)testBLock{
    int i =10;
    SP_LOG(@"前%p",&i)
    dispatch_async(dispatch_get_main_queue(), ^{
        SP_LOG(@"%d",i)
        SP_LOG(@"中%p",&i)
        SP_LOG(@"%@",[NSThread currentThread])
//        i = 30;
//        SP_LOG(@"%d",i)
    });
    i = 20;
    SP_LOG(@"后%p",&i)

//    int i = 10;
//    dispatch_async(dispatch_get_main_queue(), ^{
//        SP_LOG(@"%d",i)
//        SP_LOG(@"%@",[NSThread currentThread])
////        i = 30;
//    });
//    i = 20;
}

-(BOOL)isExsitString1:(NSString*)string1  string2:(NSString*)string2
{
    BOOL ret = NO;
    
    NSArray *string2A = [string2 componentsSeparatedByString:@""];
    for (NSString *a in string2A) {
        if ([string1 isContainsString:a]) {
            ret = YES;
        }
    }
    
    return ret;
}

-(NSMutableArray*)test:(NSArray*)array{
    NSMutableArray *ma = [[NSMutableArray alloc] initWithCapacity:array.count];
    NSInteger x = [array[0] integerValue];
    for (int i=0; i<array.count; i++) {
        NSInteger y = [array[i] integerValue];
        NSInteger z = y/x;
        [ma addObject:[NSNumber numberWithInteger:z]];
    }
    return ma;
}

-(void)blockFunc3{
    SP_LOG(@"前%p",&C)

    void (^block)()=^{
        NSLog(@"%d",C);
        C = 20;
        SP_LOG(@"中%p",&C)

    };
    C = 20;
    SP_LOG(@"后%p",&C)

    block();
}

@end

