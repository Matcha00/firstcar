//
//  CWYSetView.h
//  车无忧
//
//  Created by 陈欢 on 2017/7/19.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CWYBusinessMinute;
@interface CWYSetView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *vipImage;
//@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *pay_count;
@property (weak, nonatomic) IBOutlet UIButton *phongBtn;
@property (weak, nonatomic) IBOutlet UIButton *favBtn;
@property (weak, nonatomic) IBOutlet UIImageView *isVipImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titlename;

//@property (nonatomic, strong) CWYBusinessMinute *businessMinute;


+ (instancetype) setView;

@end
