//
//  CWYServicesTableViewCell.h
//  车无忧
//
//  Created by 陈欢 on 2017/7/19.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWYTypeTable.h"
@interface CWYServicesTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *showFirstLable;

@property (nonatomic, strong) CWYTypeTable *typeLable;
//
//@property (weak, nonatomic) IBOutlet UILabel *testLable;
//@property (nonatomic, strong) NSArray *showArray;

@end
