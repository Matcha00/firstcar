//
//  CWYChangePwdViewController.m
//  车无忧
//
//  Created by 陈欢 on 2017/7/24.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYChangePwdViewController.h"
#import "CWYRechargePasswordViewController.h"
#import <AFNetworking.h>
#import "CWYSnsCode.h"
#import <MJExtension.h>
#import "SNSCodeCountdownButton.h"
#import <SVProgressHUD.h>
@interface CWYChangePwdViewController () <SNSCodeCountdownButtonDelegate>



@property (weak, nonatomic) IBOutlet SNSCodeCountdownButton *forgoTBtn;

@property (nonatomic, strong) AFHTTPSessionManager *wjManager;

@property (weak, nonatomic) IBOutlet UITextField *phoneChange;

@property (nonatomic, strong) NSArray *snsWjarray;
@property (weak, nonatomic) IBOutlet UIButton *tjyzmBtn;

@end

@implementation CWYChangePwdViewController


- (AFHTTPSessionManager *)wjManager
{
    if (!_wjManager) {
        _wjManager = [AFHTTPSessionManager manager];
    }
    
    return _wjManager;
}


- (NSArray *)snsWjarray
{
    if (!_snsWjarray) {
        _snsWjarray = [NSArray array];
    }
    
    return _snsWjarray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.forgoTBtn.delegate = self;
    self.forgoTBtn.countdownBeginNumber = 60;
    self.forgoTBtn.normalStateImageName = @"NULL";
    self.forgoTBtn.selectedStateImageName = @"NULL";
    
    
    [self setupNav];
    
    
    [self.phoneChange addTarget:self action:@selector(yzmChange) forControlEvents:UIControlEventEditingChanged];
    // Do any additional setup after loading the view from its nib.
}

- (void)yzmChange
{
    if (self.phoneChange.text.length > 0) {
         self.tjyzmBtn.backgroundColor = [UIColor redColor];
    } else {
        self.tjyzmBtn.backgroundColor = [UIColor lightGrayColor];
    }
        
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


- (void)snsCodeCountdownButtonClicked

{
    id par = @{
               
               @"phone":self.phoneChange.text
               
               };
    
    [self.wjManager POST:@"http://www.zhanyiwangluo.com/washcar/index.php/Home/Note/index" parameters:par progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        self.snsWjarray = [CWYSnsCode mj_objectWithKeyValues:responseObject];
        [SVProgressHUD showSuccessWithStatus:@"验证码发送成功"];
        CHLog(@"%@", responseObject);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


- (void)setupNav
{
    self.title = @"找回密码";
    
    
    //self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationButtonReturn" highImage:@"navigationButtonReturnClick" target:self action:@selector(back)];
    
    
    //self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"fx" highImage:@"fx" target:self action:@selector(back)];
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor whiteColor]}] ;
    
    
    
    
    
}
- (IBAction)nextLog:(UIButton *)sender {
    
    
    
    
    if ([self.phoneChange.text isEqualToString:@""]) {
        
        [SVProgressHUD showErrorWithStatus:@"手机号不能为空！！！"];
        
        return;
    }
    
    if (self.phoneChange.text.length < 11) {
        
        [SVProgressHUD showErrorWithStatus:@"手机号不能小于11位！！！"];
        return;
    }
    
    if (self.forgoTBtn.userInteractionEnabled == YES) {
        
        [SVProgressHUD showErrorWithStatus:@"请获取验证码"];
        return;
    }

    
    
    
    
    CWYRechargePasswordViewController *pwdVc = [[CWYRechargePasswordViewController alloc]init];
    pwdVc.phoneWj = self.phoneChange.text;
    pwdVc.loginWj = self.snsWjarray;
    
    [self.navigationController pushViewController:pwdVc animated:YES];
    
    
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)recharPwd:(UIButton *)btn {
    
    
    //btn.enabled=(self.phoneChange.text.length!=0&&self.phoneChange.text.length!=0);
    
//    NSString *apiUrl = [NSString stringWithFormat:@"%@,%@", CHUrl,@"User/seekPwd"];
//    
//    id params = @{
//                  @"phone": self.phoneChange.text,
//                  @"verify": self.yzmChange.text
//                  };
//    
//    
////    [manager POST:apiUrl parameters:<#(nullable id)#> progress:<#^(NSProgress * _Nonnull uploadProgress)uploadProgress#> success:<#^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)success#> failure:<#^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)failure#>]
////    
//    
//    
//
    
    
    
    
    
}
@end
