//
//  CWYBuyMessageTableViewController.m
//  车无忧
//
//  Created by 陈欢 on 2017/7/20.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYBuyMessageTableViewController.h"
#import "CWYBuyMessageTableViewCell.h"
#import <AFNetworking.h>
#import <YYModel.h>
#import "CWYBuyMessage.h"
#import <MJExtension.h>
#import <MJRefresh.h>
@interface CWYBuyMessageTableViewController ()

@property (nonatomic, strong) AFHTTPSessionManager *buyManager;

//@property (nonatomic, strong) CWYBuyMessage *buyMessage;

@property (nonatomic, strong) NSMutableArray *buyArray;

@end

@implementation CWYBuyMessageTableViewController





static  NSString * const CHBuyId = @"buy";



- (AFHTTPSessionManager *)buyManager
{
    if (_buyManager) {
        _buyManager  = [AFHTTPSessionManager manager];
    }
    
    return _buyManager;
}

- (NSMutableArray *)buyArray
{
    if (!_buyArray) {
        _buyArray = [NSMutableArray array];
    }
    return _buyArray;
}

- (void)viewDidLoad {
    
    
    
    [super viewDidLoad];
    
    //[self setupNav];
    
    //[self setupTableView];
    
    //[self setupUser];
    
    
   // [self setupRef];
    
    //[self loadNewBuyMessage];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setupTableView
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CWYBuyMessageTableViewCell class]) bundle:nil] forCellReuseIdentifier:CHBuyId];
}


- (void)setupNav
{
    self.title = @"消费记录";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationButtonReturn" highImage:@"navigationButtonReturnClick" target:self action:@selector(back)];
    
    
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)setupRef

{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewBuyMessage)];
    [self.tableView.mj_header beginRefreshing];
    //self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    //[self.tableView.mj_header beginRefreshing];
}



#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.buyArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CWYBuyMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CHBuyId];
    cell.buyMessage = self.buyArray[indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)loadNewBuyMessage
{
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    
//    params[@"uid"] = @(1);
    
    
//    [self.buyManager POST:@"http://www.zhanyiwangluo.com/washcar/index.php/Home/Personage/buyList" parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"dddd");
//        
//        
//        
//        self.buyArray = [CWYBuyMessage mj_objectArrayWithKeyValuesArray:responseObject[@"orderData"]];
//        
//        //self.showMessageLable.text = user.phone;
//        
//        [self.tableView reloadData];
//        
//        [self.tableView.mj_header endRefreshing];
//      
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        NSLog(@"%@", error);
//        
//    }];
//    
//    [self.buyManager POST:@"http://www.zhanyiwangluo.com/washcar/index.php/Home/Personage/buyList" parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        NSLog(@"dddd");
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//         NSLog(@"%@", error);
//        
//    }];
    
    
    id params = @{
                  @"uid": @"1",
                 };
    //     NSString *apiUrl = [NSString stringWithFormat:@"%@,%@", CHUrl,@"User/editPwd"];
    //
    //    [self.changeManager POST:apiUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
    //
    //    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //
    //
    //        NSLog(@"ssss",responseObject);
    //
    //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    //
    //    }];
    
    
    
    //    id params = @{
    //                  @"phone": self.firstPwd.text,
    //                  @"password": self.secondPwd.text
    //                  };
    
    //
    //    [params setObject:@"phone" forKey:@"phone"];
    //    [params setObject:@"password" forKey:@"password"];
    
    [self.buyManager POST:@"http://www.zhanyiwangluo.com/washcar/index.php/Home/Personage/buyList" parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"dddd");
        NSLog(@"%@",params);
        NSLog(@"%@",responseObject);
        
        //        NSUserDefaults *userDe = [NSUserDefaults standardUserDefaults];
        //
        //        [userDe setObject:self.userName.text forKey:@"username"];
        //        [userDe setObject:self.passWord.text forKey:@"password"];
        //        [userDe setObject:@"YES" forKey:@"isLogIn"];
        //        [SVProgressHUD showSuccessWithStatus:@"登录成功"];
        //        [self back];
        //        [userDe synchronize];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
    

    
    
    
    
}

//- (void)dealloc
//{
//    [self.buyManager.operationQueue cancelAllOperations];
//    
//    //[SVProgressHUD dismiss];
//}
@end
