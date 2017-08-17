//
//  CWYUser.h
//  车无忧
//
//  Created by 陈欢 on 2017/7/26.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CWYUser : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *password;



@property (nonatomic, strong) NSString *code;

@property (nonatomic, strong) NSString *message;



@end
