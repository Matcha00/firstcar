//
//  CWYShowMessageViewController.m
//  车无忧
//
//  Created by 陈欢 on 2017/7/18.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYShowMessageViewController.h"
#import <Masonry.h>
#import "CWYSetView.h"
#import "CWYGpsView.h"
#import "CWYChoosePayViewController.h"
#import <MBProgressHUD.h>
#import "CWYDonTouchViewController.h"
#import <AFNetworking.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import "CWYBusinessMinute.h"
#import "CWYCarMessage.h"
#import "CWYBusinessMinute.h"
#import <SVProgressHUD.h>
#import "CWYImageShow.h"
#import <YYModel.h>
#import "TYMapNavSheet.h"
#import "CWYBaiMapViewController.h"
#import "CWYTestChooseViewController.h"
#import "CWYServicesTableViewCell.h"
#import "CWYTypeTableViewCell.h"
#import "CWYTypeTable.h"
#import "CWYServe.h"
#import <UIImageView+AFNetworking.h>
//#import "WXApiManager.h"
#import "WXApiObject.h"
#import "WXApi.h"
#import "PaymentView.h"
#import "PasswordBuild.h"
#import "CWYZZFKViewController.h"

static NSString* const kShareButtonText = @"分享  ";
static NSString* const kShareDescText = @"分享一个链接";
static NSString* const kShareFailedText = @"分享失败";

//#import "JHBLoadingView.h"
@interface CWYShowMessageViewController () <UIScrollViewDelegate,UIActionSheetDelegate,UITableViewDataSource,UITabBarDelegate>


{
    TYMapNavSheet * TYNavSheet;
    
   // UITableView *firstTable;
    
   // UITableView *secondtableView;
    
    NSInteger  second_row;
    
}


@property (nonatomic, weak) UITableView *firstTableView;

@property (nonatomic, weak) UITableView *secondTableView;

@property (nonatomic, weak) UIImageView *headerImage;

@property (nonatomic, weak) CWYSetView *setView;

@property (nonatomic, strong) SendMessageToWXReq *rep;

@property (nonatomic, strong) WXMediaMessage *webMessage;

@property (nonatomic, strong) WXWebpageObject *webpage;
//
//@property (nonatomic, weak) UIImageView *vipImage;
//
//@property (nonatomic, weak) UILabel *scoreLable;
//
//@property (nonatomic, weak) UILabel *resultLable;
//
//@property (nonatomic, weak) UILabel *numberLable;
//
//@property (nonatomic, weak) UILabel *buyLable;
//
//@property (nonatomic, weak) UIButton *phoneBUtton;
//
//@property (nonatomic, weak) UIButton *favoritesBUtton;

@property (nonatomic, weak) CWYGpsView *gpsView;

@property (nonatomic, weak) UIImageView *gpsImage;

@property (nonatomic, weak) UILabel *addressLable;

@property (nonatomic, weak) UILabel *whereLable;

@property (nonatomic, weak) UILabel *longLable;

@property (nonatomic, weak) UIView *chooseView;

/** 底部的所有内容 */
@property (nonatomic, weak) UIScrollView *contentView;


/** 标签栏底部的红色指示器 */
@property (nonatomic, weak) UIView *indicatorView;

@property (nonatomic, weak) UIButton *selectedButton;


@property (nonatomic, weak) UIView *conView;


@property (nonatomic, strong) NSArray *showMessage;

@property (nonatomic, strong) AFHTTPSessionManager *manager;



@property (nonatomic, strong) CWYBusinessMinute *business;



@property (nonatomic, strong) NSArray *message;

@property (nonatomic, weak) UIView *chooseTableView;


//@property (nonatomic, strong) JHBLoadingView *loadView;

//@property (nonatomic, strong) NSArray *firstArray;

@property (nonatomic, strong) NSMutableArray *secondArray;

@property (nonatomic, strong) AFHTTPSessionManager *favManager;

@property (strong,nonatomic) NSIndexPath *selectedPath;

@property (strong, nonatomic) AFHTTPSessionManager *buyCarManager;

@property (strong, nonatomic) UIImage *wxImage;

@end

@implementation CWYShowMessageViewController

static  NSString * const CHFirstId = @"first";
static NSString * const CHSecondeId = @"second";


- (AFHTTPSessionManager *)buyCarManager

{
    if (!_buyCarManager) {
        _buyCarManager = [AFHTTPSessionManager manager];
    }
    
    return _buyCarManager;
}


- (AFHTTPSessionManager *)favManager
{
    if (!_favManager) {
        _favManager = [AFHTTPSessionManager manager];
    }
    
    return _favManager;
}

- (NSMutableArray *)secondArray
{
    if (!_secondArray) {
        _secondArray = [NSMutableArray array];
    }
    
    return _secondArray;
}



- (UITableView *)firstTableView

{
    if (!_firstTableView) {
        _firstTableView = [[UITableView alloc]init];
    }
    
    return _firstTableView;
}


- (UITableView *)secondTableView
{
    if (!_secondTableView) {
        _secondTableView = [[UITableView alloc]init];
        
    }
    
    return _secondTableView;
}

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    
    return _manager;
}


- (NSArray *)showMessage

{
    if (!_showMessage) {
        _showMessage = [NSArray array];
    }
    
    return _showMessage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
      TYNavSheet = [[TYMapNavSheet alloc]init];
    
    [self tableView:_firstTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [_firstTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    //self.firstArray = @[@"汽车服务",@"汽车美容",@"汽车保养",@"汽车维修"];
      [self setupNav];
////    
      //[self setupChildVc];

      [self setHeaderImage];
////    
      [self setupSetView];
////    
      [self setupGpsView];
////    
      [self setupButtonView];
////    
     // [self setUpTest];
//
      self.rep = [[SendMessageToWXReq alloc] init];
    self.webMessage = [[WXMediaMessage alloc]init];
    
    self.webpage = [WXWebpageObject object];
    
      [self setupChoose];
      [self setupDataMessage];
      [self setupTable];
    //[self postJsonToServer];
    
    //[self setupContentView];
    // Do any additional setup after loading the view.
    
    
    
//    
//    self.loadView = [[JHBLoadingView alloc] initWithLoadType:JHBLoadingTypeIndicator];
//
//    
//
//    self.loadView.delegate = self;
//    
//    self.loadView.text = @"sssssssss";
//
//    [self.view addSubview:self.loadView];
    
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 拼接图片名为"currentImage.png"的路径
    NSString *imageFilePath = [path stringByAppendingPathComponent:@"currentImage.png"];
    //获取网络请求中的url地址
    //NSString *url = [dataDic objectForKey:@"IndexUrl"];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL  URLWithString:self.carMessage.picture]];
    //转换为图片保存到以上的沙盒路径中
    UIImage * currentImage = [UIImage imageWithData:data];
    //其中参数0.5表示压缩比例，1表示不压缩，数值越小压缩比例越大
    [UIImageJPEGRepresentation(currentImage, 0.5) writeToFile:imageFilePath  atomically:YES];
    
    //NSString *imageFilePath = [path stringByAppendingPathComponent:@"currentImage.png"];
    
    UIImage *wxImage = [UIImage imageWithContentsOfFile:imageFilePath];

    
    self.wxImage = wxImage;
}

- (void)setupTable
{
    [self tableView:self.firstTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [self.firstTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    [self.firstTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CWYServicesTableViewCell class]) bundle:nil] forCellReuseIdentifier:CHFirstId];
    self.firstTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.secondTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.secondTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CWYTypeTableViewCell class]) bundle:nil] forCellReuseIdentifier:CHSecondeId];
    
   // [self tableView:self.firstTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    //[self.firstTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setChildTest
{
    
}


- (void)setHeaderImage

{
    //CWYImageShow *headerImage = [CWYImageShow setCwyView];
    
    UIImageView *headerImage = [[UIImageView alloc]init];
    
//    headerImage.x = 0;
//    headerImage.y = 62;
//    headerImage.width = CHScreenW;
//    headerImage.height = 0.5 * CHScreenW;
   
    self.headerImage = headerImage;

    [self.view addSubview:headerImage];
    
    WS(ws);
    
    
//    [self.headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
//          make.size.mas_equalTo(CGSizeMake(CHScreenW, 180));
////        make.top.and.left.mas_equalTo(0);
////        make.right.mas_equalTo(0);
//        
//       // make.top.mas_equalTo(42);
//        
//        
//        
//        
//        make.right.equalTo(ws.view.mas_right).offset(0);
//        
//        //make.bottom.equalTo(ws.view.mas_bottom).offset(0);
//        
//        make.top.equalTo(ws.view.mas_top).offset(62);
//        
//        make.left.equalTo(ws.view.mas_left).offset(0);
//        
//        //make.size.height.mas_equalTo(150);
//
//    }];
    
    [headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.size.height.mas_equalTo(0.5 * CHScreenW);
        
        make.top.equalTo(ws.view.mas_top).offset(62);
        
        make.left.equalTo(ws.view.mas_left).offset(0);
        
        make.right.equalTo(ws.view.mas_right).offset(0);
        
        
        
    }];
    
    
}

- (void)createSquares:(NSArray *)sqaures
{


}


- (void) setupSetView
{
//    UIView *setView = [[UIView alloc]init];
//    
//    self.setView = setView;
//    
//    
//    setView.backgroundColor = [UIColor redColor];
//    
//    CWYSetView *cwySetView = [CWYSetView setView];
//    
//    cwySetView.x = 0;
//    
//    cwySetView.y = 0;
//    
//    cwySetView.width = self.setView.width;
//    cwySetView.height = self.setView.height;
//    
//    [self.setView addSubview:cwySetView];
//    
//    [self.view addSubview:setView];
    
    CWYSetView *cwySetView = [CWYSetView setView];
    
    //cwySetView.businessMinute = self.business;
    
    //CHLog(@"%@ccccccccc",cwySetView.businessMinute);
    
   // cwySetView.businessMinute = self.showMessage;
    
    //cwySetView.businessMinute = self.showMessage;
    
   // cwySetView.backgroundColor = [UIColor redColor];
    
    //cwySetView.backgroundColor = [UIColor yellowColor];
    
    //cwySetView.businessMinute = self.business;
//    cwySetView.x = 0;
//    cwySetView.y = self.headerImage.height + self.headerImage.y;
//    cwySetView.height = 80;
//    cwySetView.width = CHScreenW;
    [cwySetView.phongBtn addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
    [cwySetView.favBtn addTarget:self action:@selector(favClick) forControlEvents:UIControlEventTouchUpInside];
    self.setView = cwySetView;
    [self.view addSubview:cwySetView];
    
    WS(ws);
    
//    [self.setView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.size.mas_equalTo(CGSizeMake(CHScreenW, 80));
//        
//        make.top.equalTo(ws.headerImage.mas_bottom).offset(20);
//        
//        make.left.equalTo(ws.view.mas_left).offset(0);
//        
//        make.right.equalTo(ws.view.mas_right).offset(0);
//        
//        
//        
////        make.center.equalTo(ws.view);
////        make.size.mas_equalTo(CGSizeMake(300, 300));
//     
//    }];
    
    
    [cwySetView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.height.mas_equalTo(60);
        
        make.left.equalTo(ws.view.mas_left).offset(0);
        
        make.right.equalTo(ws.view.mas_right).offset(0);
        
        make.top.equalTo(ws.headerImage.mas_bottom).offset(0);
        
        
    }];
    
    
    UIView *yy = [[UIView alloc]init];
    yy.backgroundColor = CHRGBColor(214, 214, 214);
    [self.setView addSubview:yy];
    
    
    [yy mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(ws.setView.mas_bottom).offset(0);
        
        make.size.mas_equalTo(CGSizeMake(CHScreenW, 1));
        
        
    }];
    
    
    
}

- (void)favClick
{
    
    CHLog(@"111111");
    
    
    if (self.setView.favBtn.selected == NO) {
        [self setupDataFav:0];

    } else
    {
        [self setupDataFav:1];
    }
    
   }

- (void)setupDataFav: (NSInteger)state

{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    
    //[user stringForKey:@"uid"];
    
    
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    param[@"id"] = self.carMessage.ID;
   // param[@"uid"] = @(7);
    param[@"state"] = @(state);
    param[@"uid"] = [user stringForKey:@"uid"];
    
    [self.favManager POST:@"http://www.zhanyiwangluo.com/washcar/index.php/Home/Business/collect" parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        CHLog(@"%@", responseObject);
        
        if (state == 0) {
            [self.setView.favBtn setImage:[UIImage imageNamed:@"sc"] forState:UIControlStateSelected];
            
            self.setView.favBtn.selected = YES;

        } else
        {
            [self.setView.favBtn setImage:[UIImage imageNamed:@"sc_nor"] forState:UIControlStateNormal];
            
            self.setView.favBtn.selected = NO;

        }
        
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


- (void)setupGpsView
{
    //UIView *gpsView = [[UIView alloc]init];
    
    WS(ws);
    
    CWYGpsView *gpsView = [CWYGpsView gpsView];
    
    [gpsView.showButton addTarget:self action:@selector(showMap) forControlEvents:UIControlEventTouchUpInside];
    // UITapGestureRecognizer *tapWxGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeWxImage)];
    
//    UITapGestureRecognizer *tapLable  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBdVc)];
//
//    [gpsView.daohangLable addGestureRecognizer:tapLable];
    
    [gpsView.daohangBtn addTarget:self action:@selector(showBdVc) forControlEvents:UIControlEventTouchUpInside];
    
    self.gpsView = gpsView;
    
//    gpsView.x = 0;
//    gpsView.y = 300;
//    gpsView.width = CHScreenW;
//    gpsView.height = 40;
    
    //gpsView.backgroundColor = [UIColor purpleColor];
    
    [self.view addSubview:gpsView];
    self.gpsView = gpsView;
//    [self.gpsView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.size.mas_equalTo(CGSizeMake(CHScreenW, 40));
//        
//        make.top.equalTo(self.setView.mas_bottom).offset(20);
//        
//        make.left.equalTo(ws.view).offset(0);
//        
//        make.right.equalTo(ws.view).offset(0);
//        
//        
//    }];
    
    [gpsView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(ws.view.mas_left).offset(0);
        
        make.right.equalTo(ws.view.mas_right).offset(0);

        make.size.height.mas_equalTo(40);
        
        make.top.equalTo(ws.setView.mas_bottom).offset(10);
        
    }];
    
    
    UIView *yy = [[UIView alloc]init];
    yy.backgroundColor = CHRGBColor(214, 214, 214);
    [self.gpsView addSubview:yy];
    
    
    [yy mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(ws.gpsView.mas_bottom).offset(0);
        
        make.size.mas_equalTo(CGSizeMake(CHScreenW, 1));
        
        
    }];
}

- (void)showBdVc
{
    CHLog(@"-----");
    
    CWYBaiMapViewController *bdMapVc = [[CWYBaiMapViewController alloc]init];
    
    //[self presentViewController:bdMapVc animated:YES completion:nil];
    bdMapVc.businessBDMap = self.business;
    [self.navigationController pushViewController:bdMapVc animated:YES];
    
}

- (void)showMap
{
    NSMutableDictionary * Dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"起点",@"startName",@"终点",@"endName", nil];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    
    NSString   *chCity = [user stringForKey:@"city"];
    
    NSString *chlatitude = [user stringForKey:@"latitude"];
    
    NSString *chlongitude = [user stringForKey:@"longitude"];
    
    
    [TYNavSheet ShowMapNavSheetSuperView:self withLocationDic:Dic withstartCoor:CLLocationCoordinate2DMake([chlatitude doubleValue], [chlongitude doubleValue]) withendCoor:CLLocationCoordinate2DMake([self.business.latitude doubleValue], [self.business.longitude doubleValue])];
    
    
   

}


- (void)setupButtonView
{
    NSArray *arrayBtn = @[@"服务",@""];
    
    WS(ws);
    UIView *buttonView  = [[UIView alloc]init];
    buttonView.backgroundColor = [UIColor whiteColor];
    
    self.chooseView = buttonView;
    
    [self.view addSubview:buttonView];
    
    [self.chooseView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(CHScreenW, 40));
        
        make.top.equalTo(self.gpsView.mas_bottom).offset(10);
        
        make.left.equalTo(ws.view).offset(0);
        
        make.right.equalTo(ws.view).offset(0);
        
    }];
    
    UIView *yy = [[UIView alloc]init];
    yy.backgroundColor = CHRGBColor(214, 214, 214);
    [buttonView addSubview:yy];
    
    
    [yy mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(buttonView.mas_bottom).offset(0);
        
        make.size.mas_equalTo(CGSizeMake(CHScreenW, 1));
        
        
    }];
    
    UIView *indicatorView = [[UIView alloc] init];
    
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.tag = 1;
    indicatorView.y = 40 - indicatorView.height;
    self.indicatorView = indicatorView;
    
    
    
    CGFloat width = CHScreenW / arrayBtn.count;
    CGFloat height = 40;
    
    for (NSInteger i = 0; i<arrayBtn.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i *width;
       // NSLog(@"ddd", button.frame);
       // NSLog(@"%@", NSStringFromCGRect(button.frame));
        [button setTitle:arrayBtn[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        //[button addTarget:self action:@selector(titleClick:(UIButton *)) forControlEvents:UIControlEventTouchUpOutside];
        //[button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [buttonView addSubview:button];
        
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            /**
             *  让按钮内部lable根据文字内容计算尺寸
             */
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.center.x;
        }
        
    }
    [buttonView addSubview:indicatorView];
    
    
    
    
    
   
    
    
    
}


- (void)setupChoose
{
    
    
//    CWYTestChooseViewController *chooesVc = [[CWYTestChooseViewController alloc]init];
//    
//    [self addChildViewController:chooesVc];
    
    UIView *chooseView = [[UIView alloc]init];
 
    chooseView.backgroundColor = [UIColor redColor];
    WS(ws);
    [self.view addSubview:chooseView];
    
    [chooseView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(ws.view.mas_right).offset(0);
        
        make.bottom.equalTo(ws.view.mas_bottom).offset(0);
        
        make.top.equalTo(ws.chooseView.mas_bottom).offset(5);
        
        make.left.equalTo(ws.view.mas_left).offset(0);
        
        
    }];
    
    
    UITableView *tableCh = [[UITableView alloc]init];
    
//    self.firstTableView.delegate = self;
//    
//   self.firstTableView.dataSource = self;
    
    
    tableCh.delegate = self;
    tableCh.dataSource = self;
    self.firstTableView = tableCh;
    [chooseView addSubview:tableCh];
    
    [tableCh mas_makeConstraints:^(MASConstraintMaker *make) {
        
       
        make.size.width.mas_equalTo(120);
        make.top.equalTo(chooseView.mas_top).offset(0);
        make.left.equalTo(chooseView.mas_left).offset(0);
        make.bottom.equalTo(chooseView.mas_bottom).offset(0);
        
        
    }];
    
    
     UITableView *    secondtableView = [[UITableView alloc]init];
    
    secondtableView.delegate = self;
    secondtableView.dataSource = self;
    self.secondTableView = secondtableView;
    [chooseView addSubview:secondtableView];
    
    [secondtableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(chooseView.mas_top).offset(0);
        make.right.equalTo(chooseView.mas_right).offset(0);
        make.bottom.equalTo(chooseView.mas_bottom).offset(0);
        make.left.equalTo(ws.firstTableView.mas_right).offset(0);
        
        
    }];
    
    
//    chooesVc.view.frame = chooseView.bounds;
//    
//    [chooseView addSubview:chooesVc.view];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.firstTableView) {
        return 4;
    } else {
        return self.secondArray.count;
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //表1
//    if (tableView == firstTable) {
//        
////        static NSString *cellId = @"identify";
////        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//        
//        CWYServicesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CHFirstId];
//        
//        
//        cell.backgroundColor = [UIColor orangeColor];
//        cell.typeLable = self.firstArray[indexPath.row];
//        //cell.textLabel.text = self.firstArray[indexPath.row];
//        return cell;
//    }
    
//    if (tableView == self.firstTableView) {
//        
//        static NSString *cellId = @"identify";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//        
//        if (!cell) {
//            
//            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
//        }
//        cell.backgroundColor = [UIColor orangeColor];
//        cell.textLabel.text = self.firstArray[indexPath.row];
//        return cell;
//  
//}
    
    

//
    if (tableView == self.firstTableView) {
        CWYServicesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CHFirstId];
        //CHTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:CHTopicCellId];
            
            //cell.typeLable = self.firstArray[indexPath.row];
        
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                
                cell.showFirstLable.text = @"汽车服务";
                
            }else if (indexPath.row == 1)
            {
                cell.showFirstLable.text = @"汽车美容";
                
            }else if (indexPath.row == 2)
            {
                cell.showFirstLable.text = @"汽车保养";
                
            }else if(indexPath.row == 3)
            {
                cell.showFirstLable.text = @"汽车维修";
                
            }

        }
        
        
            return cell;
        
        
        
            
        
    }
        //表2
//        static NSString *cellId2 = @"cell";
//        UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:cellId2];
//        
//        if (!cell2) {
//            
//            cell2 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId2];
//        }
//        
//        //    cell2.backgroundColor = [UIColor orangeColor];
//        cell2.textLabel.text = [NSString stringWithFormat:@"表2_第%ld行",(long)indexPath.row];
//        return cell2;
    
    CWYTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CHSecondeId];
    
    cell.server = self.secondArray[indexPath.row];
    //NSIndexPath *hhhhhh = 3;
    
    cell.buyButton.tag = indexPath.row;
    CHLog(@"%@",self.selectedPath);
    //if (self.selectedPath == 3) {
        
//    if (cell.moneyLable.hidden == YES) {
//        CHLog(@"ddddddd");
//        [cell.buyButton addTarget:self action:@selector(forMe) forControlEvents:UIControlEventTouchUpInside];
//            } else
//    {
//        CHLog(@"ccccccc");
        [cell.buyButton addTarget:self action:@selector(buyCar:) forControlEvents:UIControlEventTouchUpInside];
        
        
   // }
        
        //
    //} else
    //{
    
    //}
    
    
   
    return cell;

}

- (void)forMe
{
    CHLog(@"wwwwww");
    
   
    
}

- (void)buyCar:(UIButton *)btn
{
    
    
    CWYServe *sevre = [[CWYServe alloc]init];
    
    sevre = self.secondArray[btn.tag];
    
    if ([sevre.amount isEqualToString:@"0"] ) {
        CHLog(@"%@",btn.titleLabel.text);
        
        CWYZZFKViewController *zzVc = [[CWYZZFKViewController alloc]init];
        
        zzVc.severZZ = sevre;
        
        [self.navigationController pushViewController:zzVc animated:YES];
        
        
    } else
    {
        CHLog(@"3333333%@",btn.titleLabel.text);
        
        
        CHLog(@"nihao");
        
//        CWYServe *sevre = [[CWYServe alloc]init];
//        
//        sevre = self.secondArray[btn.tag];
        
        PaymentView * payView = [[PaymentView alloc] init];
        payView.title = sevre.title;
        payView.payType = PaymentTypeCard;
        payView.alertType = PayAlertTypeSheet;
        payView.translateType = PayTranslateTypeSlide;
        payView.payDescrip = sevre.title;
        payView.payTool = @"积分付款";
        payView.payAmount= [sevre.amount floatValue];
        
        payView.pwdCount = 6;
        [payView show];
        [payView reloadPaymentView];
        payView.completeHandle = ^(NSString *inputPwd) {
            // NSLog(@"密码是%@",inputPwd);
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            WS(ws);
            
            //[user stringForKey:@"uid"];
            
            
            //        id pam = @{
            //                   @"uid":[user stringForKey:@"uid"],
            //                   @"s_id":sevre.ID,
            //                   @"amount":sevre.amount,
            //                   @"buy_pwd":inputPwd
            //                   };
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            
            params[@"uid"] = [user stringForKey:@"uid"];
            params[@"s_id"] = sevre.ID;
            params[@"amount"] = sevre.amount;
            params[@"buy_pwd"] = inputPwd;
            
            CHLog(@"%@,pam",params);
            
            [ws.buyCarManager POST:@"http://www.zhanyiwangluo.com/washcar/index.php/Home/Buy/index" parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSString *message = [NSString stringWithFormat:@"%@", responseObject[@"message"]];
                
                
                CHLog(@"%@",responseObject);
                // CHLog(@"%@,pam",pam);
                //[0]	(null)	 :
                
                if ([message isEqualToString:@"交易密码错误！"]) {
                    [SVProgressHUD showErrorWithStatus:@"交易密码错误"];
                    return ;
                } else
                {
                    [SVProgressHUD showSuccessWithStatus:@"购买成功"];
                }
                
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
        };

        
        
    }
    
    
    
    
    
    
    
    

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(tableView == self.firstTableView){
        
        //CHsecond_row = 1+arc4random_uniform(15);//随机数1-15行
        
       self.selectedPath = indexPath;
        CHLog(@"%@",self.selectedPath);
        
        [self setuoChooseData];
        //CHLog(@"%ld",(long)indexPath.row);
        //[self.secondTableView reloadData];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.firstTableView) {
        return 40;
    } else {
        
        return 100;
        
    }
    
    
    
    
    
}

//- (void)titleClick:(UIButton *)button
//{
//    self.selectedButton.enabled = YES;
//    button.enabled = NO;
//    self.selectedButton = button;
//    
//    [UIView animateWithDuration:0.25 animations:^{
//        
//        //CHLog(@"%@",NSStringFromCGRect(self.indicatorView.frame));
//        
//        
//        
//        self.indicatorView.width = button.titleLabel.width;
//        self.indicatorView.centerX = button.centerX;
//        
//    }];
//    
////    CGPoint offset = self.contentView.contentOffset;
////    offset.x = button.tag *self.contentView.width;
////    [self.contentView setContentOffset:offset animated:YES];
//    
//    
//    if (button.tag == 0) {
//        [self setUpTest];
//    }else{
//       
//        
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.conView animated:YES];
//        hud.mode = MBProgressHUDModeText;
//        hud.labelText = @"Some message...";
//        hud.margin = 10;
//        hud.yOffset = 150;
//        hud.removeFromSuperViewOnHide = YES;
//        [hud hide:YES afterDelay:3];
//        
//        button.enabled = YES;
//        
//        
//        
//        
//    }
//    
//    
//}


//- (void)setupContentView
//{
//    
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    
//    UIScrollView *contentView = [[UIScrollView alloc]init];
//    contentView.frame = self.view.bounds;
//    contentView.delegate = self;
//    //contentView.backgroundColor = [UIColor blueColor];
//    contentView.pagingEnabled = YES;
//    NSLog(@"%@", NSStringFromCGRect(contentView.frame));
//    [self.view insertSubview:contentView atIndex:0];
//    contentView.contentSize = CGSizeMake(contentView.width *self.childViewControllers.count, 00);
//    self.contentView = contentView;
//    
//    
//    
//    [self scrollViewDidEndScrollingAnimation:contentView];
//}
//
//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
//{
//    NSInteger index = scrollView.contentOffset.x / scrollView.width;
//    
//    UIViewController *vc = self.childViewControllers[index];
//    
//    vc.view.x = 0 ;
//    vc.view.y = 300;
//    vc.view.height = 200;
//    vc.view.width = CHScreenW;
//    NSLog(@"%@", NSStringFromCGRect(vc.view.frame));
//    [scrollView addSubview:vc.view];
//}
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    [self scrollViewDidEndScrollingAnimation:scrollView];
//    
//    NSInteger index = scrollView.contentOffset.x / scrollView.width;
//    [self titleClick:self.chooseView.subviews[index]];
//}
//static float progress = 0.0f;
//
//- (void)increaseProgress {
//    progress += 0.05f;
//    [SVProgressHUD showProgress:progress status:@"Loading"];
//    
//    if(progress < 1.0f){
//        [self performSelector:@selector(increaseProgress) withObject:nil afterDelay:0.1f];
//    } else {
//        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.4f];
//    }
//}

//- (void)dismiss {
//    [SVProgressHUD dismiss];
//
//}


- (void)setupDataMessage
{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSString *chlatitude = [user stringForKey:@"latitude"];
    
    NSString *chlongitude = [user stringForKey:@"longitude"];
    
    CHLog(@"%@",chlatitude,chlongitude);
    
    
    //CHLog(@"%@",[user stringForKey:@"uid"]);

     CHLog(@"ssssss%ld",(long)second_row);
    
    [SVProgressHUD showWithStatus:@"正在加载"];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];

     NSInteger chXy =       self.firstTableView.indexPathForSelectedRow.row;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"id"] = self.carMessage.ID;//self.carMessage.ID;
    params[@"serve"] = @(second_row);
    params[@"uid"] = [user stringForKey:@"uid"];
    params[@"longitude"] = chlongitude;
    params[@"latitude"] = chlatitude;
    CHLog(@"ssssss%ld",(long)chXy);
    
    [self.manager POST:@"http://www.zhanyiwangluo.com/washcar/index.php/Home/Business/index"
 parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
        self.business = [CWYBusinessMinute mj_objectWithKeyValues:responseObject[@"business"]];
        
        
        self.secondArray = [CWYServe mj_objectArrayWithKeyValuesArray:responseObject[@"serve"]];
        [self.secondTableView reloadData];
        CHLog(@"0000000000%@",responseObject[@"collect"]);
        NSString *collect = [NSString stringWithFormat:@"%@",responseObject[@"collect"]];
        
        NSString *distance = [NSString stringWithFormat:@"%@", responseObject[@"distance"]];
        
        [self.headerImage setImageWithURL:[NSURL URLWithString:self.business.picture] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
        
        CHLog(@"%@-------", self.business.picture);
        CHLog(@"%@",_headerImage);
        self.setView.titleLable.text = self.business.title;
        
        self.setView.pay_count.text = self.business.pay_count;
        
        //self.setView.score.text = self.business.score;
        
        self.setView.phongBtn.titleLabel.text = self.business.phone;
        
        self.setView.isVipImage.hidden = self.business.approve;
        
        
        if (self.setView.isVipImage.hidden == YES) {
            self.setView.titlename.constant = 10;
            
        } else
        {
            self.setView.titlename.constant = 55;
        }
        
        self.gpsView.addressLable.text = self.business.address;
        
        NSString *showUser = @"km";
        
        NSString *showUesrPhone = [distance substringToIndex:3];
        
        NSString  *distanceShow = [showUesrPhone stringByAppendingString:showUser];

        self.gpsView.longLable.text = distanceShow;
        
        
        if ([collect isEqualToString:@"0"]) {
             self.setView.favBtn.selected = NO;
            
            [self.setView.favBtn setImage:[UIImage imageNamed:@"sc_nor"] forState:UIControlStateNormal];
        } else
        {
            self.setView.favBtn.selected = YES;
            [self.setView.favBtn setImage:[UIImage imageNamed:@"sc"] forState:UIControlStateSelected];
            
        }
        
        
        
        
        
        [SVProgressHUD showSuccessWithStatus:@"加载完成"];
       [self performSelector:@selector(dismiss) withObject:nil afterDelay:1];
        
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"链接失败，请稍后再试"];
        
        NSLog(@"%@",error);
        
    }];
}

- (void)dismiss
{
    [SVProgressHUD dismiss];
}

- (void)setuoChooseData
{
    
    NSInteger serve = self.firstTableView.indexPathForSelectedRow.row;
    
    CHLog(@"%ld",serve);
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    para[@"id"] = self.carMessage.ID;
    para[@"serve"] = @(serve);
    
    [self.manager POST:@"http://www.zhanyiwangluo.com/washcar/index.php/Home/Business/index" parameters:para progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        self.secondArray = [CWYServe mj_objectArrayWithKeyValuesArray:responseObject[@"serve"]];
        [self.secondTableView reloadData];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

//- (void)postJsonToServer {
//    
//    
////    NSMutableDictionary *parma = [NSMutableDictionary dictionary];
////    
////    parma[@"id"] = @(1);
//    
//    NSDictionary *body = @{@"id":@(1)};
//    
//    NSError *error;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
//    
//    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    
//    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:@"http://www.zhanyiwangluo.com/washcar/index.php/Home/Business/index" parameters:nil error:nil];
//    
//    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
//    
//    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    
//    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    
//    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        
//        if (!error) {
//            
//            NSLog(@"Reply JSON: %@", responseObject);
//            
//            if ([responseObject isKindOfClass:[NSDictionary class]]) {
//                
//                //blah blah
//                
//            }
//            
//        } else {
//            
//            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
//            
//        }
//        
//    }] resume];
//    
//}






- (void)setupNav
{
    //self.title = @"设置";
    self.view.backgroundColor = CHRGBColor(245, 244, 244);
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationButtonReturn" highImage:@"navigationButtonReturnClick" target:self action:@selector(back)];
    
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"fx" highImage:@"fx" target:self action:@selector(wxShow)];
    
    
    
    

    
    
}


- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)wxShow
{
    
    
    
//    if (![WXApi isWXAppInstalled]) {
//        //ADShowErrorAlert(kWXNotInstallErrorTitle);
//        
//        [SVProgressHUD showErrorWithStatus:@"您还没有安装微信，不能使用微信分享功能"];
//        
//    }
    [[[UIActionSheet alloc] initWithTitle:@"分享到微信"
                                 delegate:self
                        cancelButtonTitle:@"取消"
                   destructiveButtonTitle:nil
                        otherButtonTitles:@"分享给朋友", @"分享到朋友圈", nil] showInView:self.view];
    
    
//    req.text = @"测试把信息分享到微信好友";
//    req.bText = YES;
//    req.scene = WXSceneSession;//会话(WXSceneSession)或者朋友圈(WXSceneTimeline)
//     = rep;
//    [WXApi sendReq:req];
    
    

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
   
    //NSURL *baidu = [NSURL URLWithString:@"www.baidu.com"];
    
    NSString *string1 = @"http://www.zhanyiwangluo.com/washcar/index.php/Home/Register /h_index";
    NSString *string2 = @"?id=";
    //= [NSString initWithFormat:@"%@,%@,%@",string1 ,string2,self.carMessage.ID];
    
    NSString *string3 = self.carMessage.ID;
    
    NSString *CHi  = [string1 stringByAppendingFormat:@"%@,%@",string2, string3];
    switch (buttonIndex) {
            
            
        case 0: // 转发到会话
            
            
            self.webMessage.title = self.carMessage.title;
            
            self.webMessage.description = self.carMessage.address;
            
            self.webpage.webpageUrl = CHi;
            
            //[self.webMessage setThumbImage:self.wxImage];
            
            self.webMessage.mediaObject = self.webpage;
            
            self.rep.bText = NO;
            
            self.rep.message = self.webMessage;
            
            self.rep.scene = WXSceneSession;
            
            [WXApi sendReq:self.rep];
            
            
            
            
            break;
        case 1: //分享到朋友圈
            
            self.webMessage.title = self.carMessage.title;
            
            self.webMessage.description = self.carMessage.address;
            
            //[self.webMessage setThumbImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.carMessage.picture]]]];
            
            self.webpage.webpageUrl = CHi;
            
            self.webMessage.mediaObject = self.webpage;
            
            self.rep.bText = NO;
            
            self.rep.message = self.webMessage;
            
            self.rep.scene = WXSceneTimeline;
            
            
            [WXApi sendReq:self.rep];
            
            
            
            
            break;
        default:
            break;
    }
}


- (void)setupChildVc

{
    //CWYChoosePayViewController *vc = [[CWYChoosePayViewController alloc]init];
    CWYTestChooseViewController *vc = [[CWYTestChooseViewController alloc]init];
    //vc.carMessage = self.carMessage;
    [self addChildViewController:vc];
    
    
//    CWYChoosePayViewController *vc1 = [[CWYChoosePayViewController alloc]init];
//    
//    [self addChildViewController:vc1];
    
    
//    CWYDonTouchViewController *dontVc = [[CWYDonTouchViewController alloc]init];
//    
//    [self addChildViewController:dontVc];
    
    
    
}


- (void)setUpTest

{
//    UIView *test = [[UIView alloc]init];
//    
//    test.backgroundColor = [UIColor blackColor];
    
    
    //UIViewController *vc = self.childViewControllers[0];
    
//    CWYTestChooseViewController *vc = [[CWYTestChooseViewController alloc]init];
//    //vc.carMessage = self.carMessage;
//    [self addChildViewController:vc];
//    
//    NSLog(@"%@", NSStringFromCGRect(vc.view.frame));
//    vc.view.frame = self.conView.bounds;
//    self.conView = vc.view;
    
    CWYTestChooseViewController *chooseVc = [[CWYTestChooseViewController alloc]init];
    
    [self addChildViewController:chooseVc];
    
    UIView *conView = [[UIView alloc]init];
    
    conView.backgroundColor = [UIColor redColor];
    //[self.view addSubview:vc.view];
    self.conView = conView;
    
    //self.conView = vc.view;
    
    WS(ws);
    
    //[self.view addSubview:test];
    
    [self.conView mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.right.equalTo(ws.view.mas_right).offset(0);
        
        make.bottom.equalTo(ws.view.mas_bottom).offset(0);
        
        make.top.equalTo(ws.chooseView.mas_bottom).offset(10);
        
        make.left.equalTo(ws.view.mas_left).offset(0);
        
    }];
    
    
//    UIViewController *vc = self.childViewControllers[0];
//    
//    vc.view.x = 0;
//    vc.view.y = 0;
//    vc.view.height = self.conView.height;
//    vc.view.width = CHScreenW;
//    NSLog(@"%@", NSStringFromCGRect(vc.view.frame));
//    [self.conView addSubview:vc.view];
    

    
    
    

    




}
     
- (void)callPhone:(UIButton *)btn
    {
        NSString *ph1 = @"tel:";
        NSString *phoneCode = btn.titleLabel.text;
        NSString  *phone = [ph1 stringByAppendingString:phoneCode];
        UIAlertController *alertControler = [UIAlertController alertControllerWithTitle:@"拨号" message:phoneCode preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
            return ;
        }];
        UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
            //
            //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone] options:@{} completionHandler:nil];
        }];
        [alertControler addAction:noAction];
        [alertControler addAction:yesAction];
        [self presentViewController:alertControler animated:YES completion:nil];
        
    }
     



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc
{
    [self.manager.operationQueue cancelAllOperations];
    
    [SVProgressHUD dismiss];
}

@end
