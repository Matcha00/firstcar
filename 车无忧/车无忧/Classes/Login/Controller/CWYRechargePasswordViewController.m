//
//  CWYRechargePasswordViewController.m
//  车无忧
//
//  Created by 陈欢 on 2017/7/26.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYRechargePasswordViewController.h"
#import <AFNetworking.h>
#import "CWYSnsCode.h"
#import "SNSCodeCountdownButton.h"
#import <SVProgressHUD.h>
@interface CWYRechargePasswordViewController () <SNSCodeCountdownButtonDelegate>

//{
//    AFHTTPSessionManager *manager;
//}


@property (weak, nonatomic) IBOutlet UITextField *oldPwd;
@property (weak, nonatomic) IBOutlet SNSCodeCountdownButton *snsChangPwd;

@property (weak, nonatomic) IBOutlet UITextField *firstPwd;
//@property (weak, nonatomic) IBOutlet UITextField *secondPwd;
@property (weak, nonatomic) IBOutlet UIButton *changePwdButton;
@property (nonatomic , strong) AFHTTPSessionManager *changeManager;
@end

@implementation CWYRechargePasswordViewController



- (AFHTTPSessionManager *)changeManager
{
    if (!_changeManager) {
        _changeManager = [AFHTTPSessionManager manager];
    }
    
    return _changeManager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    
    self.snsChangPwd.delegate = self;
    self.snsChangPwd.countdownBeginNumber = 60;
    self.snsChangPwd.normalStateImageName = @"NULL";
    self.snsChangPwd.selectedStateImageName = @"NULL";
    [self.oldPwd addTarget:self action:@selector(oldChange) forControlEvents:UIControlEventEditingChanged];
    // Do any additional setup after loading the view from its nib.
}


- (void)oldChange

{
    if (self.oldPwd.text.length > 0) {
        self.changePwdButton.backgroundColor = [UIColor redColor];
    } else
    {
        self.changePwdButton.backgroundColor = [UIColor lightGrayColor];
    }
}


- (void)snsCodeCountdownButtonClicked
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)changePwd:(UIButton *)sender {
    
    
    if ([self.oldPwd.text isEqualToString:@""]) {
        
        [SVProgressHUD showErrorWithStatus:@"验证码不能为空"];
        
        return;
        
    }
    
    if ([self.firstPwd.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"密码不能为空"];
        
        return;
    }
    
    if (self.firstPwd.text.length < 6) {
        [SVProgressHUD showErrorWithStatus:@"密码不能小于6位数"];
        
        return;
    }
    
    
    id par = @{
               
               @"phone":self.phoneWj,
               @"verify":self.oldPwd.text,
               @"verify_id": self.loginWj.ID,
               @"pwd":self.firstPwd.text,
               @"state":@(0)
               };
    
    
    self.changeManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self.changeManager POST:@"http://www.zhanyiwangluo.com/washcar/index.php/Home/User/seekPwd" parameters:par progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        //NSLog(@"%@",par);
        
       // [SVProgressHUD showSuccessWithStatus:@""];
        
        
//        NSString *success = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
//        
//        NSString *chmessage = [NSString stringWithFormat:@"%@",responseObject[@"message"]];
//        
//        CHLog(@"%@",chmessage);
//        
//        if ([success isEqualToString:@"200"]) {
//            
//            
//            
//            [SVProgressHUD showSuccessWithStatus:@"密码重置成功"];
//            
//            [self.navigationController popToRootViewControllerAnimated:YES];
//            
//        } else if ([chmessage isEqualToString:@"验证码不正确"]) {
//            
//            [SVProgressHUD showErrorWithStatus:@"验证码不正确有误"];
//            
//            
//        }
//
//        
//       [self.navigationController popToRootViewControllerAnimated:YES];
        
        [SVProgressHUD showSuccessWithStatus:@"重置成功"];
        
        [self.navigationController popToRootViewControllerAnimated:YES];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

    
    
    
}


- (void)setupNav
{
    self.title = @"更改登录密码";
    
    
   // self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationButtonReturn" highImage:@"navigationButtonReturnClick" target:self action:@selector(back)];
    
    
    //self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"fx" highImage:@"fx" target:self action:@selector(back)];
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor whiteColor]}] ;
    
    
    
    
    
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
