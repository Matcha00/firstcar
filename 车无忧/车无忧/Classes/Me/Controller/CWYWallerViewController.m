//
//  CWYWallerViewController.m
//  车无忧
//
//  Created by 陈欢 on 2017/7/17.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYWallerViewController.h"
#import "CWYRechargeViewController.h"
#import "CWYUserMessage.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <YYModel.h>
@interface CWYWallerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *yueLable;

@property (nonatomic, strong) AFHTTPSessionManager *aboutManager;

@property (nonatomic, strong) CWYUserMessage *user;

@end

@implementation CWYWallerViewController



- (AFHTTPSessionManager *)aboutManager
{
    if (!_aboutManager) {
        _aboutManager = [AFHTTPSessionManager manager];
    }
    
    return _aboutManager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //NSString *yue = [NSString stringWithFormat:@"%@",@"",self.user.amount];
    
    [self setupMoney];
    
    [self setupNav];
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


- (void)setupMoney
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    //NSString *userLogin =  [user stringForKey:@"uid"];
    
//    if (userLogin == nil) {
//        
//        UIStoryboard *loginStory = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
//        
//        CWYLoginViewController *loginVc = [loginStory instantiateViewControllerWithIdentifier:@"CWYLoginViewController"];
//        
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVc];
//        //[((UINavigationController *)tabBarController.selectedViewController) presentViewController:nav animated:YES completion:nil];
//        //[self presentedViewController:nav animated:YES compl];
//        
//        [self.navigationController presentViewController:nav animated:YES completion:nil];
//    } else
    
        
        
        
        
        params[@"uid"] = [user stringForKey:@"uid"];
        
//        
//        [self.aboutManager POST:@"http://www.zhanyiwangluo.com/washcar/index.php/Home/Personage/index" parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
//            
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//           
//            
//            self.user = [CWYUserMessage yy_modelWithDictionary:responseObject[@"user"]];
//            
//            NSString *showUser = @"¥";
//            
//            NSString *showUesrPhone = self.user.amount;
//            
//            NSString  *yue = [showUser stringByAppendingString:showUesrPhone];
//            
//            self.yueLable.text = yue;
//            
//            
//            CHLog(@"%@",responseObject);
//            
//            //        NSString *showUser = @"欢迎您，用户:";
//            //
//            //        NSString *showUesrPhone = self.user.phone;
//            //
//            //        NSString  *doubleString = [showUser stringByAppendingString:showUesrPhone];
//            //        self.showMessageLable.text = doubleString;
//            
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            
//            NSLog(@"%@", error);
//            
//        }];
    [self.aboutManager POST:@"http://www.zhanyiwangluo.com/washcar/index.php/Home/Personage/index" parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        CHLog(@"%@", responseObject);
        
        
        self.user = [CWYUserMessage yy_modelWithDictionary:responseObject[@"user"]];
      
                  NSString *showUser = @"¥";
        
        
               CGFloat ch = [self.user.amount floatValue];
        
             NSString *showUesrPhone = [NSString stringWithFormat:@"%.2f",ch * 0.01];
        
        
        
                    NSString  *yue = [showUser stringByAppendingString:showUesrPhone];
        
                   self.yueLable.text = yue;
        
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    

}





- (void)setupNav
{
    self.title = @"余额";
    self.view.backgroundColor = CHRGBColor(230, 230, 230);
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationButtonReturn" highImage:@"navigationButtonReturnClick" target:self action:@selector(back)];
    
    
}

- (IBAction)recharge {
    
    UIStoryboard *recharge = [UIStoryboard storyboardWithName:@"Recharge" bundle:nil];
    
    CWYRechargeViewController *rechargeVc = [recharge instantiateViewControllerWithIdentifier:@"CWYRechargeViewController"];
    
    [self.navigationController pushViewController:rechargeVc animated:YES];
    
    
    
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
