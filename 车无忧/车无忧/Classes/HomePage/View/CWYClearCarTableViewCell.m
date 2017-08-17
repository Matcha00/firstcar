//
//  CWYClearCarTableViewCell.m
//  车无忧
//
//  Created by 陈欢 on 2017/7/13.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYClearCarTableViewCell.h"
#import "CWYCarMessage.h"
#import <UIImageView+WebCache.h>


@interface CWYClearCarTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *showImage;
@property (weak, nonatomic) IBOutlet UILabel *bussinesName;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UILabel *amount;
@property (weak, nonatomic) IBOutlet UILabel *pay_count;
@property (weak, nonatomic) IBOutlet UIImageView *isVipImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameLay;


@end

@implementation CWYClearCarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCarMessage:(CWYCarMessage *)carMessage
{
    _carMessage = carMessage;
    
    self.isVipImage.hidden = carMessage.approve;
       
    if ( self.isVipImage.hidden == YES) {
        self.nameLay.constant = 10;
    } else
    {
        self.nameLay.constant = 55;
    }
    
    [self.showImage sd_setImageWithURL:[NSURL URLWithString:carMessage.picture]placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    //CHLog(@"%@", carMessage.picture);
    self.bussinesName.text = carMessage.title;
    
    self.address.text = carMessage.address;
    
    //self.score.text = carMessage.score;
    
    self.amount.text = carMessage.pay_count;
    
    NSString *rmb = @"$";
    
    
    
    
    self.pay_count.text = carMessage.amount;
    
    //NSString *pay = [NSString stringWithFormat:@""];
    
    
}


@end
