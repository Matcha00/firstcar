//
//  CWYZZFKViewController.m
//  车无忧
//
//  Created by 陈欢 on 2017/8/16.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYZZFKViewController.h"
#import "CWYServe.h"
#import "PaymentView.h"
#import "PasswordBuild.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
@interface CWYZZFKViewController ()

@property (weak, nonatomic) IBOutlet UITextField *zzTextField;

@property (nonatomic, strong) AFHTTPSessionManager *zzManager;

@end

@implementation CWYZZFKViewController


- (AFHTTPSessionManager *)zzManager
{
    if (!_zzManager) {
        _zzManager = [AFHTTPSessionManager manager];
    }
    
    return _zzManager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)zzfkButton:(UIButton *)sender {
    
    
    
    if ([self.zzTextField.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入购买金额"];
        return;
    }
    
    
    
    PaymentView * payView = [[PaymentView alloc] init];
    payView.title = self.severZZ.title;
    payView.payType = PaymentTypeCard;
    payView.alertType = PayAlertTypeSheet;
    payView.translateType = PayTranslateTypeSlide;
    payView.payDescrip = self.severZZ.title;
    payView.payTool = @"积分付款";
    payView.payAmount= [self.zzTextField.text floatValue];
    
    payView.pwdCount = 6;
    [payView show];
    [payView reloadPaymentView];
    payView.completeHandle = ^(NSString *inputPwd) {
        // NSLog(@"密码是%@",inputPwd);
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        WS(ws);
        
        //[user stringForKey:@"uid"];
        
        
        //        id pam = @{
        //                   @"uid":[user stringForKey:@"uid"],
        //                   @"s_id":sevre.ID,
        //                   @"amount":sevre.amount,
        //                   @"buy_pwd":inputPwd
        //                   };
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        
        params[@"uid"] = [user stringForKey:@"uid"];
        params[@"s_id"] = self.severZZ.ID;
        params[@"amount"] = self.zzTextField.text;
        params[@"buy_pwd"] = inputPwd;
        
        CHLog(@"%@,pam",params);
        
        [ws.zzManager POST:@"http://www.zhanyiwangluo.com/washcar/index.php/Home/Buy/index" parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSString *message = [NSString stringWithFormat:@"%@", responseObject[@"message"]];
            
            
            CHLog(@"%@",responseObject);
            // CHLog(@"%@,pam",pam);
            //[0]	(null)	 :
            
            if ([message isEqualToString:@"交易密码错误！"]) {
                [SVProgressHUD showErrorWithStatus:@"交易密码错误"];
                return ;
            } else
            {
                [SVProgressHUD showSuccessWithStatus:@"购买成功"];
            }
            
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    };

    
    
    
    
    
    
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
