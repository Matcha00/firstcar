//
//  CWYFkViewController.m
//  车无忧
//
//  Created by 陈欢 on 2017/8/15.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYFkViewController.h"
#import "CHPlaceholderTextView.h"
#import "BRPlaceholderTextView.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
@interface CWYFkViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *backgroundView;

@property (nonatomic, weak) BRPlaceholderTextView *textCh;

@property (nonatomic, weak) CHPlaceholderTextView *textView;

@property (nonatomic, strong) AFHTTPSessionManager *textManager;

@end

@implementation CWYFkViewController


- (AFHTTPSessionManager *)textManager
{
    if (!_textManager) {
        _textManager = [AFHTTPSessionManager manager];
    }
    
    return _textManager;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupNav];
    
    [self setupText];
    
    //[self setupTextView];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)fkButton:(UIButton *)sender {
    
    
    CHLog(@"%@", self.textCh.text);
    
    
    if (self.textCh.text.length < 1) {
        [SVProgressHUD showErrorWithStatus:@"请输入反馈内容"];
        
        return;
    }
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    //params[@"uid"] = [user stringForKey:@"uid"];
    id pram  = @{@"uid":[user stringForKey:@"uid"],
                 @"countent": self.textCh.text};
    
    
    [self.textManager POST:@"http://www.zhanyiwangluo.com/washcar/index.php/Home/Personage/feedback" parameters:pram progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        CHLog(@"%@",responseObject);
        
        [SVProgressHUD showSuccessWithStatus:@"提交成功"];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)setupText
{
    BRPlaceholderTextView *view=[[BRPlaceholderTextView alloc] initWithFrame:CGRectMake(10, 100, CHScreenW -10*2, 80)];
    view.placeholder=@"请输入您的问题";
    view.font=[UIFont boldSystemFontOfSize:14];
    view.layer.borderColor=[UIColor lightGrayColor].CGColor;
    [self.view addSubview:view];
    
    [view setPlaceholderColor:[UIColor lightGrayColor]];
    [view setPlaceholderOpacity:0.6];
    [view addMaxTextLengthWithMaxLength:100 andEvent:^(BRPlaceholderTextView *text) {
        
        NSLog(@"----------");
    }];
    
    [view addTextViewBeginEvent:^(BRPlaceholderTextView *text) {
        NSLog(@"begin");
    }];
    
    [view addTextViewEndEvent:^(BRPlaceholderTextView *text) {
        NSLog(@"end");
    }];
    self.textCh = view;
    //view.layoutManager.allowsNonContiguousLayout=NO;
    // view.scrollEnabled=NO;
    // Do any additional setup after loading the view, typically from a nib.
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)setupTextView
{
    CHPlaceholderTextView *textView = [[CHPlaceholderTextView alloc] init];
    textView.placeholder = @"qing";
    //textView.backgroundColor = [UIColor redColor];
    //textView.placeholderColor = [UIColor redColor];
    textView.frame = self.view.bounds;
//    textView.x = 25;
//    textView.y = 40;
//    textView.width = CHScreenW - 50;
//    textView.height = 150;
    
    textView.delegate = self;
    textView.backgroundColor = [UIColor redColor];
    [self.backgroundView addSubview:textView];
    self.textView = textView;
    
    
}

//- (void)setupNav
//{
//    self.title = @"发表文字";
//    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
//    self.navigationItem.rightBarButtonItem.enabled = NO;
//    
//    [self.navigationController.navigationBar layoutIfNeeded];
//    
//    
//}
//
//- (void)cancel
//{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
//
//
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    
//    [self.textView becomeFirstResponder];
//}
//
//- (void)textViewDidChange:(UITextView *)textView
//{
//    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
//}
//
//- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
//{
//    [self.view endEditing:YES];
//}
- (void)setupNav
{
    self.title = @"意见反馈";
    self.view.backgroundColor = CHRGBColor(245, 244, 244);
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationButtonReturn" highImage:@"navigationButtonReturnClick" target:self action:@selector(back)];
    
    
    //self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"fx" highImage:@"fx" target:self action:@selector(wxShow)];
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor whiteColor]}] ;
    
    
    
    
}


- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
