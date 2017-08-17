//
//  CWYPersonTableViewController.m
//  车无忧
//
//  Created by 陈欢 on 2017/7/16.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYPersonTableViewController.h"
#import <Masonry.h>
#import "CWYRecordsTableViewController.h"
#import "CWYfeedBackViewController.h"
#import "CWYMatrixCodeViewController.h"
#import "CWYSettingViewController.h"
#import "CWYWallerViewController.h"
#import "CWYLoginViewController.h"
#import "CWYBuyMessageTableViewController.h"
#import "CHVerticalButton.h"
#import <AFNetworking.h>
#import "CWYUserMessage.h"
#import <YYModel.h>
#import "TestTableViewController.h"
#import "CWYFavTableViewController.h"
#import "CWYTjPeopleTableViewController.h"
#import "CHPostWordViewController.h"
#import "CWYFkViewController.h"
@interface CWYPersonTableViewController ()


@property (nonatomic, weak) UIView *tableViewHeader;

@property (nonatomic,weak) UIButton *headerImage;

@property (nonatomic,weak) UIButton *settingButton;

@property (nonatomic, weak) UILabel *showMessageLable;

@property (nonatomic, weak) CHVerticalButton *cardPackage;

@property (nonatomic, weak) CHVerticalButton *walletButton;

@property (nonatomic, weak) UIButton *callPhoneBtn;

@property (nonatomic, strong) AFHTTPSessionManager *manger;

@property (nonatomic, strong) CWYUserMessage *user;

@end

@implementation CWYPersonTableViewController

- (AFHTTPSessionManager *)manger
{
    if (!_manger) {
        _manger = [AFHTTPSessionManager manager];
    }
    
    return _manger;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.view.backgroundColor = [UIColor blueColor];
    [self setupTableViewHeaderView];

    //[self setupUser];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSString *userName = [user stringForKey:@"username"];
    
    NSString *showUser = @"欢迎您，用户:";
    
            //NSString *showUesrPhone = self.user.phone;
    
    NSString  *doubleString = [showUser stringByAppendingString:userName];
    self.showMessageLable.text = doubleString;
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.backgroundColor = CHRGBColor(247, 247, 247);
    self.hidesBottomBarWhenPushed = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    
    if (section == 0) {
        return 4;
    }else
    {
        return 2;
    }
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@forIndexPath:indexPath];
    
    UITableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"cellID"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"我的消费记录";
            cell.imageView.image = [UIImage imageNamed:@"buy"];
        }else if (indexPath.row == 1)
        {
            cell.textLabel.text = @"我的二维码";
            cell.imageView.image = [UIImage imageNamed:@"ma"];
        }else if (indexPath.row == 2)
        {
            cell.textLabel.text = @"我的推荐";
            cell.imageView.image = [UIImage imageNamed:@"wodefx"];
            //UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, CHScreenW, 44)];
            
            //[cell.contentView addSubview:btn];
            
            //[btn addTarget:self action:@selector(notComment) forControlEvents:UIControlEventTouchUpInside];
        }else if(indexPath.row == 3)
        {
            cell.textLabel.text = @"我的收藏";
            cell.imageView.image = [UIImage imageNamed:@"wodesc"];
            
        }
    } else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"联系客服";
            cell.imageView.image = [UIImage imageNamed:@"kf"];
            
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, CHScreenW, 44)];
            
            btn.titleLabel.text = @"87703737";
            
            [cell.contentView addSubview:btn];
            
            self.callPhoneBtn = btn;
            
            [btn addTarget:self action:@selector(callPhone) forControlEvents:UIControlEventTouchUpInside];
        }else if (indexPath.row == 1)
        {
            cell.textLabel.text = @"意见反馈";
            cell.imageView.image = [UIImage imageNamed:@"yj"];
        }
    }
   
//    cell.textLabel.text = @"hhhhh";
//    cell.imageView.image = [UIImage imageNamed:@"tabBar_essence_click_icon"];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}


//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//
//    return 30;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}

- (void)setupTableViewHeaderView
{
   
    
    __weak typeof(self) weakSelf = self;
    
    UIView *headerView = [[UIView alloc]init];
    headerView.frame = CGRectMake(0, 0, CHScreenH, 200);
    headerView.backgroundColor = CHRGBColor(250, 48, 48);
    self.tableViewHeader = headerView;
    self.tableView.tableHeaderView = headerView;
    
    UIButton *headImage = [[UIButton alloc]init];
    //headImage.backgroundColor = [UIColor blackColor];
    [headerView addSubview:headImage];
    [headImage setImage:[UIImage imageNamed:@"touxiang"] forState:UIControlStateNormal];
    headImage.titleLabel.text = @"nihaioapa";
    headImage.layer.cornerRadius = 3;
    headImage.layer.masksToBounds = YES;
    self.headerImage = headImage;
    
    [self.headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(60, 60));
        
        make.top.mas_equalTo(40);
        
        make.centerX.equalTo(weakSelf.view);
        
    }];
    
    
    UIButton *setting = [[UIButton alloc]init];
    //setting.backgroundColor = [UIColor blackColor];
    self.settingButton = setting;
    //setting.titleLabel.text = @"16536636363";
    [setting addTarget:self action:@selector(settingBtn) forControlEvents:UIControlEventTouchUpInside];
    [setting setImage:[UIImage imageNamed:@"seting"] forState:UIControlStateNormal];
    [headerView addSubview:setting];
    
    [self.settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.top.mas_equalTo(10);
       // make.left.mas_equalTo(self.headerImage.mas_left).offset(-20);
        
    }];
    
    UILabel *showMessage  = [[UILabel alloc]init];
    //showMessage.text = @"用户名：123345566777";
    showMessage.textAlignment = NSTextAlignmentCenter;
    showMessage.textColor = [UIColor whiteColor];
    // showMessage.backgroundColor = [UIColor blackColor];
    [showMessage setFont:[UIFont systemFontOfSize:14]];
    self.showMessageLable = showMessage;
    
    [headerView addSubview:showMessage];
    
    [self.showMessageLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(CHScreenW, 44));
        //make.centerX.equalTo(weakSelf.headerImage);
        make.top.mas_equalTo(self.headerImage.mas_bottom).offset(0);
    }];
    
    
    CHVerticalButton *cardPackage = [[CHVerticalButton alloc]init];
    //cardPackage.backgroundColor = [UIColor blackColor];
    self.cardPackage = cardPackage;
    [cardPackage setImage:[UIImage imageNamed:@"card"] forState:UIControlStateNormal];
    [cardPackage setTitle:@"卡包" forState:UIControlStateNormal];
    cardPackage.titleLabel.font = [UIFont systemFontOfSize:14];
    [cardPackage.titleLabel sizeToFit];
    [headerView addSubview:cardPackage];
    
    [self.cardPackage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 50));
        
        make.left.mas_equalTo(120);
        make.top.mas_equalTo(self.showMessageLable).offset(50);
        
        
        
    }];
    
    
    
    [cardPackage addTarget:self action:@selector(notComment) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    
    CHVerticalButton *wallet  = [[CHVerticalButton alloc]init];
    //wallet.backgroundColor = [UIColor blackColor];
    self.walletButton = wallet;
    //[wallet addTarget:self action:@selector(wallerPay) forControlEvents:UIControlEventTouchUpInside];
    [wallet addTarget:self action:@selector(walletPay) forControlEvents:UIControlEventTouchUpInside];
    [wallet setImage:[UIImage imageNamed:@"money"] forState:UIControlStateNormal];
    [wallet setTitle:@"钱包" forState:UIControlStateNormal];
    //[wallet setImageEdgeInsets:UIEdgeInsetsMake(0, 0, -100, 0.0)];
    //[wallet setTitle:@"ddddddddddddd" forState:UIControlStateNormal];
    wallet.titleLabel.font = [UIFont systemFontOfSize:14];
    [wallet.titleLabel sizeToFit];
    [headerView addSubview:wallet];
    
    [self.walletButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 50));
        
        make.top.mas_equalTo(self.showMessageLable).offset(50);
        
        make.right.mas_equalTo(-120);
    }];
    
    self.tableView.tableFooterView = [[UIView alloc] init]; 
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0) {
//        if (indexPath.row == 0) {
//            CWYRecordsTableViewController *vc = [[CWYRecordsTableViewController alloc]init];
//            
//            [self.navigationController pushViewController:vc animated:YES];
//        }else if (indexPath.row == 1)
//        {
//           //    }else if(indexPath.section == 1)
//    {
//        if (indexPath.row == 1) {
//            CWYfeedBackViewController *vc = [[CWYfeedBackViewController alloc]init];
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//    }
//    
//    
//    }
    
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //CWYRecordsTableViewController *vc = [[CWYRecordsTableViewController alloc]init];
            
            //CWYBuyMessageTableViewController *vc = [[CWYBuyMessageTableViewController alloc]init];
            
            TestTableViewController *vc = [[TestTableViewController alloc]init];
            
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1)
        {
            CWYMatrixCodeViewController *vc = [[CWYMatrixCodeViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];

        }else if (indexPath.row == 2)
        {
            
            CWYTjPeopleTableViewController *vc = [[CWYTjPeopleTableViewController alloc]init];
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.row == 3)
        {
            CWYFavTableViewController *vc = [[CWYFavTableViewController alloc]init];
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        
        }else if (indexPath.section == 1)
   {
        if (indexPath.row == 0) {
            
            
        if (indexPath.row == 0) {
                
                
                
                
                
            }
            
            
    }else if (indexPath.row == 1)
        {
            CWYFkViewController *vc = [[CWYFkViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];

        }

}
    
    
}





- (void)callPhone
{
    NSString *ph1 = @"tel:";
    
    NSString  *phone = [ph1 stringByAppendingString:@"123456789"];
    UIAlertController *alertControler = [UIAlertController alertControllerWithTitle:@"拨号" message:@"87703737" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        return ;
    }];
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
//        
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone] options:@{} completionHandler:nil];
    }];
    [alertControler addAction:noAction];
    [alertControler addAction:yesAction];
    [self presentViewController:alertControler animated:YES completion:nil];
    
   }


- (void)notComment
{
    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"敬请期待" message:@"谢谢理解" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        return ;
    }];
    
    [alertCon addAction:noAction];
    [self presentViewController:alertCon animated:YES completion:nil];
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


//-(void)callPhoneStr:(NSString*)phoneStr  {
//    NSString *str2 = [[UIDevice currentDevice] systemVersion];
//    
//    if ([str2 compare:@"10.2" options:NSNumericSearch] == NSOrderedDescending || [str2 compare:@"10.2" options:NSNumericSearch] == NSOrderedSame)
//    {
//        NSLog(@">=10.2");
//        NSString* PhoneStr = [NSString stringWithFormat:@"tel://%@",phoneStr];
//        if ([PhoneStr hasPrefix:@"sms:"] || [PhoneStr hasPrefix:@"tel:"]) {
//            UIApplication * app = [UIApplication sharedApplication];
//            if ([app canOpenURL:[NSURL URLWithString:PhoneStr]]) {
//                [app openURL:[NSURL URLWithString:PhoneStr ] options:@{} completionHandler:nil                                                                                ];
//                
//            }
//        }
//    }else {
//        NSMutableString* str1 = [[NSMutableString alloc]initWithString:phoneStr];// 存在堆区，可变字符串
//        
//        NSString * str = [NSString stringWithFormat:@"是否拨打电话\n%@",str1];
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:str message: nil preferredStyle:UIAlertControllerStyleAlert];
//        
//        [alert addAction:[UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
//            NSLog(@"点击了呼叫按钮10.2下");
//            NSString* PhoneStr = [NSString stringWithFormat:@"tel://%@",phoneStr];
//            if ([PhoneStr hasPrefix:@"sms:"] || [PhoneStr hasPrefix:@"tel:"]) {
//                UIApplication * app = [UIApplication sharedApplication];
//                if ([app canOpenURL:[NSURL URLWithString:PhoneStr]]) {
//                    [app UIApplication:[NSURL URLWithString:PhoneStr]];
//                }
//            }
//        }]];
//        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//            NSLog(@"点击了取消按钮");
//        }]];
//        [self presentViewController:alert animated:YES completion:nil];
//    }
//    
//}

- (void)settingBtn
{

//    CWYSettingViewController *settingVc  = [[CWYSettingViewController alloc]init];
//    
//    [self.navigationController pushViewController:settingVc animated:YES];
    
    
    UIStoryboard *testStor = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    
    CWYSettingViewController *vc = [testStor instantiateViewControllerWithIdentifier:@"CWYSettingViewController"];
    
    
    [self.navigationController pushViewController:vc  animated:YES];
}


- (void)testView
{
    UIStoryboard *loginStory = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    
    CWYLoginViewController *loginVc = [loginStory instantiateViewControllerWithIdentifier:@"CWYLoginViewController"];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVc];
    
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)walletPay
{
//    UIStoryboard *wallerVc = [UIStoryboard storyboardWithName:@"Wallet" bundle:nil];
//    
//    CWYWallerViewController *wallerCon = [wallerVc instantiateViewControllerWithIdentifier:@"CWYWallerViewController"];
//    [self.navigationController pushViewController:wallerCon animated:YES];
    
    UIStoryboard *testStor = [UIStoryboard storyboardWithName:@"Wallet" bundle:nil];
    
   CWYWallerViewController *vc = [testStor instantiateViewControllerWithIdentifier:@"CWYWallerViewController"];
    //jjj
    //vc.user = self.user;
    
    [self.navigationController pushViewController:vc  animated:YES];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    
    
    //NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSString *userLogin =  [user stringForKey:@"uid"];
    
    if (userLogin == nil) {
        
        UIStoryboard *loginStory = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        
        CWYLoginViewController *loginVc = [loginStory instantiateViewControllerWithIdentifier:@"CWYLoginViewController"];
        
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVc];
        //[((UINavigationController *)tabBarController.selectedViewController) presentViewController:nav animated:YES completion:nil];
        //[self presentedViewController:nav animated:YES compl];
        
        [self.navigationController presentViewController:nav animated:YES completion:nil];
        
        [self setupUser];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}


- (void)setupUser
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSString *userLogin =  [user stringForKey:@"uid"];
    
    if (userLogin == nil) {
        
        UIStoryboard *loginStory = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        
        CWYLoginViewController *loginVc = [loginStory instantiateViewControllerWithIdentifier:@"CWYLoginViewController"];
        
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVc];
        //[((UINavigationController *)tabBarController.selectedViewController) presentViewController:nav animated:YES completion:nil];
        //[self presentedViewController:nav animated:YES compl];
        
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    } else
    {
        
   
    
    
    params[@"uid"] = [user stringForKey:@"uid"];
   
    
    [self.manger POST:@"http://www.zhanyiwangluo.com/washcar/index.php/Home/Personage/index" parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"");
        
        //CWYUserMessage *user = [[CWYUserMessage alloc] init];
        
        self.user = [CWYUserMessage yy_modelWithDictionary:responseObject[@"user"]];
        
        
//        NSString *showUser = @"欢迎您，用户:";
//        
//        NSString *showUesrPhone = self.user.phone;
//        
//        NSString  *doubleString = [showUser stringByAppendingString:showUesrPhone];
//        self.showMessageLable.text = doubleString;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
        
    }
    
}
- (void)dealloc
{
    [self.manger.operationQueue cancelAllOperations];
    
    //[SVProgressHUD dismiss];
}

//- (void)viewWillAppear:(BOOL)animated {
//    //[self.navigationController setNavigationBarHidden:YES animated:animated];
//    //[self setupAfn];
//    
//    //[self setuoLocation];
//
//}


@end
