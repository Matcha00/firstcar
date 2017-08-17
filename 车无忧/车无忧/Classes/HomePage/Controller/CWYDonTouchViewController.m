//
//  CWYDonTouchViewController.m
//  车无忧
//
//  Created by 陈欢 on 2017/7/19.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYDonTouchViewController.h"

@interface CWYDonTouchViewController ()

@property (nonatomic, weak) UILabel *dontTouchLable;

@end

@implementation CWYDonTouchViewController


- (UILabel *)dontTouchLable
{
    if (!_dontTouchLable) {
        UILabel *dontLable = [[UILabel alloc]init];
        
        dontLable.centerX = self.view.centerX;
        
         dontLable.centerY = self.view.centerY;
        
        dontLable.width = self.view.width;
        
        dontLable.height = 40;
        dontLable.text = @"fffffffff";
        _dontTouchLable = dontLable;
        
        
    }
    
    return _dontTouchLable;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:_dontTouchLable];
    
    
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

@end
