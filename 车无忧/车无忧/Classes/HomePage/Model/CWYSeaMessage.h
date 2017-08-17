//
//  CWYSeaMessage.h
//  车无忧
//
//  Created by 陈欢 on 2017/8/15.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CWYSeaMessage : NSObject

@property (nonatomic, strong) NSString *ID;

@property (nonatomic, strong) NSString *address;

@property (nonatomic, strong) NSString *picture;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *pay_count;

@property (nonatomic, assign, getter=approve) BOOL approve;


@end
