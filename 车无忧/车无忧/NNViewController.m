//
//  NNViewController.m
//  Test
//
//  Created by 陈欢 on 2017/6/18.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "NNViewController.h"
#import <Masonry.h>
#import "CWYShowMessageViewController.h"
#import <NJKWebViewProgressView.h>
#import <NJKWebViewProgress.h>
#import <SVProgressHUD.h>
#import "WXApiObject.h"
#import "WXApi.h"
@interface NNViewController () <UIWebViewDelegate,NJKWebViewProgressDelegate,UIActionSheetDelegate>

{
    NJKWebViewProgressView *_progressView;
    
    NJKWebViewProgress *_progressProxy;
}


@property (nonatomic, strong) SendMessageToWXReq *rep;

@property (nonatomic, strong) WXMediaMessage *webMessage;

@property (nonatomic, strong) WXWebpageObject *webpage;

@property (nonatomic, weak) UIWebView *webView;

@property (nonatomic, strong) NSString *wxUrl;

@property (nonatomic, strong) NSString *wxtitle;

@end

@implementation NNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"车生活";
//    _progressProxy = [[NJKWebViewProgress alloc]init];
//    
//    
//    _progressProxy.webViewProxyDelegate = self;
//    _progressProxy.progressDelegate = self;
    
//    CGFloat progressBarHeight = 3.f;
//    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
//    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, CHScreenW, progressBarHeight);
//    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
//    [_progressView setProgress:0 animated:YES];
    //_progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    self.rep = [[SendMessageToWXReq alloc] init];
    self.webMessage = [[WXMediaMessage alloc]init];
    
    self.webpage = [WXWebpageObject object];

    
    
    UIWebView   *webView = [[UIWebView alloc]init];
    webView.delegate = self;
    self.webView = webView;
    
    webView.frame = self.view.bounds;
    
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL URLWithString:@"http://www.zhanyiwangluo.com/washcar/index.php/Home/Archives/index/id/1"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
    
    [self setupNav];
    
    
}
- (void)setupNav
{
    
    self.view.backgroundColor = CHRGBColor(245, 244, 244);
    
    //[self.navigationController.navigationBar.backItem setHidesBackButton:YES];
    //self.navigationItem.hidesBackButton = YES;
    
    
    //self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationButtonReturn" highImage:@"navigationButtonReturnClick" target:self action:@selector(back)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"fx" highImage:@"fx" target:self action:@selector(wxShow)];
    
//    if (self.webView.canGoBack == YES) {
//        [self.navigationController.navigationBar.backItem setHidesBackButton:NO];
//    } else
//    {
//        [self.navigationController.navigationBar.backItem setHidesBackButton:YES];
//    }
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor whiteColor]}] ;
    
}


- (void)back
{
    if (self.webView.canGoBack == YES) {
        [self.webView goBack];
        
        [SVProgressHUD dismiss];
        //self.navigationItem.hidesBackButton = NO;
        
    }else{
        //[self.navigationController popViewControllerAnimated:YES];
//        self.navigationItem.leftBarButtonItem = nil;
//        self.navigationItem.hidesBackButton = YES;
        
        //self.navigationItem.hidesBackButton = YES;
        
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *currentURL = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    
    
    self.wxUrl = currentURL;
    
    NSString *webTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    self.wxtitle = webTitle;
    
    [SVProgressHUD showSuccessWithStatus:@"加载完成"];
    [self performSelector:@selector(dismissc) withObject:nil afterDelay:1];
    if (self.webView.canGoBack == YES) {
        //[self.webView goBack];
        self.navigationItem.hidesBackButton = NO;
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationButtonReturn" highImage:@"navigationButtonReturnClick" target:self action:@selector(back)];
    }else{
        //[self.navigationController popViewControllerAnimated:YES];
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = YES;
        
        //self.navigationItem.hidesBackButton = YES;
        
    }

    
    
    CHLog(@"%@", currentURL);
}

- (void)dismissc
{
    [SVProgressHUD dismiss];
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //[SVProgressHUD showWithStatus:@"正在加载"];
}




- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
    //[_progressView removeFromSuperview];
}
//-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
//{
//    [_progressView setProgress:progress animated:YES];
//    self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
//}



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
    
//    NSString *string1 = @"http://www.zhanyiwangluo.com/washcar/index.php/Home/Register /h_index";
//    NSString *string2 = @"?id=";
//    //= [NSString initWithFormat:@"%@,%@,%@",string1 ,string2,self.carMessage.ID];
//    
//    NSString *string3 = self.carMessage.ID;
//    
//    NSString *CHi  = [string1 stringByAppendingFormat:@"%@,%@",string2, string3];
    switch (buttonIndex) {
            
            
        case 0: // 转发到会话
            
            
            self.webMessage.title = self.wxtitle;
            
            self.webMessage.description = self.wxtitle;
            
            self.webpage.webpageUrl = self.wxUrl;
            
            //[self.webMessage setThumbImage:self.wxImage];
            
            self.webMessage.mediaObject = self.webpage;
            
            self.rep.bText = NO;
            
            self.rep.message = self.webMessage;
            
            self.rep.scene = WXSceneSession;
            
            [WXApi sendReq:self.rep];
            
            
            
            
            break;
        case 1: //分享到朋友圈
            
            self.webMessage.title = self.wxtitle;
            
            self.webMessage.description = self.wxtitle;
            
            //[self.webMessage setThumbImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.carMessage.picture]]]];
            
            self.webpage.webpageUrl = self.wxUrl;
            
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


- (NSData *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return UIImageJPEGRepresentation(newImage, 0.8);
}

// ------调用
//UIImage *img = [UIImage imageWithData:[self imageWithImage:image scaledToSize:CGSizeMake(300, 300)]]





- (void)dealloc
{
    [SVProgressHUD dismiss];
}
















@end
