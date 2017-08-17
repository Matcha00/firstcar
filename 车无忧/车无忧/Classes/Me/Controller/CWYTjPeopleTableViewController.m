//
//  CWYTjPeopleTableViewController.m
//  车无忧
//
//  Created by 陈欢 on 2017/8/9.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYTjPeopleTableViewController.h"
#import "CWYTjPeople.h"
#import "CWYTjPeopleTableViewCell.h"
#import <AFNetworking.h>
#import <MJRefresh.h>
#import <MJExtension.h>
@interface CWYTjPeopleTableViewController ()

@property (nonatomic, strong) AFHTTPSessionManager *peopleManager;

@property (nonatomic, strong) NSMutableArray *peopleArray;

@end

@implementation CWYTjPeopleTableViewController

static NSString * const CHPeople = @"people";


- (AFHTTPSessionManager *)peopleManager
{
    if (!_peopleManager) {
        _peopleManager = [AFHTTPSessionManager manager];
    }
    
    return _peopleManager;
}


- (NSMutableArray *)peopleArray
{
    if (!_peopleArray) {
        _peopleArray = [NSMutableArray array];
    }
    
    return _peopleArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self serupTable];
    
    [self ref];
    
    [self setupNav];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)serupTable
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CWYTjPeopleTableViewCell class]) bundle:nil] forCellReuseIdentifier:CHPeople];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}


- (void)ref
{
    self.tableView.mj_header  = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(setData)];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)setData
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    //params[@"uid"] = [user stringForKey:@"uid"];
    id pram  = @{@"uid":[user stringForKey:@"uid"]};
   
    
    [self.peopleManager POST:@"http://www.zhanyiwangluo.com/washcar/index.php/Home/Personage/recommendList" parameters:pram progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        CHLog(@"%@", responseObject);
        self.peopleArray = [CWYTjPeople mj_objectArrayWithKeyValuesArray:responseObject[@"recommendData"]];
        [self.tableView reloadData];
        CHLog(@"%@0000000000", self.peopleArray);
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.peopleArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CWYTjPeopleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CHPeople];
    
    cell.people = self.peopleArray[indexPath.row];
   // CHLog(@"%@", self)
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
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
- (void)setupNav
{
    self.title = @"我的推荐";
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
