//
//  SPBaseVC.m
//  e-mail:83118274@qq.com
//
//  Created by lishiping on 16/11/11.
//  Copyright (c) 2016年 lishiping. All rights reserved.
//
//If you think this open source library is of great help to you, please open the URL to click the Star,your approbation can encourage me, the author will publish the better open source library for guys again
//如果您认为本开源库对您很有帮助，请打开URL给作者点个赞，您的认可给作者极大的鼓励，作者还会发布更好的开源库给大家

//github address//https://github.com/lishiping/SPWebView
//github address//https://github.com/lishiping/SPDebugBar
//github address//https://github.com/lishiping/SPFastPush
//github address//https://github.com/lishiping/SPMacro
//github address//https://github.com/lishiping/SafeData
//github address//https://github.com/lishiping/SPCategory/
//github address//https://github.com/lishiping/SPBaseClass

#import "SPBaseVC.h"
#import <objc/runtime.h>

@interface SPBaseVC ()

@end

@implementation SPBaseVC

- (void)loadView
{
    [super loadView];
    
    //1.这个属性看单词的意思，延伸视图包含不包含不透明的Bar,是用来指定导航栏是透明的还是不透明
    //2.IOS7中默认是YES，当滚动页面的时候我们隐约能在导航栏下面看到我们页面的试图：
    //3.但是当我们设置一张不透明的图片作为导航栏背景时,该属性就会变成NO,这样不透明以后我们可以人为设置成YES达到延伸至导航栏的效果
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    //1.边缘要延伸的方向,UIRectEdgeAll的意思是全屏布局模式，
    //2.有导航栏的情况顶部是按照从状态栏上方0开始计算
    //3.如果想要从导航栏下方开始做0的起始点计算设置成UIRectEdgeNone
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    //self.extendedLayoutIncludesOpaqueBars = NO;
    //如果以上两个属性任意一个设置成不可延伸，则0计算起点都从导航栏下方开始，为了统一所有布局，所以设置成两者都可以延伸
    
    //1.自动判断滚动视图的内边距，
    //2.要说这个Insets呢我们就要首先说说scroll视图contentInset这个属性,
    //3.注意：该属性在ios7中默认开启，也就是说滚动视图的显示会通过计算状态栏导航栏的显示情况来偏移相应的位置,假如状态栏显示，导航栏隐藏向下偏移20，状态栏隐藏，导航栏显示偏移44，两者都显示偏移64，都隐藏则不偏移
    //4.如果我们想自己控制滚动视图显示问题，我们就可以设置成NO。这样所有的滚动视图将不做显示偏移
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //1.这个属性说的是，当前控制器present一个其他控制器上的非全屏界面我们是否接管status bar的外观，
    //2.默认是NO,（我们从一个界面A present另一个全屏界面B时，status Bar 的外观控制被转交给被B ）
    //3.假如我们设置成YES，我们可以指定B界面的status bar，即使是非全屏的
    //4.这个属性当present一个全屏界面时是被系统忽略的
    self.modalPresentationCapturesStatusBarAppearance = NO;
    
    //1.clipsToBounds 决定了子视图的显示范围。
    //2.具体的说，就是当它取值为YES时，剪裁超出父视图范围的子视图部分；
    //3.当它取值为 NO 时，不剪裁子视图。
    //4.默认值为 NO，但是在 UIScrollView 中，它的默认值是YES，也就是说默认裁剪的。
    self.view.clipsToBounds = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc;
{
    //取消延迟执行的方法
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    //移出所有self的通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    //移出所有内联对象
    objc_removeAssociatedObjects(self);
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}


@end
