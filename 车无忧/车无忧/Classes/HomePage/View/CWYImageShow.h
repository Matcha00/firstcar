//
//  CWYImageShow.h
//  车无忧
//
//  Created by 陈欢 on 2017/7/26.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CWYBusinessMinute;
@interface CWYImageShow : UIView

@property (nonatomic, strong) CWYBusinessMinute *buyMessage;


+ (instancetype) setCwyView;

@end
