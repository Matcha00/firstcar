//
//  CWYRegisterSecondViewController.m
//  车无忧
//
//  Created by 陈欢 on 2017/7/30.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYRegisterSecondViewController.h"
#import <AFNetworking.h>
#import "CWYSnsCode.h"
#import "SNSCodeCountdownButton.h"
#import <SVProgressHUD.h>
@interface CWYRegisterSecondViewController () <SNSCodeCountdownButtonDelegate>
@property (weak, nonatomic) IBOutlet UITextField *smsSecond;
@property (weak, nonatomic) IBOutlet UITextField *settingPwd;
@property (weak, nonatomic) IBOutlet UITextField *personText;
@property (weak, nonatomic) IBOutlet SNSCodeCountdownButton *snsRegisterBtn;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;
@property (nonatomic, strong) AFHTTPSessionManager *registerManager;
@end

@implementation CWYRegisterSecondViewController


- (AFHTTPSessionManager *)registerManager
{
    if (!_registerManager) {
        _registerManager = [AFHTTPSessionManager manager];
    }
    
    return _registerManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.snsRegisterBtn.delegate = self;
    self.snsRegisterBtn.countdownBeginNumber = 60;
    self.snsRegisterBtn.normalStateImageName = @"NULL";
    self.snsRegisterBtn.selectedStateImageName = @"NULL";
    
    CHLog(@"%@", self.phoneNumber);
    CHLog(@"%@", self.snsCode.ID);
    [self setupNav];
    [self.smsSecond addTarget:self action:@selector(changeSns) forControlEvents:UIControlEventEditingChanged];
    
    //[self.personText addTarget:self action:@selector(showBt) forControlEvents:UIControlEventEditingDidEnd];
    // Do any additional setup after loading the view from its nib.
}



//- (void)showBt
//{
//    CHLog(@"ssssssss");
//    
//    
//    if (self.personText.text == self.phoneNumber) {
//        [SVProgressHUD showErrorWithStatus:@"推荐人为自己"];
//        return;
//    }
//}

- (void)changeSns
{
    if (self.smsSecond.text.length > 0) {
        self.finishButton.backgroundColor = [UIColor redColor];
    } else
    {
        self.finishButton.backgroundColor = [UIColor lightGrayColor];
    }
}


- (void)snsCodeCountdownButtonClicked{
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)registerBtn:(id)sender {
    
    if ([self.smsSecond.text isEqualToString:@""]) {
        
        [SVProgressHUD showErrorWithStatus:@"验证码不能为空"];
        
        return;
        
    }
    
    if ([self.settingPwd.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"密码不能为空"];
        
        return;
    }
    
    
    if (self.settingPwd.text.length <6) {
        
        [SVProgressHUD showErrorWithStatus:@"密码长度必须大于6"];
        
        return;
    }
    
    
    if ([self.personText.text isEqualToString:self.phoneNumber]) {
        [SVProgressHUD showErrorWithStatus:@"推荐人为自己"];
        return;
    }
    
    id par = @{
               
               @"phone":self.phoneNumber,
               @"verify":self.smsSecond.text,
               @"verify_id": self.snsCode.ID,
               @"pwd":self.settingPwd.text,
               @"recommend":self.personText.text
               };
    [self.registerManager POST:@"http://www.zhanyiwangluo.com/washcar/index.php/Home/User/register" parameters:par progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *success = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        
        NSString *chmessage = [NSString stringWithFormat:@"%@",responseObject[@"message"]];
        
        CHLog(@"%@",chmessage);
        
        if ([success isEqualToString:@"200"]) {
            
            
            
            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        } else if ([chmessage isEqualToString:@"验证码不正确"]) {
            
            [SVProgressHUD showErrorWithStatus:@"验证码不正确有误"];
            
            
        }else
        {
            [SVProgressHUD showErrorWithStatus:@"当前手机号已经注册！！"];
        }
        
        
        NSLog(@"%@",responseObject);
        NSLog(@"%@",par);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
         [SVProgressHUD showErrorWithStatus:@"请检查手机网络"];
        
    }];
    
//clang: error: linker command failed with exit code 1 (use -v to see invocation)

    
}


- (void)setupNav
{
    self.title = @"注册账号";
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
    [self.registerManager.operationQueue cancelAllOperations];
    
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
