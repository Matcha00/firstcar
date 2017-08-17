//
//  CWYGpsView.m
//  车无忧
//
//  Created by 陈欢 on 2017/7/19.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CWYGpsView.h"
#import "CWYBusinessMinute.h"
#import "TYMapNavSheet.h"


@interface CWYGpsView() <UIActionSheetDelegate>





//@property (weak, nonatomic) IBOutlet UILabel *addressLable;

@end

@implementation CWYGpsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


//- (IBAction)showMap {
//    
//    
//    NSLog(@"%@",@"123456789");
//    
//    NSMutableDictionary * Dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"起点",@"startName",@"终点",@"endName", nil];
//    [TYNavSheet ShowMapNavSheetSuperView: withLocationDic:Dic withstartCoor:CLLocationCoordinate2DMake(31.205511, 121.595181) withendCoor:CLLocationCoordinate2DMake(31.209511, 121.597181)];
//    
//
//    
//    
//    //NSLog(@"%@jjjjjjjjj");
//}
//
//
//- (IBAction)showMapTest:(id)sender {
//    
//    
//}



+ (instancetype)gpsView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}



- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
}


- (void)setBusinessMinute:(CWYBusinessMinute *)businessMinute
{
    _businessMinute = businessMinute;
    
    self.addressLable.text = businessMinute.address;
}

@end
