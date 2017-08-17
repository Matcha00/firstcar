//
//  CWYHomeHeadViewController.m
//  车无忧
//
//  Created by 陈欢 on 2017/7/12.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYHomeHeadViewController.h"
#import "CWYSearchTableViewController.h"
#import "CWYCarTableViewController.h"
#import "CHVerticalButton.h"
#import "PersonViewController.h"
#import <PYSearch.h>
#import <SDCycleScrollView.h>
#import <UIImageView+WebCache.h>
#import "SJPullDownMenu.h"
#import "SJButton.h"
#import "CWYCarMessage.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "CWYimageUrl.h"
#import <Masonry.h>
#import <CoreLocation/CoreLocation.h>
#import "CWYLocation.h"
#import "CWYSearTableViewController.h"
@interface CWYHomeHeadViewController () <UIScrollViewAccessibilityDelegate, PYSearchViewControllerDelegate,SDCycleScrollViewDelegate,SJPullDownMenuDataSource,CLLocationManagerDelegate>


{
    CLLocationManager *locationManager;
    
    NSString *currentCity;
    
    CGFloat newLatiude;
    
    CGFloat newLongitude;
    
    NSString *showCity;
}

///头部定位与搜索

@property (nonatomic, weak) UIView *headsView;

/// 轮播页

@property (nonatomic, weak) UIScrollView *scrollShowView;

/// 顶部按钮

@property (nonatomic, weak) UIView *headButtonView;

/// 筛选按钮

@property (nonatomic, weak) UIView *chooseButtonView;

/// 定位按钮

@property (nonatomic, weak) UIButton *locationButton;

/// 搜索按钮

@property (nonatomic, weak) UIButton *searchButton;


/// 选中按钮

@property (nonatomic, weak) UIButton *selectedButton;

/// 内容页面

@property (nonatomic, weak) UIScrollView *contentView;


/// 图片地址

@property (nonatomic, strong) NSMutableArray *imagesURLStrings;

@property (nonatomic, weak) SJPullDownMenu *menuView;  // 下拉菜单

@property (nonatomic, strong) NSArray *defaultTitleAry;  // 默认标题


@property (nonatomic, weak) SDCycleScrollView *showRunImage;


@property (nonatomic, strong) NSDictionary *params;

@property (nonatomic, strong)  CWYLocation *loc;

@property (nonatomic, strong) NSString *cityNameLoc;

@end

@implementation CWYHomeHeadViewController




- (NSString *)cityNameLoc
{
    if (!_cityNameLoc) {
        _cityNameLoc = [NSString string];
    }
    
    return _cityNameLoc;
}

- (NSMutableArray *)imagesURLStrings
{
    if (_imagesURLStrings) {
        
        
        
        
        _imagesURLStrings = [NSMutableArray array];
    }
    
    return  _imagesURLStrings;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
   //[self setupAfn];
   // [self setuoLocation];
   // CHLog(@"%@",currentCity);
    [self setupChildVces];
    [self setupHeadView];
    
    [self setupscrollShowView];
    [self setupheadButtonView];
    //[self setupchooseView];
    [self setupContentView];
    
    [self setStatusBarBackgroundColor:CHRGBColor(250, 48, 48)];
    
    //self.viewController.hidesBottomBarWhenPushed = YES;
   
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupAfn
{
    [[AFHTTPSessionManager manager] GET:@"http://www.zhanyiwangluo.com/washcar/index.php/Home/HomePage/index/page/1/type/0" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        //        self.carMessages = [CWYCarMessage mj_objectArrayWithKeyValuesArray:responseObject[@"business"]];
        //
        //        self.imagesURLStrings = [CWYimageUrl mj_objectArrayWithKeyValuesArray:responseObject[@"banner"]];
        //        NSLog(@"%@",responseObject[@"banner"]);
        
        
        NSMutableArray *arrayHave = [responseObject[@"banner"] valueForKey:@"linkurl"];
        //        NSString *banner;
        //
        //        for (NSDictionary *tset in responseObject) {
        //            banner = tset[@"banner"];
        //
        //            [arrayHave addObject:banner];
        //        }
        
        self.imagesURLStrings = arrayHave;
        
        
        
        NSLog(@"%@", _imagesURLStrings);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //
        //        if (self.params != params) return ;
        
        
        
        //[SVProgressHUD showErrorWithStatus:@"网络链接失败！！！！"];
        
        NSLog(@"%@",error);
        
    }];

}

#pragma mark 设置定位按钮与搜索控制器
- (void)setupHeadView
{
    UIView *headView = [[UIView alloc]init];
    WS(ws);
    headView.x = 0;
    headView.y = 20;
    headView.width = CHScreenW;
    headView.height = 40;
    headView.backgroundColor = CHRGBColor(250, 48, 48);
    self.headsView = headView;
    
    [self.view addSubview:headView];
    
//    [self.headsView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.size.mas_equalTo(CGSizeMake(CHScreenW, 40));
//        make.size.height.mas_equalTo(cgs)
//        make.top.equalTo(ws.view.mas_top).offset(42);
//        make.left.equalTo(ws.view.mas_right).offset(0);
//        make.right.equalTo(ws.view.mas_right).offset(0);
//        
//        
//        
//    }];
    
    UIButton *locationButton = [[UIButton alloc]init];
//    locationButton.y = 5;
//    locationButton.x = 5;
//    locationButton.width = 80;
//    locationButton.height = headView.height - 10;
    [locationButton setTitle:@"正在定位" forState:UIControlStateNormal];
    [locationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [locationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    locationButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [locationButton setImage:[UIImage imageNamed:@"location_button"] forState:UIControlStateNormal];
    [locationButton setImage:[UIImage imageNamed:@"location_button"] forState:UIControlStateHighlighted];
    [locationButton addTarget:self action:@selector(setupBtntitle) forControlEvents:UIControlEventTouchUpInside];
    locationButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
    locationButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.locationButton = locationButton;
    
    [headView addSubview:locationButton];
    
    
    [self.locationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(120, ws.headsView.height - 10));
        
        make.top.equalTo(ws.headsView.mas_top).offset(5);
        
        make.left.equalTo(ws.headsView.mas_left).offset(5);
        
    }];
    
    UIButton *searchButton = [[UIButton alloc]init];
    searchButton.backgroundColor = [UIColor yellowColor];
//    searchButton.x = 200;
//    searchButton.y = 12;
//    searchButton.width = 140;
//    searchButton.height = 20;
    //[searchButton setTitle:@"hhhhhhhhhhhhhhhh" forState:UIControlStateNormal];
    [searchButton setBackgroundImage:[UIImage imageNamed:@"search_button"] forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(showSearch:) forControlEvents:UIControlEventTouchUpInside];
    
    self.searchButton = searchButton;
    [headView addSubview:searchButton];
    
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(140, 20));
        
        make.top.equalTo(ws.headsView.mas_top).offset(12);
        
        make.left.equalTo(ws.locationButton.mas_right).offset(50);
    }];
    
   // self.navigationItem.titleView = headView;
    
    
    
}

#pragma mark 搜索控制器

- (void)showSearch:(UIButton *) button
{
    //NSArray *hotSeaches =  @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    
    //NSArray *hotSeaches = @[nil];
    
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:nil searchBarPlaceholder:NSLocalizedString(@"搜索服务", @"搜索服务") didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        CHLog(@"%@", searchText);
        
        CWYSearTableViewController *vc = [[CWYSearTableViewController alloc]init];
        
        vc.keyWord = searchText;
        
        
        
        [searchViewController.navigationController pushViewController:vc animated:YES];
    }];
    
    searchViewController.delegate = self;
    
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:searchViewController];
//    
//    [self presentViewController:nav animated:YES completion:nil];

    
    
    
//    CWYSearchTableViewController *search = [[CWYSearchTableViewController alloc]init];
    
    
    //[self.navigationController pushViewController:searchViewController animated:YES];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    //nav.navigationController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]init];
    nav.navigationController.navigationItem.leftBarButtonItem.tintColor = [UIColor redColor];
    
    [self presentViewController:nav animated:YES completion:nil];
}
#pragma mark 设置轮播页
- (void)setupscrollShowView
{
    
    
    
    
    
    
//    [[AFHTTPSessionManager manager] GET:@"http://www.zhanyiwangluo.com/washcar/index.php/Home/HomePage/index/page/1/type/0" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        
//        //        self.carMessages = [CWYCarMessage mj_objectArrayWithKeyValuesArray:responseObject[@"business"]];
//        //
//        //        self.imagesURLStrings = [CWYimageUrl mj_objectArrayWithKeyValuesArray:responseObject[@"banner"]];
//        //        NSLog(@"%@",responseObject[@"banner"]);
//        
//        
//        NSMutableArray *arrayHave = [responseObject[@"banner"] valueForKey:@"linkurl"];
//        //        NSString *banner;
//        //
//        //        for (NSDictionary *tset in responseObject) {
//        //            banner = tset[@"banner"];
//        //
//        //            [arrayHave addObject:banner];
//        //        }
//        
//        self.imagesURLStrings = arrayHave;
//        
//        
//        
//        NSLog(@"%@", _imagesURLStrings);
//        
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        //
//        //        if (self.params != params) return ;
//        
//        
//        
//        //[SVProgressHUD showErrorWithStatus:@"网络链接失败！！！！"];
//        
//        NSLog(@"%@",error);
//        
//    }];


    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    
//    params[@"page"] = @(1);
//   // params[@"type"] = @(self.type);
//    
//    self.params = params;
    
    
//    NSArray *testt = @[@"http://www.zhanyiwangluo.com/washcar/index.php/Home/Archives/index/id/1",
//                                  @"http://www.zhanyiwangluo.com/washcar/index.php/Home/Archives/index/id/2",
//                                  @"http://www.zhanyiwangluo.com/washcar/index.php/Home/Archives/index/id/7",
//                                  @"http://www.zhanyiwangluo.com/washcar/index.php/Home/Archives/index/id/8",
//                                  @"http://www.zhanyiwangluo.com/washcar/index.php/Home/Archives/index/id/9"];
////    self.imagesURLStrings  = imagesURLStrings;
//    
    NSArray *test = @[
                                  @"http://www.zhanyiwangluo.com/washcar/Public/Uploadfile/Picture/170724/59755fa920778.png",
                                  @"http://www.zhanyiwangluo.com/washcar/Public/Uploadfile/Picture/170724/59755d79606d9.png",
                                  @"http://www.zhanyiwangluo.com/washcar/Public/Uploadfile/Picture/170724/59755c0d5ad0c.png",
                                  @"http://www.zhanyiwangluo.com/washcar/Public/Uploadfile/Picture/170724/59755b8da5efc.png"
                                  ];

    
    
    SDCycleScrollView *showImageView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, self.headsView.height + self.headsView.y, CHScreenW, 0.5 * CHScreenW) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    //showImageView.backgroundColor = [UIColor redColor];
    showImageView.imageURLStringsGroup =  test;
    
    self.showRunImage = showImageView;
    
    [self.view addSubview:showImageView];
    
    
   }

#pragma mark    =========== 设置头部按钮   =========
- (void)setupheadButtonView
{
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = CHRGBColor(255, 255, 255);
    titleView.width = CHScreenW;
    titleView.height = 85;
    titleView.y = self.showRunImage.height  + self.showRunImage.y;
    [self.view addSubview:titleView];
    self.headButtonView = titleView;
    
     NSArray *title = @[@"洗车",@"美容", @"保养", @"维修"];
     NSArray *images = @[@"clearcar_normal", @"hairdressing_normal", @"maintain_normal", @"service_normal"];
    
    
    NSArray *selectImage =  @[@"clearcar_select", @"hairdressing_select", @"maintain_select", @"service_select"];
    
    
    
    int maxCols = 4;
    CGFloat buttonW = 50;
    CGFloat buttonH = buttonW + 20;
    
    CGFloat buttonStartY = 10;//(CHScreenH - 2 * buttonH) * 0.5;
    CGFloat buttonStartX = 40;
    CGFloat xMargin = (CHScreenW - 2 * buttonStartX - maxCols * buttonW) / (maxCols - 1);
    
//    CGFloat buttonW = 72;
//    CGFloat buttonH = buttonW + 30;
    
    for (NSInteger i = 0; i<title.count; i++) {
        CHVerticalButton *button = [[CHVerticalButton alloc] init];
        button.tag = i;
        button.width = buttonW;
        button.height = buttonH;
        button.x = buttonStartX + i * buttonW  +  i * xMargin;
        button.y = 10;
        
        //button.backgroundColor = [UIColor blackColor];
        
        [button setTitle:title[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        //[button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        //[button setImage:[UIImage imageNamed:selectImage[i]] forState:UIControlStateHighlighted];
        [button setImage:[UIImage imageNamed:selectImage[i]] forState:UIControlStateSelected];

        
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        //[button addTarget:self action:@selector(titleClick:(UIButton *)) forControlEvents:UIControlEventTouchUpOutside];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:button];
        
        if (i == 0) {
//            button.enabled = NO;
//            self.selectedButton = button;
            /**
             *  让按钮内部lable根据文字内容计算尺寸
             */
            
            button.selected = YES;
            
            self.selectedButton = button;
            
            [button.titleLabel sizeToFit];
                    }
        
    }
    
    
   }
#pragma mark  titleButton点击
- (void)titleClick:(UIButton *)button
{
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag *self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];

    
    
    
    
}


#pragma mark 设置子控制器
- (void)setupChildVces
{
    CWYCarTableViewController *clearCar = [[CWYCarTableViewController alloc]init];
    clearCar.type = CWYClearCar;
    clearCar.loc = self.loc;
    clearCar.latiudeLocation = &(newLatiude);
    clearCar.cityLocation = @"的点点滴滴";
    clearCar.loc = _loc;
    [self addChildViewController:clearCar];
    
    CWYCarTableViewController *cosmetology = [[CWYCarTableViewController alloc]init];
    cosmetology.type = CWYService;
    [self addChildViewController:cosmetology];
    
    CWYCarTableViewController *preserve = [[CWYCarTableViewController alloc]init];
    preserve.type = CWYMaintain;
    [self addChildViewController:preserve];
    
   // CWYCarTableViewController *service = [[CWYCarTableViewController alloc]init];
   // [self addChildViewController:service];
    
//    PersonViewController *person = [[PersonViewController alloc]init];
//    [self addChildViewController:person];
    
    CWYCarTableViewController *hairdressing = [[CWYCarTableViewController alloc]init];
    preserve.type = CWYHairdressing;
    [self addChildViewController:hairdressing];
    
    
}


#pragma mark 筛选按钮

//- (void)setupchooseView
//{
//   
//    
//    
//    _defaultTitleAry = @[@"hhhh",@"ppppp"];
//    CGFloat menViewY = self.headButtonView.y + self.headButtonView.height;
//    SJPullDownMenu *menuView = [[SJPullDownMenu alloc]init];
//    menuView.frame = CGRectMake(0, self.headButtonView.height + self.headButtonView.y, CHScreenW, 44);
//    menuView.dataSource =self;
//    menuView.defaultTitleArray = _defaultTitleAry;
//    self.menuView = menuView;
//    
//    [self.view addSubview:menuView];
//    
//    
//    
//    
//    
//}
//
#pragma mark  设置子控制器内容
- (void)setupContentView
{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc]init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    //contentView.backgroundColor = [UIColor blueColor];
    contentView.pagingEnabled = YES;
    //contentView.contentInset = UIEdgeInsetsMake(0, 0, 40, 100);
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width *self.childViewControllers.count, 00);
    self.contentView = contentView;
    
    [self scrollViewDidEndScrollingAnimation:contentView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    UITableViewController *vc = self.childViewControllers[index];
    
    vc.view.x = scrollView.contentOffset.x ;
    vc.view.y = 0;
    vc.view.height = scrollView.height;
    
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    NSInteger index = scrollView.contentOffset.x / scrollView.width;

    [self titleClick:self.headButtonView.subviews[index]];
}




- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    //[self setupAfn];
    self.hidesBottomBarWhenPushed = NO;
    [self setuoLocation];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}


- (NSInteger)numberOfColsInMenu:(SJPullDownMenu *)pullDownMenu
{
    return self.defaultTitleAry.count;
}

- (UIButton *)pullDownMenu:(SJPullDownMenu *)pullDownMenu buttonForColAtIndex:(NSInteger)index
{
    SJButton *button = [SJButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
    [button setImage:[UIImage imageNamed:@"icon_more_highlighted"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"icon_more"] forState:UIControlStateSelected];
    return button;
}

- (UIViewController *)pullDownMenu:(SJPullDownMenu *)pullDownMenu viewControllerForColAtIndex:(NSInteger)index
{
    return self.childViewControllers[index];
}

- (CGFloat)pullDownMenu:(SJPullDownMenu *)pullDownMenu heightForColAtIndex:(NSInteger)index
{
    if (index == 0) {
        
        return 130;
    } else if (index == 1) {
        
        return 130;
    } else if (index == 2) {
        
        return 260;
    } else {
        
        return 200;
    }
}

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

- (void)setuoLocation
{
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc]init];
        
        locationManager.delegate = self;
        
        [locationManager requestAlwaysAuthorization];
        
        currentCity = [[NSString alloc] init];
        
        [locationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"允许定位提示 " message:@"打开" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * ok = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开定位设置
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:settingsURL];
    }];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:cancel];
    [alertVC addAction:ok];
    [self presentViewController:alertVC animated:YES completion:nil];
    
    
    
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [locationManager stopUpdatingLocation];
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    
    
     ///NSString   *cewLatiude =  ns currentLocation.coordinate.latitude;
//    
//     newLongitude = currentLocation.coordinate.longitude;
    
    
    //CHLog(@"纬度=%f，经度=%f",newLatiude,newLongitude);
    
    //__block NSString *showCity;
    
    //反编码
    
    NSString *chLatiude = [NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
    
    NSString *chLongitude = [NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];
      //__block NSString *test;
     NSUserDefaults *userDe = [NSUserDefaults standardUserDefaults];
    
    [userDe setObject:chLatiude forKey:@"latitude"];
    [userDe setObject:chLongitude forKey:@"longitude"];
//    CWYLocation  *cwyLocation = [[CWYLocation alloc]init];
//    
//    self.loc = cwyLocation;
   // cwyLocation.latiudeLocation = currentLocation.coordinate.latitude;
    
    
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            currentCity = placeMark.locality;
            
           
            
            [userDe setObject:placeMark.locality forKey:@"city"];
            [userDe synchronize];

            
            //cwyLocation.cityLocation = placeMark.locality;
            
            
           if (!currentCity) {
                currentCity = @"无法定位当前城市";
         
            }
              NSLog(@"%@",currentCity); //这就是当前的城市
            //NSLog(@"%@",placeMark.name);//具体地址:  xx市xx区xx街道
            [self.locationButton setTitle:currentCity forState:UIControlStateNormal];
            
            
        }
        else if (error == nil && placemarks.count == 0) {
            //NSLog(@"No location and error return");
            
            //self.locationButton.titleLabel.text = @"无法定位当位置";
        }
        else if (error) {
            //NSLog(@"location error: %@ ",error);
            
            //self.locationButton.titleLabel.text = @"无法定位当位置";
        }
        
    }];
   
}


- (void)setupBtntitle
{
    [locationManager startUpdatingLocation];
}



@end
