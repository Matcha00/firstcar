//
//  CWYCarMessage.h
//  车无忧
//
//  Created by 陈欢 on 2017/7/24.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CWYCarMessage : NSObject



//"id": "1",
//"picture": "170724/59757a4c43088.png",
//"address": "西大直街123号",
//"score": "5",
//"pay_count": "20",
//"amount": "10"



@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *imageUrl;

@property (nonatomic, copy) NSString *picture;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *score;

@property (nonatomic, copy) NSString *pay_count;

@property (nonatomic, copy) NSString *amount;

@property (nonatomic, copy) NSString *linkurl;

@property (nonatomic, assign) CWYType type;

@property (nonatomic, assign, readonly) CGFloat cellHeight;

@property (nonatomic, assign, getter=approve) BOOL approve;

@end
