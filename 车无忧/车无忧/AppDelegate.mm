//
//  AppDelegate.m
//  车无忧
//
//  Created by 陈欢 on 2017/7/12.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "AppDelegate.h"
#import "CHWTabBarViewController.h"
#import "CWYLoginViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

#import "WXApi.h"

@interface AppDelegate () <UITabBarControllerDelegate,UIAlertViewDelegate,WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // Override point for customization after application launch.
    
    //SOq7hFRdXnHVGitEn7HOK4P906ToEilp
    
    NSString *wxId = @"wxa9676173c95f28fa";
    
    [WXApi registerApp:wxId];
     
    
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"SOq7hFRdXnHVGitEn7HOK4P906ToEilp"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    UINavigationBar *bar = [UINavigationBar  appearance];
    
    UITabBar *tab = [UITabBar appearance];
    
    tab.barTintColor = [UIColor redColor];
    
    bar.barTintColor = [UIColor redColor];//CHRGBColor(250, 60 , 60);
    
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    // 设置窗口的根控制器
    CHWTabBarViewController *tabBarVc = [[CHWTabBarViewController alloc]init];
    
    tabBarVc.delegate = self;
    
    self.window.rootViewController = tabBarVc;
    
    // 显示窗口
    [self.window makeKeyAndVisible];
    return YES;
}



#pragma mark WXApiDelegate 微信分享的相关回调

// onReq是微信终端向第三方程序发起请求，要求第三方程序响应。第三方程序响应完后必须调用sendRsp返回。在调用sendRsp返回时，会切回到微信终端程序界面
- (void)onReq:(BaseReq *)req
{
    NSLog(@"onReq是微信终端向第三方程序发起请求，要求第三方程序响应。第三方程序响应完后必须调用sendRsp返回。在调用sendRsp返回时，会切回到微信终端程序界面");
}

// 如果第三方程序向微信发送了sendReq的请求，那么onResp会被回调。sendReq请求调用后，会切到微信终端程序界面
- (void)onResp:(BaseResp *)resp
{
    NSLog(@"回调处理");
    
    // 处理 分享请求 回调
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        switch (resp.errCode) {
            case WXSuccess:
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"分享成功!"
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
                [alert show];
            }
                break;
                
            default:
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"分享失败!"
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
                [alert show];
            }
                break;
        }
    }
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    
    [WXApi handleOpenURL:url delegate:self];
    
    return YES;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    [WXApi handleOpenURL:url delegate:self];
    return YES;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [WXApi handleOpenURL:url delegate:self];
    return YES;
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    
    NSString   *isLogIn = [user stringForKey:@"isLogIn"];
    //"我的"页面的tabbarItem的下标是2,
    //_privateToken == nil 为判断是否登录的条件
    if (viewController == tabBarController.viewControllers[2] && ! [isLogIn isEqualToString:@"YES"]) {
        //LoginViewController *loginViewController = [LoginViewController new];
        
        
//        UIStoryboard *loginStory = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
//        
//        CWYLoginViewController *loginVc = [loginStory instantiateViewControllerWithIdentifier:@"CWYLoginViewController"];
//        
////        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVc];
////        [((UINavigationController *)tabBarController.selectedViewController) presentViewController:nav animated:YES completion:nil];
//        //[self presentViewController:resVc animated:YES completion:nil];
//        
//         //[((UINavigationController *)tabBarController.selectedViewController)pushViewController:loginVc animated:YES];
//        
//          [((UINavigationController *)tabBarController.selectedViewController) presentViewController:loginVc animated:YES completion:nil];
        UIStoryboard *loginStory = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        
        CWYLoginViewController *loginVc = [loginStory instantiateViewControllerWithIdentifier:@"CWYLoginViewController"];
        
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVc];
         [((UINavigationController *)tabBarController.selectedViewController) presentViewController:nav animated:YES completion:nil];
        //[self presentViewController:nav animated:YES completion:nil];
        
        return NO;
    } else {
        
        tabBarController.selectedIndex = 2;

        
        return YES;
    }
}


@end
