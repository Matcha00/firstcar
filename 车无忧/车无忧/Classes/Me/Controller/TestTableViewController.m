//
//  TestTableViewController.m
//  车无忧
//
//  Created by 陈欢 on 2017/7/30.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "TestTableViewController.h"
#import "CWYBuyMessageTableViewCell.h"
#import <AFNetworking.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import "CWYBuyMessage.h"
@interface TestTableViewController ()

@property (nonatomic, strong) AFHTTPSessionManager *buyManager;

@property (nonatomic, strong) NSMutableArray *buyMeArray;


@end

@implementation TestTableViewController

static NSString * const CHBuyMeId = @"buy";


- (AFHTTPSessionManager *)buyManager
{
    if (!_buyManager) {
        _buyManager = [AFHTTPSessionManager manager];
    }
    
    return _buyManager;
}

- (NSMutableArray *)buyMeArray
{
    if (!_buyMeArray) {
        _buyMeArray = [NSMutableArray array];
    }
    
    return _buyMeArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self setupRef];
    [self setupTableView];
    [self setupNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setupTableView
{
    //[self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CWYBuyMessageTableViewCell class]) bundle:nil forCellReuseIdentifier:CHBuyMeId]];
    
     [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CWYBuyMessageTableViewCell class]) bundle:nil] forCellReuseIdentifier:CHBuyMeId];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

}


- (void)setupRef
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(testRef)];
    
    [self.tableView.mj_header beginRefreshing];
}


- (void)testRef
{
    
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    //params[@"uid"] = [user stringForKey:@"uid"];
    id pram  = @{@"uid":[user stringForKey:@"uid"]};
    
    
    [self.buyManager POST:@"http://www.zhanyiwangluo.com/washcar/index.php/Home/Personage/buyList" parameters:pram progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSLog(@"ddddddd");
//        
       NSLog(@"%@",responseObject[@"orderData"]);
//        
//        CHLog(@"%@", responseObject);
        
        self.buyMeArray  = [CWYBuyMessage mj_objectArrayWithKeyValuesArray:responseObject[@"orderData"]];
        
        //self.carMessages = [CWYCarMessage mj_objectArrayWithKeyValuesArray:responseObject[@"business"]];
        
       // self.buyMeArray = test;
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
       // CHLog(@"----------%@",self.buyMeArray);
        
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
    return self.buyMeArray.count;
    
    //CHLog(@"%@", self.buyMeArray.count);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CWYBuyMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CHBuyMeId];
    
    cell.buyMessage = _buyMeArray[indexPath.row];
   // CHLog(@"+++++%@",_buyMeArray[indexPath.row]);
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


- (void)setupNav
{
    self.title = @" 购买记录";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor whiteColor]}] ;
    self.view.backgroundColor = CHRGBColor(245, 244, 244);
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationButtonReturn" highImage:@"navigationButtonReturnClick" target:self action:@selector(back)];
    
    
    //self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"fx" highImage:@"fx" target:self action:@selector(wxShow)];
    
    
    
    
    
    
    
}


- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
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

@end
