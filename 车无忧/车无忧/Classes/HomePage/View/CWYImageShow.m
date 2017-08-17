//
//  CWYImageShow.m
//  车无忧
//
//  Created by 陈欢 on 2017/7/26.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYImageShow.h"
#import "CWYBusinessMinute.h"
#import <UIImageView+WebCache.h>
#import <UIImageView+AFNetworking.h>
@interface CWYImageShow()


@property (weak, nonatomic) IBOutlet UIImageView *pictureImage;
@end
@implementation CWYImageShow

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+ (instancetype)setCwyView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)setBuyMessage:(CWYBusinessMinute *)buyMessage
{
    _buyMessage = buyMessage;
    
    
    
}

@end
