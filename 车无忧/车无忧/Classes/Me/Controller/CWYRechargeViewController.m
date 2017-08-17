//
//  CWYRechargeViewController.m
//  车无忧
//
//  Created by 陈欢 on 2017/7/17.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYRechargeViewController.h"

@interface CWYRechargeViewController ()
@property (weak, nonatomic) IBOutlet UIView *wxView;
@property (weak, nonatomic) IBOutlet UIView *zfbView;
@property (weak, nonatomic) IBOutlet UIImageView *wxImage;
@property (weak, nonatomic) IBOutlet UIImageView *zfbImage;

@end

@implementation CWYRechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupPay];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setupPay
{
    UITapGestureRecognizer *tapWxGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeWxImage)];
    
    [self.wxView addGestureRecognizer:tapWxGesture];
    
    UITapGestureRecognizer *tapZfbGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeZfbImage)];
    
    [self.zfbView addGestureRecognizer:tapZfbGesture];
    
    self.wxImage.image = [UIImage imageNamed:@"bx"];
    self.zfbImage.image = [UIImage imageNamed:@"bx"];
}



- (void)changeWxImage
{
    self.wxImage.image = [UIImage imageNamed:@"xz"];
    self.zfbImage.image = [UIImage imageNamed:@"bx"];
     NSLog(@"tap");
}


- (void)changeZfbImage
{
    
    
    self.zfbImage.image = [UIImage imageNamed:@"xz"];
    self.wxImage.image = [UIImage imageNamed:@"bx"];

     NSLog(@"tapZ");
}


- (void)setupNav
{
    self.title = @"充值";
    self.view.backgroundColor = CHRGBColor(230, 230, 230);
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationButtonReturn" highImage:@"navigationButtonReturnClick" target:self action:@selector(back)];
    
    
}


- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
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
