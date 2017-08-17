//
//  CWYBuyMessageTableViewCell.m
//  车无忧
//
//  Created by 陈欢 on 2017/7/20.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYBuyMessageTableViewCell.h"
#import "CWYBuyMessage.h"
@interface CWYBuyMessageTableViewCell()


@property (weak, nonatomic) IBOutlet UILabel *buessisName;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UILabel *money;

@property (weak, nonatomic) IBOutlet UILabel *serverLable;

@end



@implementation CWYBuyMessageTableViewCell



- (void)setBuyMessage:(CWYBuyMessage *)buyMessage

{
    _buyMessage  = buyMessage;
    
    NSString *jianhao = @"-";
    
    NSString *jine = buyMessage.amount;
    
    NSString *showjine = [jianhao stringByAppendingString:jine];
    
    
    self.buessisName.text = buyMessage.b_title;
    
    self.time.text = buyMessage.post_time;
    
    self.money.text = showjine;
    
    self.serverLable.text = buyMessage.s_title;
    
    
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
