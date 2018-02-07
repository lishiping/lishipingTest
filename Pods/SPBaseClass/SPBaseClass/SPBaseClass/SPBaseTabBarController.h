//
//  SPBaseNavigationController.h
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


//使用方法
//self.window.rootViewController =[self addTabBarController];

//-(UITabBarController*)addTabBarController
//{
//    SPBaseTabBarController *tab = [[SPBaseTabBarController alloc] init_didSelectViewControllerBlock:^(UITabBarController *tabBarViewcontroller, UIViewController *viewcontroller) {
//        NSLog(@"选中后处理%lu",(unsigned long)tabBarViewcontroller.selectedIndex);
//        viewcontroller.tabBarItem.badgeValue = nil;
//    }];
//    
//    [tab addItemController:[SPBaseVC new]
//          tabBarItem_title:@"微信"
//          tabBarItem_image:nil
//  tabBarItem_selectedImage:nil
//     tabBarItem_badgeValue:@"推荐"];
//    
//    [tab addItemController:[SPBaseVC new]
//          tabBarItem_title:@"通讯录"
//          tabBarItem_image:nil
//  tabBarItem_selectedImage:nil];
//    
//    [tab addItemController:[SPBaseVC new]
//          tabBarItem_title:@"发现"
//      tabBarItem_titleFont:[UIFont systemFontOfSize:16]
//tabBarItem_titleunselectColor:[UIColor redColor]
//tabBarItem_titleselectColor:[UIColor greenColor]
//          tabBarItem_image:nil
//  tabBarItem_selectedImage:nil
//     tabBarItem_badgeValue:nil
//     ];
//    
//    [tab addItemController:[SPBaseVC new]
//          tabBarItem_title:@"我的"
//          tabBarItem_image:nil
//  tabBarItem_selectedImage:nil];
//    
//    return tab;
//}


#import <UIKit/UIKit.h>

typedef void(^UITabBarControllerBlock)(UITabBarController *tabBarViewcontroller,UIViewController *viewcontroller);

@interface SPBaseTabBarController : UITabBarController


/**
 初始化带有block点击tabbarItem回调的tabbarcontroller，代替了代理方法
 */
-(instancetype)init_didSelectViewControllerBlock:(UITabBarControllerBlock)block;

- (void)addItemController:(UIViewController*)itemController
         tabBarItem_title:(NSString*)title
         tabBarItem_image:(UIImage*)image
 tabBarItem_selectedImage:(UIImage*)selectedImage;

- (void)addItemController:(UIViewController*)itemController
         tabBarItem_title:(NSString*)title
         tabBarItem_image:(UIImage*)image
 tabBarItem_selectedImage:(UIImage*)selectedImage
    tabBarItem_badgeValue:(NSString*)badgeValue;

/**
 加入自定义tabbar的子视图控制器

 @param itemController vc
 @param title 标题
 @param titleFont 标题字体
 @param normalTitleColor 标题未选中颜色
 @param selectTitleColor 标题选中颜色
 @param image 标题图片
 @param selectedImage 标题选中图片
 @param badgeValue 标题角标
 */
- (void)addItemController:(UIViewController*)itemController
         tabBarItem_title:(NSString*)title
     tabBarItem_titleFont:(UIFont*)titleFont
tabBarItem_normalTitleColor:(UIColor*)normalTitleColor
tabBarItem_selectTitleColor:(UIColor*)selectTitleColor
         tabBarItem_image:(UIImage*)image
 tabBarItem_selectedImage:(UIImage*)selectedImage
    tabBarItem_badgeValue:(NSString*)badgeValue;


/**
 加入带导航控制器的VC

 @param itemController 视图控制器
 @param tabBarItem tabbar适配
 */
- (void)addNavigationController:(UIViewController*)itemController tabBarItem:(UITabBarItem*)tabBarItem;

- (void)addItemController:(UIViewController*)itemController tabBarItem:(UITabBarItem*)tabBarItem;


@end
