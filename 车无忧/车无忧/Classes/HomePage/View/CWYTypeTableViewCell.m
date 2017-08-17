//
//  CWYTypeTableViewCell.m
//  车无忧
//
//  Created by 陈欢 on 2017/7/19.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYTypeTableViewCell.h"
#import "CWYServe.h"
@interface CWYTypeTableViewCell()


@property (weak, nonatomic) IBOutlet UILabel *severType;

@property (weak, nonatomic) IBOutlet UILabel *severShow;


@property (weak, nonatomic) IBOutlet UILabel *rmbLable;

@end
@implementation CWYTypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setServer:(CWYServe *)server
{
    _server = server;
    
    self.severType.text = server.title;
    
    self.severShow.text = server.content;
    
    
    if ( [server.amount isEqualToString:@"0"]) {
        
        self.moneyLable.hidden = YES;
        self.rmbLable.hidden = YES;
        
        [self.buyButton setTitle:@"自助购买" forState:UIControlStateNormal];
    } else
    {
       self.moneyLable.text = server.amount;
        self.moneyLable.hidden = NO;
        self.rmbLable.hidden = NO;
       [self.buyButton setTitle:@"立即付款" forState:UIControlStateNormal];
    }
    
   
    
    
}

@end
