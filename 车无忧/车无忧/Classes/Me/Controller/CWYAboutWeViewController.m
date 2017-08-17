//
//  CWYAboutWeViewController.m
//  车无忧
//
//  Created by 陈欢 on 2017/8/15.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYAboutWeViewController.h"

@interface CWYAboutWeViewController ()

@end

@implementation CWYAboutWeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    // Do any additional setup after loading the view from its nib.
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

- (void)setupNav
{
    self.title = @"关于我们";
    self.view.backgroundColor = CHRGBColor(245, 244, 244);
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationButtonReturn" highImage:@"navigationButtonReturnClick" target:self action:@selector(back)];
    
    
    //self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"fx" highImage:@"fx" target:self action:@selector(wxShow)];
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor whiteColor]}] ;
    
    
    
    
}


- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
