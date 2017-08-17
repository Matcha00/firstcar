//
//  CWYBaiMapViewController.m
//  车无忧
//
//  Created by 陈欢 on 2017/7/31.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYBaiMapViewController.h"
#import "CWYBusinessMinute.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
@interface CWYBaiMapViewController () <BMKLocationServiceDelegate,BMKMapViewDelegate>


@property (nonatomic, strong) BMKMapView *mapView;

@property (nonatomic, strong) BMKLocationService *service;

@end

@implementation CWYBaiMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    
    // Do any additional setup after loading the view from its nib.
    
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, CHScreenW, CHScreenH)];
    
    CHLog(@"%@", NSStringFromCGRect (self.mapView.frame));
    
    self.mapView.delegate =self;
    
    //添加到view上
    [self.view addSubview:self.mapView];
    
    //初始化定位
    self.service = [[BMKLocationService alloc] init];
    
    //设置代理
    self.service.delegate = self;
    
    //开启定位
    [self.service startUserLocationService];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //展示定位
    self.mapView.showsUserLocation = YES;
    
    //更新位置数据
    [self.mapView updateLocationData:userLocation];
    
    //获取用户的坐标
    self.mapView.centerCoordinate = userLocation.location.coordinate;
    //NSLog(@"%@", userLocation.location.coordinate);
    self.mapView.zoomLevel =13;
    self.mapView.zoomEnabled = YES;
    
    
    
}


- (void) viewDidAppear:(BOOL)animated {
    // 添加一个PointAnnotation
    
    
     CHLog(@"%@", self.businessBDMap.latitude);
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    
    NSString *lat = self.businessBDMap.latitude;
    
    NSString *longItude = self.businessBDMap.longitude;
    CHLog(@"%@", lat);
    
    coor.latitude = [lat doubleValue];     //39.915;
    coor.longitude = [longItude doubleValue]; //11 6.404;
    
    CHLog(@"%f",coor.latitude);

    annotation.coordinate = coor;
    annotation.title = self.businessBDMap.title;
    annotation.subtitle = self.businessBDMap.phone;
    [_mapView addAnnotation:annotation];
}



- (void)setupNav
{
    self.title = @"百度地图";
    self.view.backgroundColor = CHRGBColor(245, 244, 244);
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationButtonReturn" highImage:@"navigationButtonReturnClick" target:self action:@selector(back)];
    
    
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor whiteColor]}] ;
    
    //self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"fx" highImage:@"fx" target:self action:@selector(wxShow)];
    
    
    
    
    
    
    
}


- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
