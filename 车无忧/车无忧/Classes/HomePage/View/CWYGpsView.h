//
//  CWYGpsView.h
//  车无忧
//
//  Created by 陈欢 on 2017/7/19.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CWYBusinessMinute;
@interface CWYGpsView : UIView

@property (weak, nonatomic) IBOutlet UIButton *showButton;
@property (weak, nonatomic) IBOutlet UILabel *addressLable;

@property (nonatomic, strong) CWYBusinessMinute *businessMinute;
@property (weak, nonatomic) IBOutlet UILabel *daohangLable;
@property (weak, nonatomic) IBOutlet UIButton *daohangBtn;
@property (weak, nonatomic) IBOutlet UILabel *longLable;

+ (instancetype)gpsView;

@end
