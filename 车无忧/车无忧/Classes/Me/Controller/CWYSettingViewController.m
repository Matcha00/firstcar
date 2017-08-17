//
//  CWYSettingViewController.m
//  车无忧
//
//  Created by 陈欢 on 2017/7/16.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYSettingViewController.h"
#import <Masonry.h>
#import "CWYRechargePasswordViewController.h"
#import <SVProgressHUD.h>
#import "CWYJyPwdViewController.h"
#import "CWYJyChangeViewController.h"
#import "CWYChangeLoginPwdViewController.h"
#import "CWYPersonTableViewController.h"
#import "CWYAboutWeViewController.h"
@interface CWYSettingViewController ()
@property (weak, nonatomic) IBOutlet UIButton *versionButton;

@end

@implementation CWYSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   [self setupNav];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    //CFShow(infoDictionary);
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    CHLog(@"%@",app_Version);
    
    NSString *string1 = @"当前版本为";
    
    NSString *version = [string1 stringByAppendingString:app_Version];
    
    self.versionButton.titleLabel.text = version;
    
    //[self setupImage];
}
- (IBAction)settingBuyPwd:(id)sender {
    
    
    CWYJyPwdViewController *vc = [[CWYJyPwdViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)setupNav
{
    self.title = @"设置";
    self.view.backgroundColor = CHRGBColor(230, 230, 230);
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationButtonReturn" highImage:@"navigationButtonReturnClick" target:self action:@selector(back)];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor whiteColor]}] ;
}
- (IBAction)aboutBtn:(UIButton *)sender {
    
    CWYAboutWeViewController *about = [[CWYAboutWeViewController alloc]init];
    
    [self.navigationController pushViewController:about animated:YES];
    
    
}


- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)changeLoginPwd:(id)sender {
    
    //CWYRechargePasswordViewController *pwdVc = [[CWYRechargePasswordViewController alloc]init];
    
    CWYChangeLoginPwdViewController *pwdVc = [[CWYChangeLoginPwdViewController alloc]init];
    
    [self.navigationController pushViewController:pwdVc animated:YES];
    
    
}

- (IBAction)changeBuyPwd:(id)sender {
    
   //CWYRechargePasswordViewController *pwdVc = [[CWYRechargePasswordViewController alloc]init];
    
    CWYJyChangeViewController *pwdVc = [[CWYJyChangeViewController alloc]init];
    
    [self.navigationController pushViewController:pwdVc animated:YES];
}
- (IBAction)logOut:(id)sender {
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    //移除UserDefaults中存储的用户信息
    [user removeObjectForKey:@"uid"];
    [user removeObjectForKey:@"username"];
    [user removeObjectForKey:@"password"];
    [user removeObjectForKey:@"isLogIn"];
    [user synchronize];
    
    if ([[user stringForKey:@"isLogIn"] isEqualToString:@"YES"] ) {
        [SVProgressHUD showErrorWithStatus:@"退出失败"];
    }
    
    //[self.navigationController popViewControllerAnimated:YES];
    //[self back];
    
//    CWYPersonTableViewController *vc = [[CWYPersonTableViewController alloc]init];
//    
//    [self.navigationController pushViewController:vc  animated:YES];

    self.navigationController.tabBarController.selectedIndex = 0;
    [SVProgressHUD showSuccessWithStatus:@"退出成功"];
}

- (void)dealloc
{
    [SVProgressHUD dismiss];
}

@end


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




//- (void)setupView
//{
//    UIButton *changPwd  =  [[UIButton alloc]init];
//    changPwd.titleLabel.text = @"修改密码";
//    changPwd.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:changPwd];
//     __weak typeof(self) weakSelf = self;
//    [changPwd mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(CHScreenW, 60));
//        make.top.mas_equalTo(80);
//        make.centerX.equalTo(weakSelf.view);
//    }];
//    
//    UIButton *aboutBtn  =  [[UIButton alloc]init];
//    changPwd.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:aboutBtn];
//    
//    [aboutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(CHScreenW, 60));
//        make.top.mas_equalTo(160);
//        make.centerX.equalTo(weakSelf.view);
//
//        
//    }];
////
////    
////    UIButton *exitBtn  =  [[UIButton alloc]init];
////    changPwd.backgroundColor = [UIColor blackColor];
////    [self.view addSubview:exitBtn];
////    
////    [exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.size.mas_equalTo(CGSizeMake(CHScreenW, 60));
////        make.top.equalTo(aboutBtn).offset(100);
////    }];
//
//    
//    
//}


//- (void)setupNav
//{
//    self.title = @"设置";
//    self.view.backgroundColor = [UIColor whiteColor];
//    
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationButtonReturn" highImage:@"navigationButtonReturnClick" target:self action:@selector(back)];
//    
//    
//}
//
//
//- (void)back
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}
