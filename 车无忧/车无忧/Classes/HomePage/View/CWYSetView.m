//
//  CWYSetView.m
//  车无忧
//
//  Created by 陈欢 on 2017/7/19.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYSetView.h"
#import "CWYBusinessMinute.h"
#import <UIImageView+WebCache.h>
#import <MJExtension.h>

@interface CWYSetView()


@end

@implementation CWYSetView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)phoneButton:(id)sender {
    
    
    NSLog(@"%@",@"123456789");
    
}

+ (instancetype)setView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    [super awakeFromNib];
}

//- (void)setBusinessMinute:(CWYBusinessMinute *)businessMinute
//{
//    
//    _businessMinute = businessMinute;
//    
//    NSLog(@"%@kkkkkkk",businessMinute);
//    
//      
//    self.titleLable.text = businessMinute.title;
//    self.scoreLable.text = businessMinute.score;
//    self.pay_countLable.text = businessMinute.pay_count;
//    
//}

@end
