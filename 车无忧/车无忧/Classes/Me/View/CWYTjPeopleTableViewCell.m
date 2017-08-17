//
//  CWYTjPeopleTableViewCell.m
//  车无忧
//
//  Created by 陈欢 on 2017/8/9.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYTjPeopleTableViewCell.h"
#import "CWYTjPeople.h"
@interface CWYTjPeopleTableViewCell()


@property (weak, nonatomic) IBOutlet UILabel *peopleLable;
@property (weak, nonatomic) IBOutlet UILabel *peopleTime;


@end
@implementation CWYTjPeopleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPeople:(CWYTjPeople *)people
{
    _people = people;
    
    NSString *phoneCh = people.phone;
    NSString *hhhhh = @"我的推荐人号码:";
    NSString *ch  =[phoneCh stringByReplacingOccurrencesOfString:[phoneCh substringWithRange:NSMakeRange(3,4)]withString:@"****"];
    NSString  *doubleString = [hhhhh stringByAppendingString:ch];

    
    
    self.peopleLable.text = doubleString;
    
    self.peopleTime.text = people.create_time;
}

@end
