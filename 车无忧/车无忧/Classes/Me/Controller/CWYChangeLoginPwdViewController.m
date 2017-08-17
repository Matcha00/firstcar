//
//  CWYChangeLoginPwdViewController.m
//  车无忧
//
//  Created by 陈欢 on 2017/8/1.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYChangeLoginPwdViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
@interface CWYChangeLoginPwdViewController ()
@property (weak, nonatomic) IBOutlet UIButton *changeLoginPwd;
@property (weak, nonatomic) IBOutlet UITextField *changeOlePwd;
@property (weak, nonatomic) IBOutlet UITextField *changeNewPwd;
@property (weak, nonatomic) IBOutlet UITextField *changeSecondPwd;
@property (nonatomic, strong) AFHTTPSessionManager *changeLoginManager;
@end

@implementation CWYChangeLoginPwdViewController


- (AFHTTPSessionManager *)changeLoginManager
{
    if (!_changeLoginManager) {
        _changeLoginManager = [AFHTTPSessionManager manager];
    }
    
    return _changeLoginManager;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    [self.changeOlePwd addTarget:self action:@selector(changLoginCH) forControlEvents:UIControlEventEditingChanged];
    [self setupNav];
    // Do any additional setup after loading the view from its nib.
}


- (void)changLoginCH
{
    if (self.changeOlePwd.text.length > 0) {
        self.changeLoginPwd.backgroundColor = [UIColor redColor];
    } else
    {
        self.changeLoginPwd.backgroundColor = [UIColor lightGrayColor];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changeLoginPwd:(id)sender {
    
    
    if (self.changeOlePwd.text == self.changeNewPwd.text) {
        [SVProgressHUD showErrorWithStatus:@"新密码与原密码相同"];
        return;
    }
    
    if (self.changeNewPwd.text.length < 6 ) {
        [SVProgressHUD showErrorWithStatus:@"密码长度小于6位数"];
        return;
    }
    
    if (self.changeNewPwd.text != self.changeSecondPwd.text) {
        [SVProgressHUD showErrorWithStatus:@"两次密码不相同"];
        
        return;
    }
    
    
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    
    id par = @{
               @"uid":[user stringForKey:@"uid"],
               @"old_pwd":self.changeOlePwd.text,
               @"new_pwd":self.changeNewPwd.text,
               @"state":@(0)
               };
    [self.changeLoginManager POST:@"http://www.zhanyiwangluo.com/washcar/index.php/Home/User/editPwd"  parameters:par progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *chmessage = [NSString stringWithFormat:@"%@",responseObject[@"message"]];
        
        CHLog(@"%@",responseObject);
        
        if ([chmessage isEqualToString:@"原密码错误！"]) {
            [SVProgressHUD showErrorWithStatus:@"原密码错误"];
        } else
        {
            [SVProgressHUD showSuccessWithStatus:@"更改成功"];
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"网络链接失败"];
        
    }];

    
    
    
}


- (void)setupNav
{
    self.title = @"更改登录密码";
    self.view.backgroundColor = CHRGBColor(245, 244, 244);
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationButtonReturn" highImage:@"navigationButtonReturnClick" target:self action:@selector(back)];
    
    
    //self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"fx" highImage:@"fx" target:self action:@selector(back)];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor whiteColor]}] ;
    
    
    
    
    
}


- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (void)dealloc
{
    [self.changeLoginManager.operationQueue cancelAllOperations];
    
    [SVProgressHUD dismiss];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
