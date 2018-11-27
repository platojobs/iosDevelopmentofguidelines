//
//  CountDownViewController.m
//  RioOlympics2016
//
//  Created by 关东升 on 16/2/2.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

#import "CountDownViewController.h"

@interface CountDownViewController ()
//显示倒计时
@property (weak, nonatomic) IBOutlet UILabel *lblCountDown;
@end

@implementation CountDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建NSDateComponents对象
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    //设置NSDateComponents日期
    [comps setDay:5];
    //设置NSDateComponents月
    [comps setMonth:8];
    //设置NSDateComponents年
    [comps setYear:2016];
    //创建日历对象
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //获得2016-8-5日的NSDate日期对象
    NSDate *destinationDate = [calender dateFromComponents:comps];
    //获得当前日期到2016-8-5时间的NSDateComponents对象
    NSDateComponents *components = [calender components:NSCalendarUnitDay fromDate:[NSDate date] toDate:destinationDate options:NSCalendarWrapComponents];
    //获得当前日期到2016-8-5相差的天数
    NSInteger days = [components day];

    NSMutableAttributedString *strLabel = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%i天",days]];
    
    [strLabel addAttribute:NSFontAttributeName
            value:[UIFont preferredFontForTextStyle:UIFontTextStyleFootnote]
            range:NSMakeRange(strLabel.length - 1, 1)];
    
    self.lblCountDown.attributedText = strLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
