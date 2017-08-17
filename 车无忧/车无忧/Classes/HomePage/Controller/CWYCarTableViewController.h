//
//  CWYCarTableViewController.h
//  车无忧
//
//  Created by 陈欢 on 2017/7/12.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CWYLocation;
@interface CWYCarTableViewController : UITableViewController

@property (nonatomic, assign) CWYType type;


@property (nonatomic, strong) CWYLocation *loc;

@property (nonatomic, strong) NSString *cityLocation;

@property (nonatomic, assign) CGFloat *latiudeLocation;

@property (nonatomic, assign) CGFloat *longitudeLocation;


@end
