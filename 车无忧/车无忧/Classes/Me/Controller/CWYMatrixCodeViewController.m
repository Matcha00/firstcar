//
//  CWYMatrixCodeViewController.m
//  车无忧
//
//  Created by 陈欢 on 2017/7/16.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYMatrixCodeViewController.h"
#import <Masonry.h>
#import <AFNetworking.h>
#import <YYModel.h>
#import <UIImageView+AFNetworking.h>
#import "WXApiObject.h"
#import "WXApi.h"
#import <SVProgressHUD.h>
@interface CWYMatrixCodeViewController () <UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *downUrlImage;

@property (weak, nonatomic) IBOutlet UIImageView *resUrlImage;
@property (weak, nonatomic) IBOutlet UILabel *phoneLable;
@property (nonatomic, strong) AFHTTPSessionManager *ewmManager;

@property (nonatomic, strong) NSMutableArray *ewmArray;

@property (nonatomic, strong) SendMessageToWXReq *rep;

@property (nonatomic, strong) WXMediaMessage *webMessage;

@property (nonatomic, strong) WXWebpageObject *webpage;

@end

@implementation CWYMatrixCodeViewController


- (AFHTTPSessionManager *)ewmManager
{
    if (!_ewmManager) {
        _ewmManager = [AFHTTPSessionManager manager];
    }
    
    return _ewmManager;
}

- (NSMutableArray *)ewmArray
{
    if (!_ewmArray) {
        _ewmArray = [NSMutableArray array];
    }
    
    return _ewmArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setupErweima];
    
    //[self setupImage];
    self.rep = [[SendMessageToWXReq alloc] init];
    self.webMessage = [[WXMediaMessage alloc]init];
    
    self.webpage = [WXWebpageObject object];
    
}


- (void)setupErweima
{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    
    //CHLog(@"%@",[user stringForKey:@"uid"]);
    

    id params = @{@"uid":[user stringForKey:@"uid"],
                  @"status":@(1)
                  };
    
    
    [self.ewmManager POST:@"http://www.zhanyiwangluo.com/washcar/index.php/Home/Business/shareAddress" parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        CHLog(@"%@", responseObject);
        
        NSString *phone = [NSString stringWithFormat:@"%@",responseObject[@"phone"]];
        
        NSString *downLoadUrl = [NSString stringWithFormat:@"%@",responseObject[@"downloadUrl"]];
                                 
                                 NSString *registerUrl = [NSString stringWithFormat:@"%@",responseObject[@"registerUrl"]];
        
        
        self.phoneLable.text = phone;
        
        //[self.downUrlImage setImageWithURL:[NSURL URLWithString:downLoadUrl]placeholderImage:[UIImage imageNamed:@"placeholderImage"];
        [self.downUrlImage setImageWithURL:[NSURL URLWithString:downLoadUrl] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
        
                [self.resUrlImage setImageWithURL:[NSURL URLWithString:registerUrl] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
        
        //[self.downUrlImage sd_setImageWithURL:[NSURL URLWithString:carMessage.picture]placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
        //self.downUrlImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:downLoadUrl]]];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setupImage
{
    __weak typeof(self) weakSelf = self;
    
    UILabel *myDownCode = [[UILabel alloc] init];
    
    myDownCode.text = @"我的下载码";
    [myDownCode setFont:[UIFont systemFontOfSize:14]];
    
    [self.view addSubview:myDownCode];
    
    [myDownCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80);
        make.left.mas_equalTo(50);
        make.size.mas_equalTo(CGSizeMake(CHScreenW, 40));
        
    }];
    
    
    UIImageView *downCodeImage = [[UIImageView alloc]init];
    
    //downCodeImage.backgroundColor = [UIColor blueColor];
    downCodeImage.image = [UIImage imageNamed:@"wode"];
    [self.view addSubview:downCodeImage];
    
    [downCodeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myDownCode).offset(50);
        make.size.mas_equalTo(CGSizeMake(150, 100));
        make.centerX.mas_equalTo(weakSelf.view);
    }];
    
    UILabel *myShare = [[UILabel alloc]init];
    myShare.text = @"我的分享码";
    [myShare setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:myShare];
    
    [myShare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(CHScreenW, 40));
        make.left.mas_equalTo(50);
        make.top.equalTo(downCodeImage).offset(150);
    }];
    
    UIImageView *shareCodeImage = [[UIImageView alloc]init];
    shareCodeImage.image = [UIImage imageNamed:@"wode"];
    //shareCodeImage.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:shareCodeImage];
    
    [shareCodeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150, 100));
        make.top.equalTo(myShare).offset(50);
        make.centerX.equalTo(weakSelf.view);
    }];
    
    
    
}


- (void)setupNav
{
    self.title = @"我的二维码";
    //self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationButtonReturn" highImage:@"navigationButtonReturnClick" target:self action:@selector(back)];
    
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"fx" highImage:@"fx" target:self action:@selector(wxShow)];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor whiteColor]}] ;
}


- (void)wxShow
{
    
    
    
//    if (![WXApi isWXAppInstalled]) {
//        //ADShowErrorAlert(kWXNotInstallErrorTitle);
//        
//        [SVProgressHUD showErrorWithStatus:@"您还没有安装微信，不能使用微信分享功能"];
//        return;
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
    
    NSURL *baidu = [NSURL URLWithString:@"www.baidu.com"];
    
    switch (buttonIndex) {
            
            
        case 0: // 转发到会话
            
            
            self.webMessage.title = @"车无忧";
            
            self.webMessage.description = @"一款让你不在为保养爱车而发愁的移动APP";
            
            self.webpage.webpageUrl = @"http://www.zhanyiwangluo.com/washcar/index.php/Home/Business/index";
            
           // [self.webMessage setThumbImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.carMessage.picture]]]];
            [self.webMessage setThumbImage:[UIImage imageNamed:@"addFx"]];
            
            self.webMessage.mediaObject = self.webpage;
            
            self.rep.bText = NO;
            
            self.rep.message = self.webMessage;
            
            self.rep.scene = WXSceneSession;
            
            [WXApi sendReq:self.rep];
            
            
            
            
            break;
        case 1: //分享到朋友圈
            
            self.webMessage.title =  @"车无忧";
            
            self.webMessage.description = @"一款让你不在为保养爱车而发愁的移动APP";
            
            //[self.webMessage setThumbImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.carMessage.picture]]]];
            
            [self.webMessage setThumbImage:[UIImage imageNamed:@"addFx"]];
            
            self.webpage.webpageUrl = @"http://www.zhanyiwangluo.com/washcar/index.php/Home/Business/index";
            
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



- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
