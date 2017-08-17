//
//  CWYLocation.h
//  车无忧
//
//  Created by 陈欢 on 2017/8/1.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface CWYLocation : NSObject

@property (nonatomic, strong) NSString *cityLocation;

@property (nonatomic, assign) CLLocationDegrees *latiudeLocation;

@property (nonatomic, assign) CLLocationDegrees *longitudeLocation;


@end
