//
//  CWYRegisterFirstViewController.m
//  车无忧
//
//  Created by 陈欢 on 2017/7/30.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYRegisterFirstViewController.h"
#import "CWYRegisterSecondViewController.h"
#import <AFNetworking.h>
#import "SNSCodeCountdownButton.h"
#import "CWYSnsCode.h"
#import <MJExtension.h>
#import <SVProgressHUD.h>
@interface CWYRegisterFirstViewController () <SNSCodeCountdownButtonDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (weak, nonatomic) IBOutlet SNSCodeCountdownButton *snsCodeBtn;

@property (nonatomic, weak) AFHTTPSessionManager *snsManager;

@property (nonatomic, strong) CWYSnsCode *snsCode;

@property (nonatomic, strong) NSArray *snsArray;

@property (nonatomic, strong) NSString *chsnsCode;

@end

@implementation CWYRegisterFirstViewController

- (NSArray *)snsArray
{
    if (!_snsArray) {
        _snsArray = [NSArray array];
    }
    
    return _snsArray;
}

- (AFHTTPSessionManager *)snsManager
{
    if (!_snsManager) {
        _snsManager = [AFHTTPSessionManager manager];
    }
    
    return _snsManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    self.snsCodeBtn.delegate = self;
    self.snsCodeBtn.countdownBeginNumber = 60;
    self.snsCodeBtn.normalStateImageName = @"NULL";
    self.snsCodeBtn.selectedStateImageName = @"NULL";
    self.snsCodeBtn.userInteractionEnabled = NO;
    
    
    
    
    [self.phoneText addTarget:self action:@selector(changePhone:) forControlEvents:UIControlEventEditingChanged];
    
    //self.phoneText.enabled = NO;
    
    // Do any additional setup after loading the view from its nib.
}



- (void)changePhone:(UITextField *)sender
{
    if (self.phoneText.text.length > 0) {
        
        self.nextButton.backgroundColor = [UIColor redColor];
        self.snsCodeBtn.userInteractionEnabled = YES;
        
    }else
    {
        self.nextButton.backgroundColor = [UIColor lightGrayColor];
        self.snsCodeBtn.userInteractionEnabled = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)nextReg:(UIButton *)sender {
    
    
    if ([self.phoneText.text isEqualToString:@""]) {
        
        [SVProgressHUD showErrorWithStatus:@"手机号不能为空！！！"];
        self.snsCodeBtn.userInteractionEnabled = NO;
        return;
    }
    
    if (self.phoneText.text.length < 11) {
        
        [SVProgressHUD showErrorWithStatus:@"手机号不能小于11位！！！"];
        return;
    }
    
    if (self.snsCodeBtn.userInteractionEnabled == YES) {
        
        [SVProgressHUD showErrorWithStatus:@"请获取验证码"];
        return;
    }
    
    
    //[self snsCodeCountdownButtonClicked];
    CWYRegisterSecondViewController *vc  = [[CWYRegisterSecondViewController alloc]init];
    vc.phoneNumber = self.phoneText.text;
    vc.snsCode = self.snsArray;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
    
    
}
- (IBAction)smsCode:(UIButton *)sender {
    
   
    
}


- (void)snsCodeCountdownButtonClicked
{
     CHLog(@"sns----");
    
    //self.phoneText.enabled = YES;
    
    
    if (self.phoneText.text.length  != 11 ) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确手机号码"];
        
        self.snsCodeBtn.userInteractionEnabled = NO;
    }
    
    
    
    id par = @{
               
               @"phone":self.phoneText.text
               
               };
    
    [self.snsManager POST:@"http://www.zhanyiwangluo.com/washcar/index.php/Home/Note/index" parameters:par progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
         NSString *success = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        
        NSString *snsCode = [NSString stringWithFormat:@"%@", responseObject[@"code"]];
        
        self.chsnsCode = snsCode;
        
        if ([success isEqualToString:@"200"]) {
            
           
            self.snsArray = [CWYSnsCode mj_objectWithKeyValues:responseObject];
            CHLog(@"%@", self.snsArray);
            [SVProgressHUD showSuccessWithStatus:@"验证码发送成功"];
            
        } else {
            
            [SVProgressHUD showErrorWithStatus:@"请检查手机号是否有误"];
            
            
        }

        
        
        
       
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
}


- (void)setupNav
{
    self.title = @"获取验证码";
    self.view.backgroundColor = CHRGBColor(245, 244, 244);
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationButtonReturn" highImage:@"navigationButtonReturnClick" target:self action:@selector(back)];
    
    
    //self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"fx" highImage:@"fx" target:self action:@selector(back)];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor whiteColor]}] ;
    
    
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)dealloc
{
    [self.snsManager.operationQueue cancelAllOperations];
    
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
