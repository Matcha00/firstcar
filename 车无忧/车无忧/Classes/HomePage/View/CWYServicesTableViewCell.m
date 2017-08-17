//
//  CWYServicesTableViewCell.m
//  车无忧
//
//  Created by 陈欢 on 2017/7/19.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYServicesTableViewCell.h"

@interface CWYServicesTableViewCell()





@property (weak, nonatomic) IBOutlet UILabel *serverLable;


@end

@implementation CWYServicesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void)setTypeLable:(CWYTypeTable *)typeLable
//{
//    _typeLable = typeLable;
//    
//    self.serverLable.text = typeLable.name;
//}


@end
