//
//  CWYfavTableViewCell.m
//  车无忧
//
//  Created by 陈欢 on 2017/8/1.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYfavTableViewCell.h"
#import "CWYFav.h"
#import <UIImageView+WebCache.h>
@interface CWYfavTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *favImage;
@property (weak, nonatomic) IBOutlet UIImageView *favVip;
@property (weak, nonatomic) IBOutlet UILabel *favTitle;
@property (weak, nonatomic) IBOutlet UILabel *favAddress;
@property (weak, nonatomic) IBOutlet UILabel *amount;

@end
@implementation CWYfavTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setFav:(CWYFav *)fav
{
    _fav = fav;
    
    [self.favImage sd_setImageWithURL:[NSURL URLWithString:fav.picture] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    
//    [self.showImage sd_setImageWithURL:[NSURL URLWithString:carMessage.picture]placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
//    //CHLog(@"%@", carMessage.picture);
//    self.bussinesName.text = carMessage.title;
//    
//    self.address.text = carMessage.address;
//    
//    //self.score.text = carMessage.score;
//    
//    self.amount.text = carMessage.amount;
    
    self.favTitle.text = fav.title;
    
    self.favAddress.text = fav.address;
    
    self.amount.text = fav.pay_count;
    
    //self.amount.text = fav.score;
}

@end
