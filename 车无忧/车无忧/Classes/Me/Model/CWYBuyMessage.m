//
//  CWYBuyMessage.m
//  车无忧
//
//  Created by 陈欢 on 2017/7/30.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYBuyMessage.h"

@implementation CWYBuyMessage

- (NSString *)post_time
{
//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    
//    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
//    
//    NSDate *create = [fmt dateFromString:_post_time];
//    
//    if (create.isThisYear) {
//        if (create.isToday) {
//            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
//            
//            if (cmps.hour >= 1) {
//                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
//            } else if (cmps.minute >= 1) {
//                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
//            } else {
//                return @"刚刚";
//            }
//        } else if (create.isYesterday) {
//            fmt.dateFormat = @"昨天 HH:mm";
//            return [fmt stringFromDate:create];
//        } else {
//            fmt.dateFormat = @"MM-dd HH:mm";
//            return [fmt stringFromDate:create];
//        }
//    } else {
//        return _post_time;
//    }

    
    NSString *str=  _post_time;//时间戳
    NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
     _post_time = [dateFormatter stringFromDate: detaildate];

    
    return _post_time;
    
    
    
}



@end
