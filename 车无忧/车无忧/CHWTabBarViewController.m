//
//  CHWViewController.m
//  车无忧
//
//  Created by 陈欢 on 2017/7/12.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CHWTabBarViewController.h"
#import "NNViewController.h"
#import "PersonViewController.h"
#import "CWYViewController.h"
#import "CWYHomeHeadViewController.h"
#import "CWYPersonTableViewController.h"
#import "CWYLoginViewController.h"
@interface CHWTabBarViewController ()

@end

@implementation CHWTabBarViewController



+ (void)initialize
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateHighlighted];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [UINavigationBar appearance];
//    
//    // 通过appearance统一设置所有UITabBarItem的文字属性
//    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
//    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
//    
//    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
//    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
//    selectedAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    
//    UITabBarItem *item = [UITabBarItem appearance];
//    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
//    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
//    [item setTitlePositionAdjustment:UIOffsetMake(0, 0)];
//    
//    self.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, 0, 0);
    //self.tabBarItem.titlePositionAdjustment = UIOffsetEqualToOffset(0, 10);
    // 添加子控制器
    
    [self setupChildVc:[[CWYHomeHeadViewController alloc] init] title:@"首页" image:@"first_nor" selectedImage:@"first_sel"];
    
    //[self setupChildVc:[[NNViewController alloc] init] title:@"首页" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    [self setupChildVc:[[NNViewController alloc] init] title:@"车生活" image:@"live_nor" selectedImage:@"live_sel"];
    
//    [self setupChildVc:[[CWYMeTableViewController alloc] init] title:@"个人中心" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setupChildVc:[[CWYPersonTableViewController alloc] init] title:@"个人中心" image:@"me_nor" selectedImage:@"me_sel"];
    

    
    
    
    
   
}

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置文字和图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    CWYViewController *nav = [[CWYViewController alloc] initWithRootViewController:vc];
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    [self addChildViewController:nav];
}

//- (void)viewWillLayoutSubviews{
//    CGRect tabFrame = self.tabBar.frame; //self.TabBar is IBOutlet of your TabBar
//    tabFrame.size.height = 70;
//    tabFrame.origin.y = self.view.frame.size.height - 70;
//    self.tabBar.frame = tabFrame;
//}



@end
