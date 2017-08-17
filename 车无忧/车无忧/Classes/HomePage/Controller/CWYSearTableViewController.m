//
//  CWYSearTableViewController.m
//  车无忧
//
//  Created by 陈欢 on 2017/8/15.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYSearTableViewController.h"
#import <AFNetworking.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import "CWYClearCarTableViewCell.h"
#import "CWYCarMessage.h"
#import "CWYSeaMessage.h"
#import "CWYSeaTableViewCell.h"
@interface CWYSearTableViewController ()

@property (nonatomic, strong) AFHTTPSessionManager *serManager;

@property (nonatomic, strong) NSMutableArray *seaArray;



@end

@implementation CWYSearTableViewController
static NSString * const CHTopicCellId = @"topic";



- (AFHTTPSessionManager *)serManager
{
    if (!_serManager) {
        _serManager = [AFHTTPSessionManager manager];
        
    }
    
    return _serManager;
}



- (NSMutableArray *)seaArray
{
    if (!_seaArray) {
        _seaArray = [NSMutableArray array];
    }
    
    return _seaArray;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self setupNav];
    [self setupTable];
    [self setupRefresh];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadnewMessage)];
    
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    [self.tableView.mj_header beginRefreshing];
    
    //self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreMessage)];
    
    
    
}



- (void)setupTable
{
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CWYSeaTableViewCell class]) bundle:nil] forCellReuseIdentifier:CHTopicCellId];
}


- (void)setupNav
{
    self.title = @"搜索结果";
    self.view.backgroundColor = CHRGBColor(230, 230, 230);
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationButtonReturn" highImage:@"navigationButtonReturnClick" target:self action:@selector(back)];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor whiteColor]}] ;
}


- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)loadnewMessage
{
    
    id parmas = @{
                  
                  @"key":self.keyWord,
                  @"page":@(1)
                  
                  };
    
    
    
    [self.serManager POST:@"http://www.zhanyiwangluo.com/washcar/index.php/Home/HomePage/seekKey" parameters:parmas progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        self.seaArray = [CWYSeaMessage mj_objectArrayWithKeyValuesArray:responseObject[@"business"]];
        CHLog(@"%@",responseObject);
        CHLog(@"%@", self.seaArray);
        [self.tableView.mj_header endRefreshing];
        
        [self.tableView reloadData];

        
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
    return self.seaArray.count;
    //CHLog(@"%lu", (unsigned long)self.seaArray.count);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    CWYSeaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CHTopicCellId];
    
    cell.seaMessage = self.seaArray[indexPath.row];
    //CHLog(@"%@", self.seaArray);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

@end
