//
//  CWYChoosePayViewController.m
//  车无忧
//
//  Created by 陈欢 on 2017/7/19.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYChoosePayViewController.h"
#import "CWYTypeTableViewCell.h"
#import "CWYServicesTableViewCell.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import "CWYTypeTable.h"
#import "CWYServe.h"


#define CHSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]


@interface CWYChoosePayViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *serviceArray;
@property (nonatomic, strong) NSArray *typeArray;
@property (weak, nonatomic) IBOutlet UITableView *serviceTableView;
@property (weak, nonatomic) IBOutlet UITableView *typeTableView;
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation CWYChoosePayViewController


static  NSString * const CHServiceId = @"service";
static NSString * const CHTypeId = @"type";


- (NSArray *)serviceArray
{
    if (!_serviceArray) {
        //NSArray *array =
        
        //NSArray *array = [NSArray array];
        
        _serviceArray = [NSArray array];
    }
    
    return _serviceArray;
}


//- (NSMutableArray *)typeArray
//{
//    if (!_typeArray) {
//       
//        
//        _typeArray = [NSMutableArray array];
//    }
//    
//    return _typeArray;
//}


- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        
    }
    return _manager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.serviceArray = @[@"汽车服务",@"汽车美容",@"汽车保养",@"汽车维修"];
    self.typeArray = @[@"汽车服务",@"汽车美容",@"汽车保养",@"汽车维修"];
    self.view.backgroundColor = [UIColor blueColor];
    
   // [self setupTableView];
    
    //[self loadCategories];
    
    // Do any additional setup after loading the view from its nib.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setupTableView
{
    [self.serviceTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UITableViewCell class]) bundle:nil] forCellReuseIdentifier:CHServiceId];
    
    [self.typeTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CWYTypeTableViewCell class]) bundle:nil] forCellReuseIdentifier:CHTypeId];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.serviceTableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    
    self.typeTableView.contentInset =  self.serviceTableView.contentInset;
    
    self.typeTableView.rowHeight = 40;
    
    self.serviceTableView.rowHeight = 40;
    
    self.typeTableView.dataSource = self;
    self.typeTableView.delegate = self;
    self.serviceTableView.delegate = self;
    self.serviceTableView.dataSource = self;
    
//    [self.serviceTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
}



- (void)setupRefresh
{
    self.typeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    
    self.typeTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    
    self.typeTableView.mj_footer.hidden = YES;
    
    
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (tableView == self.serviceTableView) {
//        [self setupRefresh];
//    }
//}

- (void)loadNewUsers
{
//    CWYTypeTable *rc = self.serviceArray[self.serviceTableView.indexPathForSelectedRow.row] ;
//    rc.currentPage = 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //params[@"category_id"] = @(rc.id);
    //params[@"page"] = @(rc.currentPage);
    self.params = params;
    
    [self.manager POST:@"http://www.zhanyiwangluo.com/washcar/index.php/Home/Business/index" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *users = [CWYServe mj_objectArrayWithKeyValuesArray:responseObject[@"serve"]];
        // NSArray *users = [CHRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        
//        [rc.users removeAllObjects];
//        
//        // CHLog(@"%@", users);
//        [rc.users addObjectsFromArray:users];
//        //CHLog(@"%@", rc.users);
//        
//        rc.total = [responseObject[@"total"] integerValue];
        
        
        if (self.params != params) return;
        
        
        [self.typeTableView reloadData];
        
        
        [self.typeTableView.mj_header endRefreshing];
        
        
        //[self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.params != params) return ;
        
        [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
        
        [self.typeTableView.mj_header endRefreshing];
        
    }];
    
}
//
//- (void)loadMoreUsers
//{
//    CHRecommendCategory *category = CHSelectedCategory;
//    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"a"] = @"list";
//    params[@"c"] = @"subscribe";
//    params[@"category_id"] = @(category.id);
//    params[@"page"] = @(++category.currentPage);
//    self.params = params;
//    
//    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        NSArray *users = [CHRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
//        
//        [category.users addObjectsFromArray:users];
//        
//        
//        if (self.params != params) return ;
//        [self.userTableView reloadData];
//        
//        [self checkFooterState];
//        
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (self.params != params) return ;
//        
//        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
//        
//        [self.userTableView.mj_footer endRefreshing];
//        
//        
//    }];
//}
//
//- (void)checkFooterState
//{
//    CHRecommendCategory *rc = CHSelectedCategory;
//    
//    self.userTableView.mj_footer.hidden = (rc.users.count == 0);
//    
//    
//    if (rc.users.count == rc.total) {
//        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
//    }else {
//        [self.userTableView.mj_footer endRefreshing];
//    }
//    
//}
//
//
//
//- (void)loadCategories
//{
//    [SVProgressHUD showWithStatus:@"正在加载。。。。"];
//    
//    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
//    parmas[@"a"] = @"category";
//    parmas[@"c"] = @"subscribe";
//    
////    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parmas progress:^(NSProgress * _Nonnull downloadProgress) {
////        
////    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
////        [SVProgressHUD dismiss];
////        self.categories = [CHRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
////        
////        // 刷新表格
////        [self.categoryTableView reloadData];
////        
////        // 默认选中首行
//        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [SVProgressHUD showErrorWithStatus:@"加载失败请稍后"];
//    }];
//}



//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//numberOfRowsInSection
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (tableView == self.serviceTableView) {
        return self.serviceArray.count;
    }
    
    return self.typeArray.count ;
}


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//
//{
//    if (tableView == self.serviceTableView) {
////        CWYServicesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CHServiceId];
////        cell.typeLable= self.serviceArray[indexPath.row];
////        
////        NSLog(@"++++++++++++++%@",self.serviceArray);
//        
////        UITableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"cellID"];
////        
////        if (!cell) {
////            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
////        }
////        
////        
////        return cell;
//       
//    }else {
//        
//        
//        CWYTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CHTypeId];
//        
//        return cell;
//        
//    }

    
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell;
    
    
    if (tableView == self.serviceTableView) {
        
//        cell = [tableView dequeueReusableCellWithIdentifier:CHServiceId forIndexPath:indexPath];
//        cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
        
        CWYServicesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CHServiceId];
        cell.typeLable = self.serviceArray[indexPath.row];
        
        // 右边的 view
    } else {
        
        CWYTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CHTypeId];
        
        cell.server = self.typeArray[indexPath.row];
    }
    
    return cell;
    
    }
    
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.serviceTableView) {
        
        NSInteger  tableId =  self.serviceTableView.indexPathForSelectedRow.row;
        
        
        
    }
}

    





@end
