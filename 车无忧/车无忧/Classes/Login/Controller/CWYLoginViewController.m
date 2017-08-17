//
//  CWYLoginViewController.m
//  车无忧
//
//  Created by 陈欢 on 2017/7/19.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYLoginViewController.h"
#import "CWYRegisterViewController.h"
#import "CWYChangePwdViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "CWYRegisterFirstViewController.h"
#import "CWYUser.h"
#import <YYModel.h>
@interface CWYLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (nonatomic , strong) AFHTTPSessionManager *manger;
@property (nonatomic, strong) NSArray *loninArray;
@end

@implementation CWYLoginViewController



- (AFHTTPSessionManager *)manger
{
    if (!_manger) {
        _manger = [AFHTTPSessionManager manager];
    }
    
    return _manger;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)registBtn:(id)sender {
    
    
    
    //UIStoryboard *resStory = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
    
   // CWYRegisterViewController *resVc = [resStory instantiateViewControllerWithIdentifier:@"Register"];
    CWYRegisterFirstViewController *vc = [[CWYRegisterFirstViewController alloc]init];
    
     [self.navigationController pushViewController:vc animated:YES];
    //[self presentViewController:vc animated:YES completion:nil];
}
- (IBAction)forgetPassword:(id)sender {
    
     CWYChangePwdViewController *vc = [[CWYChangePwdViewController alloc]init];
//    
//    UIWindow *window = [[UIApplication sharedApplication]keyWindow];
//    
//    UINavigationController *nav = (UINavigationController *)window.rootViewController;
//    
//    CWYLoginViewController *logVc = [nav.viewControllers objectAtIndex:1];
//    
//    
//    
//    
//    [logVc.navigationController  pushViewController:vc animated:YES];
    
    
    
//      UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
//     UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
//    
//     [root presentViewController:nav animated:YES completion:nil];
//    
//     NSLog(@"---------");
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (IBAction)logInBtn:(id)sender {
    
    
    if ([self.userName.text isEqualToString:@""]) {
        
        
        [SVProgressHUD showErrorWithStatus:@"用户名不能为空"];
        
        return;
    }
    
    
    if ([self.passWord.text isEqualToString:@""]) {
        
        [SVProgressHUD showErrorWithStatus:@"密码不能为空"];
        
        return;
    }
    
//    NSString *phone = self.userName.text;
//    
//    NSString *password = self.passWord.text;
    
//    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    
//    params[@"phone"] = @"123456";
//    params[@"password"] = @"123456";
    
    [SVProgressHUD showWithStatus:@"正在登录..."];
    
    id params = @{
                  @"phone": self.userName.text,
                  @"password": self.passWord.text
                  };
    
//    
//    [params setObject:@"phone" forKey:@"phone"];
//    [params setObject:@"password" forKey:@"password"];
    
    [self.manger POST:@"http://www.zhanyiwangluo.com/washcar/index.php/Home/User/login" parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"dddd");
        
        NSString *success = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        
        NSString *userUid = [NSString stringWithFormat:@"%@",responseObject[@"uid"]];
        CHLog(@"%@", params);
        NSLog(@"%@",success);
        NSLog(@"%@",responseObject[@"message"]);
        NSLog(@"%@+++++++++++++",responseObject[@"uid"]);
        CHLog(@"%@", responseObject);
        if ([success isEqualToString:@"200"]) {
            
            
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            
            [user setObject:self.userName.text forKey:@"username"];
            [user setObject:self.passWord.text forKey:@"password"];
            [user setObject:@"YES" forKey:@"isLogIn"];
            [user setObject:userUid forKey:@"uid"];
            
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            //[self back];
            [self dismissViewControllerAnimated:YES completion:nil];
            [user synchronize];

        } else {
            
            [SVProgressHUD showErrorWithStatus:@"用户名或密码错误"];

            
        }
        
//        self.loninArray = [CWYUser yy_modelWithDictionary:responseObject];
//        
//        CHLog(@"%888888@",self.loninArray);
//        
//        NSUserDefaults *userDe = [NSUserDefaults standardUserDefaults];
//        
//        [userDe setObject:self.userName.text forKey:@"username"];
//        [userDe setObject:self.passWord.text forKey:@"password"];
//        [userDe setObject:@"YES" forKey:@"isLogIn"];
//        
//        
//        
//        
//        [SVProgressHUD showSuccessWithStatus:@"登录成功"];
//        //[self back];
//        [userDe synchronize];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
        [SVProgressHUD showErrorWithStatus:@"请检查网络链接"];

        
    }];
    
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
     [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil]; 
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)dealloc
{
    [self.manger.operationQueue cancelAllOperations];
    
    [SVProgressHUD dismiss];
}

@end
