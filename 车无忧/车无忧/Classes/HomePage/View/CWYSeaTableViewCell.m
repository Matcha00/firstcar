//
//  CWYSeaTableViewCell.m
//  车无忧
//
//  Created by 陈欢 on 2017/8/15.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYSeaTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "CWYSeaMessage.h"
@interface CWYSeaTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *seaShowImage;

@property (weak, nonatomic) IBOutlet UIImageView *vipSeaImage;

@property (weak, nonatomic) IBOutlet UILabel *seaTitle;
@property (weak, nonatomic) IBOutlet UILabel *seaAddress;
//@property (weak, nonatomic) IBOutlet UILabel *peopleSea;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *moneySea;

@end
@implementation CWYSeaTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSeaMessage:(CWYSeaMessage *)seaMessage
{
    _seaMessage = seaMessage;
    
    [self.seaShowImage sd_setImageWithURL:[NSURL URLWithString:seaMessage.picture]placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.seaTitle.text = self.seaMessage.title;
    
    self.seaAddress.text = seaMessage.address;
    
    //self.peopleSea.text = seaMessage.pay_count;
}

@end
