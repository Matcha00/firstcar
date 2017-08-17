//
//  CWYTjPeople.m
//  车无忧
//
//  Created by 陈欢 on 2017/8/9.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYTjPeople.h"

@implementation CWYTjPeople


- (NSString *)create_time
{
    NSString *str=  _create_time;//时间戳
    NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    _create_time = [dateFormatter stringFromDate: detaildate];
    
    
    return _create_time;

}

@end
