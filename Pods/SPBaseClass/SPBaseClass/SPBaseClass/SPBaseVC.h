//
//  SPBaseVC.h
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
//github address//https://github.com/lishiping/SPCategory
//github address//https://github.com/lishiping/SPBaseClass


#import <UIKit/UIKit.h>

@interface SPBaseVC : UIViewController

@property(nonatomic,copy)NSString *uiCode;//这个是可选参数为了标记UI页面和埋点使用，如果设置值可以传给下一页面使用（可选参数可不用理会）

//1.默认返回为YES,表示支持右滑返回
//2.继承该父类的子类VC里面如果重写了该方法，设置为NO，则表示不支持右滑返回
//3.该方法配合SPBaseNavigationController使用，原理请看两个类的结合
//4.如果想获得右滑手势，请在重写方法里面操作
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer;

@end
