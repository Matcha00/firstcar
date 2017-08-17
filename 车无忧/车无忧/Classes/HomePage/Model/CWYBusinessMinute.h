//
//  CWYBusinessMinuTe.h
//  车无忧
//
//  Created by 陈欢 on 2017/7/26.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CWYUser;
@interface CWYBusinessMinute : NSObject


@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *picture;

@property (nonatomic, copy) NSString *adds;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *score;

@property (nonatomic, copy) NSString *longitude;

@property (nonatomic, copy) NSString *latitude;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, assign) NSInteger sort;

@property (nonatomic, copy) NSString *post_time;

@property (nonatomic, copy) NSString *pay_count;

//@property (nonatomic, strong) CWYUser *user;


@property (nonatomic, copy) NSString *manager;

@property (nonatomic, copy) NSString *manager_phone;
@property (nonatomic, copy) NSString *password ;
@property (nonatomic, copy) NSString *username;

@property (nonatomic, strong) NSString *collect;

@property (nonatomic, assign, getter=approve) BOOL approve;


@end
