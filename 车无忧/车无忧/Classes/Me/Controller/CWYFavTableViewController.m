//
//  CWYFavTableViewController.m
//  车无忧
//
//  Created by 陈欢 on 2017/8/1.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYFavTableViewController.h"
#import "CWYfavTableViewCell.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import "CWYFav.h"
@interface CWYFavTableViewController ()

@property(nonatomic, strong) AFHTTPSessionManager *facmanager;

@property(nonatomic, strong) NSMutableArray *facArray;




@end

@implementation CWYFavTableViewController
static NSString * const CHFavId = @"fav";

- (AFHTTPSessionManager *)facmanager
{
    if (!_facmanager) {
        _facmanager = [AFHTTPSessionManager manager];
        
    }
    
    return _facmanager;
}


- (NSMutableArray *)facArray
{
    if (!_facArray) {
        _facArray = [NSMutableArray array];
    }
    
    return _facArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    [self setupTableView];
    [self setupRef];
    [self setupNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






- (void)setupTableView
{
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CWYfavTableViewCell class]) bundle:nil] forCellReuseIdentifier:CHFavId];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

}


- (void)setupRef

{
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refFav)];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)refFav
{
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    
    //CHLog(@"%@",[user stringForKey:@"uid"]);

    
    id pram  = @{@"uid": [user stringForKey:@"uid"]};
    
    
    [self.facmanager POST:@"http://www.zhanyiwangluo.com/washcar/index.php/Home/Personage/collectList" parameters:pram progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
                    CHLog(@"%@", responseObject);
        
        self.facArray  = [CWYFav mj_objectArrayWithKeyValuesArray:responseObject[@"collectData"]];
        
        CHLog(@"%@",self.facArray);
       
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        
    }];

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.facArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CWYfavTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CHFavId];
    cell.fav = self.facArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

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
- (void)setupNav
{
    self.title = @" 我的收藏";
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
