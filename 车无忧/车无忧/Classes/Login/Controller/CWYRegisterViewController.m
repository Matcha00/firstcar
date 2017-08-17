//
//  CWYRegisterViewController.m
//  车无忧
//
//  Created by 陈欢 on 2017/7/24.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYRegisterViewController.h"

@interface CWYRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *firstPwd;
@property (weak, nonatomic) IBOutlet UITextField *secondPwd;
@property (weak, nonatomic) IBOutlet UITextField *yzm;
@property (weak, nonatomic) IBOutlet UITextField *tjm;

@end

@implementation CWYRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)regist:(id)sender {
}

@end
