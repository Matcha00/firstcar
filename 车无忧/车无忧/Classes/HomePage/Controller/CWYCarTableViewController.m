//
//  CWYCarTableViewController.m
//  车无忧
//
//  Created by 陈欢 on 2017/7/12.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYCarTableViewController.h"
#import "CWYClearCarTableViewCell.h"
#import "CWYShowMessageViewController.h"
#import <AFNetworking.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import "CWYCarMessage.h"
#import <SVProgressHUD.h>
#import "JSDropDownMenu.h"
#import "CWYLocation.h"
#import "CWYLocationx.h"
#import <objc/message.h>
@interface CWYCarTableViewController () <JSDropDownMenuDelegate,JSDropDownMenuDataSource>

{
    
    NSMutableArray *_data1;
    NSMutableArray *_data2;
    NSMutableArray *_data3;
    NSMutableArray *_data4;
    
    NSInteger _currentData1Index;
    NSInteger _currentData2Index;
    NSInteger _currentData3Index;
}

@property (nonatomic, strong) NSMutableArray *carMessages;

@property (nonatomic, strong) NSDictionary *params;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, weak) JSDropDownMenu *menu;

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, strong) NSMutableArray *chTextArray;


@property (nonatomic, strong) NSMutableArray *cityMuarray;

@end

@implementation CWYCarTableViewController



- (NSMutableArray *)cityMuarray
{
    if (!_cityMuarray) {
        _cityMuarray = [NSMutableArray array];
    }
    
    return _cityMuarray;
}

- (NSMutableArray *)carMessages
{
    if (!_carMessages) {
        _carMessages = [NSMutableArray array];
    }
    
    return _carMessages;
}

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    
    return _manager;
}


- (NSMutableArray *)chTextArray
{
    if (!_chTextArray) {
        _chTextArray = [NSMutableArray array];
    }
    
    return _chTextArray;
}

- (void)viewDidLoad {
    
    
    
    [super viewDidLoad];
    
    
   // CHLog(@"城市%@,%@,%@",chCity,chlatitude,chlongitude);
    
   //self.presentedViewController.
    
    //self.tableView.tableHeaderView = testView;
    _data1 = [NSMutableArray arrayWithObjects:@"依兰县",@"方正县",@"宾县",@"巴彦县",@"木兰县"	,@"通河县",@"延寿县"	,@"阿城市", @"双城市",@"尚志市",@"五常市",@"道里区",@"南岗区",@"道外区",@"香坊区",@"动力区",@"平房区",@"松北区",@"呼兰区",nil];
    _data2 = [NSMutableArray arrayWithObjects:@"价格", @"销量", @"距离",  nil];
    
    _data4 = [NSMutableArray arrayWithObjects:@"230123",@"230124",@"230125",@"230126",@"230127",@"230128",@"230129",@"230181",@"230182",@"230183",@"230184",@"230102",@"230103",@"230104",@"230106",@"230107",@"230108",@"230109",@"230111", nil];
    
    
    //,@"230125",@"230126",@"230127",@"230128",@"230129",@"230181",@"230182",@"230183",@"230184",@"230102",@"230103",@"230104",@"230106",@"230107",@"230108",@"230109",@"230111",nil
    
       //NSInteger longCh = self.chTextArray.count;
        
   // _data1 = self.chTextArray;
    
    [self setupTable];
    [self setupRefresh];
    CHLog(@"%@", self.cityMuarray);

//    CWYLocationx *hhh = [[CWYLocationx alloc]init];
//    
//    hhh = self.chTextArray;
//    
//    CHLog(@"%@",hhh.title);

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}


- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadnewMessage)];
    
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreMessage)];
    
    
   
}




- (void)loadnewMessage
{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    
    NSString   *chCity = [user stringForKey:@"city"];
    
    NSString *chlatitude = [user stringForKey:@"latitude"];
    
    NSString *chlongitude = [user stringForKey:@"longitude"];

    CHLog(@"7777777%ld",(long)_currentData2Index);
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"page"] = @(1);
    params[@"type"] = @(self.type);
    params[@"city"] = chCity;
    params[@"sort_type"] = @(_currentData2Index);
    params[@"longitude"] = [user stringForKey:@"longitude"];
    params[@"latitude"] = [user stringForKey:@"latitude"];
    self.params = params;
    
    [[AFHTTPSessionManager manager] POST:@"http://www.zhanyiwangluo.com/washcar/index.php/Home/HomePage/index/" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (self.params != params) return ;
        
        self.carMessages = [CWYCarMessage mj_objectArrayWithKeyValuesArray:responseObject[@"business"]];
        
        
        self.chTextArray = [CWYLocationx mj_objectArrayWithKeyValuesArray:responseObject[@"areaData"]];
        
        
       // _data1 =cHTextArray;
        
        
       /// NSMutableDictionary *dic = [NSMutableDictionary mj_keyValuesArrayWithObjectArray:self.chTextArray];
      
        NSMutableArray *cunchu = [NSMutableArray array];
        
        CWYLocationx *test = [[CWYLocationx alloc]init];
        

        for (NSInteger i = 0; i<self.chTextArray.count; i++) {
            test = self.chTextArray[i];
            NSString *city = test.ID;
            
            [cunchu addObject:city];
        }
        
        //CHLog(@"%@", responseObject);
        
        self.cityMuarray = cunchu;
        
        
        
        //CHLog(@"%@", self.cityMuarray);
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
        
        
        self.page = 1;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        if (self.params != params) return ;
        
        [self.tableView.mj_header endRefreshing];
        
        [SVProgressHUD showErrorWithStatus:@"网络链接失败！！！！"];
        
        NSLog(@"%@",error);
        
    }];
}



- (void)loadMoreMessage
{
    [self.tableView.mj_header endRefreshing];
    
    self.page ++;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSInteger page = self.page + 1;
    
    params[@"page"] = @(self.page);
    
    self.params = params;
    
    
    [self.manager GET:@"http://www.zhanyiwangluo.com/washcar/index.php/Home/HomePage/index/page/1/type/0" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (self.params != params)  return ;
        
        NSArray *newCarMessage = [CWYCarMessage mj_objectArrayWithKeyValuesArray:responseObject[@"business"]];
        
        [self.carMessages addObjectsFromArray:newCarMessage];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
        
        self.page = page;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.params != params) return ;
        
        [self.tableView.mj_footer endRefreshing];
        
        self.page--;
    }];
    
    
}


//- (void)chooseRef:(NSInteger *)cityName choosePay:(NSInteger *)choosePay
//{
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadChooseMessage:choosePay:)];
//    
//    NSString *chHuan = @"sssss";
//    
//     objc_setAssociatedObject(self.tableView.mj_header, @"tickBtn", chHuan, OBJC_ASSOCIATION_ASSIGN);
//}
//
//- (void)loadChooseMessage:(NSInteger *)cityName  choosePay:(NSInteger *)choosePay
//{
//    CHLog(@"%f",cityName);
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    // Dispose of any resources that can be recreated.
}



//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *testView = [[UIView alloc]initWithFrame:CGRectMake(20, 100, CHScreenW, 100)];
//    
//    testView.backgroundColor = [UIColor redColor];
//    
//    return  testView;
//}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 35;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   
    JSDropDownMenu *menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 20) andHeight:45];
    menu.indicatorColor = [UIColor colorWithRed:175.0f/255.0f green:175.0f/255.0f blue:175.0f/255.0f alpha:1.0];
    menu.separatorColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0];
    menu.textColor = [UIColor colorWithRed:83.f/255.0f green:83.f/255.0f blue:83.f/255.0f alpha:1.0f];
    menu.dataSource = self;
    menu.delegate = self;
    self.menu = menu;
    //[self.view addSubview:menu];
    
    
    
    return menu;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStylePlain];
}


#pragma mark - Table view data source
static NSString * const CHTopicCellId = @"topic";
- (void)setupTable
{
    
    
    CGFloat bottom = self.tabBarController.tabBar.height;
        self.tableView.contentInset = UIEdgeInsetsMake(0.5 * CHScreenW + 40 + 62 + 43, 0, bottom, 0);
    
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];


    
     [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CWYClearCarTableViewCell class]) bundle:nil] forCellReuseIdentifier:CHTopicCellId];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    
    self.tableView.mj_footer.hidden = (self.carMessages.count == 0);
    
    return self.carMessages.count;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CWYClearCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CHTopicCellId];
    
    cell.carMessage = self.carMessages[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CWYShowMessageViewController *showVc = [[CWYShowMessageViewController alloc]init];
    showVc.carMessage = self.carMessages[indexPath.row];
    [self.navigationController pushViewController:showVc animated:YES];
    
    
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

- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu {
    
    return 2;
}

-(BOOL)displayByCollectionViewInColumn:(NSInteger)column{
    
    //    if (column==2) {
    //
    //        return YES;
    //    }
    
    return NO;
}

-(BOOL)haveRightTableViewInColumn:(NSInteger)column{
    
    //    if (column==0) {
    //        return YES;
    //    }
    return NO;
}

-(CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    
    //    if (column==0) {
    //        return 0.3;
    //    }
    
    return 1;
}

//-(NSInteger)currentLeftSelectedRow:(NSInteger)column{
//
//    if (column==0) {
//
//        return _currentData1Index;
//
//    }
//    if (column==1) {
//
//        return _currentData2Index;
//    }
//
//    return 0;
//}

- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
    
    if (column==0) {
        
        return _data1.count;
        //        if (leftOrRight==0) {
        //
        //            return _data1.count;
        //        } else{
        //
        //            NSDictionary *menuDic = [_data1 objectAtIndex:leftRow];
        //            return [[menuDic objectForKey:@"data"] count];
        //        }
    } else if (column==1){
        
        return _data2.count;
        
    }
    
    return 0;
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    
    NSString   *cuuuuu = [user stringForKey:@"currentData2Index"];
    
    NSInteger  hhh = [cuuuuu integerValue];
    
    NSString   *cuuuu = [user stringForKey:@"currentData1Index"];
    
    NSInteger  hh = [cuuuu integerValue];
    
//    CWYLocationx *test = [[CWYLocationx alloc]init];
//    
//    test = self.chTextArray[hh];
    
    
    switch (column) {
        case 0: return _data1[hh];
            break;
        case 1: return _data2[hhh];
            break;
        case 2:return _data2[0];// _data3[0];
            break;
        default:
            return nil;
            break;
    }
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath {
    
    
    
    
    if (indexPath.column==0) {
        
        return _data1[indexPath.row];
        //        if (indexPath.leftOrRight==0) {
        //            NSDictionary *menuDic = [_data1 objectAtIndex:indexPath.row];
        //            return [menuDic objectForKey:@"title"];
        //        } else{
        //            NSInteger leftRow = indexPath.leftRow;
        //            NSDictionary *menuDic = [_data1 objectAtIndex:leftRow];
        //            return [[menuDic objectForKey:@"data"] objectAtIndex:indexPath.row];
        //}
        
        //CHLog(@"%@",self.chTextArray[indexPath.row]);
        
    } else if (indexPath.column==1) {
        //NSLog(@"22222222222222222%ld",_currentData2Index);
       

        return _data2[indexPath.row];
        
    } else {
        
        return  _data2[indexPath.row];  // _data3[indexPath.row];
    }
}

- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
    NSUserDefaults *userDe = [NSUserDefaults standardUserDefaults];
    
    if (indexPath.column == 0) {
        
        //        if(indexPath.leftOrRight==0){
        //
        //            _currentData1Index = indexPath.row;
        //
        //            return;
        //        }
        _currentData1Index = indexPath.row;
        [userDe setObject:@(_currentData1Index) forKey:@"currentData1Index"];
        [userDe synchronize];
        [self setupChoose];
        
    } else if(indexPath.column == 1){
        
        _currentData2Index = indexPath.row;
        
        //CHLog(@"eeeee%ld",(long)_currentData2Index);
         //[self loadnewMessage];
//        [self chooseRef:&(_currentData1Index) choosePay:&(_currentData2Index)];
        NSUserDefaults *userDe = [NSUserDefaults standardUserDefaults];
        
        [userDe setObject:@(_currentData2Index) forKey:@"currentData2Index"];
        [userDe synchronize];
        [self setupChoose];
       
    } else{
        
        _currentData2Index = indexPath.row;//_currentData3Index = indexPath.row;
    }
}

- (void)setupChoose
{
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    
//    
//    NSString   *chCity = [user stringForKey:@"city"];
//    
//    NSString *chlatitude = [user stringForKey:@"latitude"];
//    
//    NSString *chlongitude = [user stringForKey:@"longitude"];
//    
//    
//    
   //NSInteger showin = _currentData1Index;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    
    NSString   *cuuuuu = [user stringForKey:@"currentData2Index"];
    
    NSInteger  hhh = [cuuuuu integerValue];
    
    NSString   *cuuuu = [user stringForKey:@"currentData1Index"];
    
    NSInteger  hh = [cuuuu integerValue];
    
    CHLog(@"qqqqqq%ld",(long)hhh);
    
   // CHLog(@"yyyyyyyyyyy%ld",(long)showin);
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    param[@"page"] = @(1);
    param[@"type"] = @(self.type);
    param[@"careid"] = _data4[hh];
    param[@"sort_type"] = @(hhh);
    param[@"longitude"] = [user stringForKey:@"longitude"];
    param[@"latitude"] = [user stringForKey:@"latitude"];
    //self.params = params;
    
    [[AFHTTPSessionManager manager] POST:@"http://www.zhanyiwangluo.com/washcar/index.php/Home/HomePage/condition_index" parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
        
        self.carMessages = [CWYCarMessage mj_objectArrayWithKeyValuesArray:responseObject[@"business"]];
        
        self.chTextArray = [CWYLocationx mj_objectArrayWithKeyValuesArray:responseObject[@"areaData"]];
        
        
        [self.tableView reloadData];
        CHLog(@"%@",responseObject);
       
        CHLog(@"%ld",(long)_currentData2Index);
        self.page = 0;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        //if (self.params != params) return ;
        
        //[self.tableView.mj_header endRefreshing];
        
        [SVProgressHUD showErrorWithStatus:@"网络链接失败！！！！"];
        
        
        [self.tableView reloadData];
        
        //NSLog(@"%@",error);
        
    }];

}

- (void)dealloc
{
    [self.manager.operationQueue cancelAllOperations];
    
    [SVProgressHUD dismiss];
}
@end
