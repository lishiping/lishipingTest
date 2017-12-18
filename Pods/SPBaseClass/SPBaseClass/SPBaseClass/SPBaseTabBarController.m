//
//  SPBaseNavigationController.m
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


#import "SPBaseTabBarController.h"
#import "SPBaseNavigationController.h"

@interface SPBaseTabBarController ()<UITabBarControllerDelegate>

@property UITabBarControllerBlock block;

@end

@implementation SPBaseTabBarController

#pragma mark - life cycle
-(instancetype)init_didSelectViewControllerBlock:(UITabBarControllerBlock)block
{
    self = [super init];
    self.block = block;
    __weak typeof(self) weakself = self;
    self.delegate = weakself;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - events

- (void)addItemController:(UIViewController*)itemController
         tabBarItem_title:(NSString*)title
         tabBarItem_image:(UIImage*)image
 tabBarItem_selectedImage:(UIImage*)selectedImage

{
    
    [self addItemController:itemController tabBarItem_title:title tabBarItem_image:image tabBarItem_selectedImage:selectedImage tabBarItem_badgeValue:nil];
}

- (void)addItemController:(UIViewController*)itemController
         tabBarItem_title:(NSString*)title
         tabBarItem_image:(UIImage*)image
 tabBarItem_selectedImage:(UIImage*)selectedImage
    tabBarItem_badgeValue:(NSString*)badgeValue

{
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title
                                                             image:image
                                                     selectedImage:selectedImage];
    tabBarItem.badgeValue = badgeValue;
        
    [self addItemController:itemController tabBarItem_title:title tabBarItem_titleFont:nil tabBarItem_titleunselectColor:nil tabBarItem_titleselectColor:nil tabBarItem_image:image tabBarItem_selectedImage:selectedImage tabBarItem_badgeValue:badgeValue];
}

- (void)addItemController:(UIViewController*)itemController
         tabBarItem_title:(NSString*)title
     tabBarItem_titleFont:(UIFont*)titleFont
tabBarItem_titleunselectColor:(UIColor*)titleunselectColor
tabBarItem_titleselectColor:(UIColor*)titleselectColor
         tabBarItem_image:(UIImage*)image
 tabBarItem_selectedImage:(UIImage*)selectedImage
    tabBarItem_badgeValue:(NSString*)badgeValue

{
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title
                                                             image:image
                                                     selectedImage:selectedImage];
    tabBarItem.badgeValue = badgeValue;
    
    
    if ([titleunselectColor isKindOfClass:[UIColor class]] &&
        [titleselectColor isKindOfClass:[UIColor class]] &&
        [titleFont isKindOfClass:[UIFont class]])
    {
        //未选中颜色
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:titleunselectColor,NSFontAttributeName:titleFont} forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:titleselectColor,NSFontAttributeName:titleFont} forState:UIControlStateSelected];

    }
        
    [self addNavigationController:itemController tabBarItem:tabBarItem];
}

- (void)addNavigationController:(UIViewController*)itemController tabBarItem:(UITabBarItem*)tabBarItem
{
    if ([itemController isKindOfClass:[UIViewController class]]) {
        //如果是导航控制器
        if ([itemController isKindOfClass:[UINavigationController class]])
        {
            itemController.tabBarItem = tabBarItem;
            [self addChildViewController:itemController];
        }
        //如果不是标签控制器，就应该是视图控制器了
        else if (![itemController isKindOfClass:[UITabBarController class]])
        {
            SPBaseNavigationController *navi = [[SPBaseNavigationController alloc] initWithRootViewController:itemController];
            navi.tabBarItem = tabBarItem;
            [self addChildViewController:navi];
        }
    }
}

- (void)addItemController:(UIViewController*)itemController tabBarItem:(UITabBarItem*)tabBarItem
{
    itemController.tabBarItem = tabBarItem;
    [self addChildViewController:itemController];
}

#pragma mark - delegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if (self.block) {
        self.block(tabBarController, viewController);
    }
}

@end
