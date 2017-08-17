//
//  CWYJyChangeViewController.m
//  车无忧
//
//  Created by 陈欢 on 2017/7/30.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYJyChangeViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
@interface CWYJyChangeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *oldchangePwd;
@property (weak, nonatomic) IBOutlet UIButton *jyPwdBtn;

@property (weak, nonatomic) IBOutlet UITextField *secondChangePwd;
//@property (weak, nonatomic) IBOutlet UITextField *newJyChangePwd;
//@property (weak, nonatomic) IBOutlet UITextField *newJyPwd;
@property (weak, nonatomic) IBOutlet UITextField *tstt;
@property (nonatomic, strong) AFHTTPSessionManager *jyChangePwd;
@end

@implementation CWYJyChangeViewController

- (AFHTTPSessionManager *)jyChangePwd
{
    if (!_jyChangePwd) {
        _jyChangePwd = [AFHTTPSessionManager manager];
    }
    
    return _jyChangePwd;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.oldchangePwd addTarget:self action:@selector(jyChange) forControlEvents:UIControlEventEditingChanged];
    [self setupNav];
    // Do any additional setup after loading the view from its nib.
}


- (void)jyChange
{
    if (self.oldchangePwd.text.length > 0) {
        self.jyPwdBtn.backgroundColor = [UIColor redColor];
    } else
    {
        self.jyPwdBtn.backgroundColor = [UIColor lightGrayColor];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changeJyPwd:(UIButton *)sender {
    
    if (self.oldchangePwd.text == self.tstt.text) {
        [SVProgressHUD showErrorWithStatus:@"新密码与原密码相同"];
        return;
    }
    
    if (self.tstt.text.length < 6 ) {
        [SVProgressHUD showErrorWithStatus:@"密码长度小于6位数"];
        return;
    }
    
    if (self.tstt.text != self.secondChangePwd.text) {
        [SVProgressHUD showErrorWithStatus:@"两次密码不相同"];
        
        return;
    }
    
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
        //params[@"uid"] = [user stringForKey:@"uid"];
    
    
    id par = @{
               @"uid":[user stringForKey:@"uid"],
               @"old_pwd":self.oldchangePwd.text,
               @"new_pwd":self.tstt.text,
               @"state":@(1)
               };
    [self.jyChangePwd POST:@"http://www.zhanyiwangluo.com/washcar/index.php/Home/User/editPwd"  parameters:par progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *chmessage = [NSString stringWithFormat:@"%@",responseObject[@"message"]];
        
        CHLog(@"%@",responseObject);
        
        if ([chmessage isEqualToString:@"原密码错误"]) {
            [SVProgressHUD showErrorWithStatus:@"原密码错误"];
        } else
        {
            [SVProgressHUD showSuccessWithStatus:@"更改成功"];
        }

        
        CHLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


- (void)setupNav
{
    self.title = @"更改交易密码";
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
    [self.jyChangePwd.operationQueue cancelAllOperations];
    
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
