//
//  CWYfeedBackViewController.m
//  车无忧
//
//  Created by 陈欢 on 2017/7/16.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYfeedBackViewController.h"

@interface CWYfeedBackViewController ()

@end

@implementation CWYfeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // self.navigationController.title
    self.title = @"意见反馈";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationButtonReturn" highImage:@"navigationButtonReturnClick" target:self action:@selector(back)];
       
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
