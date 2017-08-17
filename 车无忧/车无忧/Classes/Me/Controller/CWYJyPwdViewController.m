//
//  CWYJyPwdViewController.m
//  车无忧
//
//  Created by 陈欢 on 2017/7/30.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYJyPwdViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
@interface CWYJyPwdViewController ()
@property (weak, nonatomic) IBOutlet UITextField *firstJyPwd;
@property (weak, nonatomic) IBOutlet UITextField *secondJyPwd;

@property (nonatomic, strong) AFHTTPSessionManager *jyPwdManager;
@property (weak, nonatomic) IBOutlet UIButton *jySettingPwd;

@end

@implementation CWYJyPwdViewController


- (AFHTTPSessionManager *)jyPwdManager
{
    if (!_jyPwdManager) {
        _jyPwdManager = [AFHTTPSessionManager manager];
    }
    
    return _jyPwdManager;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.firstJyPwd addTarget:self action:@selector(jySetting) forControlEvents:UIControlEventEditingChanged];
    [self setupNav];
    // Do any additional setup after loading the view from its nib.
}

- (void)jySetting
{
    if (self.firstJyPwd.text.length > 0) {
        self.jySettingPwd.backgroundColor = [UIColor redColor];
    } else
    {
        self.jySettingPwd.backgroundColor = [UIColor lightGrayColor];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)settingJyPwd:(UIButton *)sender {
    
    
//    NSDictionary *parame = [NSDictionary dictionary];
//    
//    parame[@"uid"] = @"15846140786";
//    parame[@"pwd"] = self.firstJyPwd.text;
    
    if (self.firstJyPwd.text.length != 6 ) {
        [SVProgressHUD showErrorWithStatus:@"请设置6位支付密码"];
    }
    
    if (self.firstJyPwd.text != self.secondJyPwd.text) {
        [SVProgressHUD showErrorWithStatus:@"输入相同支付密码"];
        
        return;
    }
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    
    
    
    
    //params[@"uid"] = [user stringForKey:@"uid"];
    
    id par = @{@"uid":[user stringForKey:@"uid"],
                   @"pwd":self.firstJyPwd.text
                   
                   };
    
    
    [self.jyPwdManager POST:@"http://www.zhanyiwangluo.com/washcar/index.php/Home/User/buyPwd" parameters:par progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        CHLog(@"%@",responseObject);
        [SVProgressHUD showSuccessWithStatus:@"设置支付密码成功"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        CHLog(@"%@",error);
    }];
    
    
    
    
}


- (void)setupNav
{
    self.title = @"设置交易密码";
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
    [self.jyPwdManager.operationQueue cancelAllOperations];
    
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
