//
//  CWYTestChooseViewController.m
//  车无忧
//
//  Created by 陈欢 on 2017/8/3.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYTestChooseViewController.h"

@interface CWYTestChooseViewController () <UITabBarDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *firstChooseTable;
@property (weak, nonatomic) IBOutlet UITableView *secondChoosetable;

@property (strong, nonatomic) NSArray *leftArray;
@property (strong, nonatomic) NSArray *rightArray;


@end

@implementation CWYTestChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    self.leftArray = @[@"iiii",@"iiii",@"iiii",@"iiii",@"iiii",@"iiii",@"iiii",@"iiii"];
    self.rightArray = @[@"iii",@"iii",@"iii",@"iii",@"iii",@"iii",@"iii",@"iii"];
    
    // Do any additional setup after loading the view from its nib.
}




- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (tableView == self.firstChooseTable) {
        return self.leftArray.count;
    } else {
        return self.rightArray.count;
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    //UITableViewCell *cell;
    
    if (tableView == self.firstChooseTable) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftID"];
        
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftID"];
        }
        
        cell.textLabel.text = self.leftArray[indexPath.row];
        return cell;
    } else
    {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rightID"];
        
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"rightID"];
        }
        //cell = [tableView ];
        
        cell.textLabel.text = self.rightArray[indexPath.row];
        
        return cell;
    }
}

















@end
