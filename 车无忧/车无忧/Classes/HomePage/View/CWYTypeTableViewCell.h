//
//  CWYTypeTableViewCell.h
//  车无忧
//
//  Created by 陈欢 on 2017/7/19.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CWYServe;
@interface CWYTypeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *buyButton;

@property (weak, nonatomic) IBOutlet UILabel *moneyLable;

@property (nonatomic, strong) CWYServe *server;

@end
