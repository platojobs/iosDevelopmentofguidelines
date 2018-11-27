//
//  ScheduleBLTests.m
//  BusinessLogicLayerTests
//
//  Created by 关东升 on 16/1/31.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "ScheduleBL.h"
#import <PersistenceLayer/ScheduleDAO.h>
#import <PersistenceLayer/Schedule.h>

@interface ScheduleBLTests : XCTestCase

@property (nonatomic,strong) ScheduleBL * bl;
@property (nonatomic,strong) Schedule * theSchedule;

@end

@implementation ScheduleBLTests


- (void)setUp {
    //创建ScheduleBL对象
    self.bl = [[ScheduleBL alloc] init];
    //创建Schedule对象
    self.theSchedule = [[Schedule alloc] init];
    self.theSchedule.GameDate = @"test GameDate";
    self.theSchedule.GameTime = @"test GameTime";
    self.theSchedule.GameInfo = @"test GameInfo";
    Events *event = [Events new];
    event.EventName = @"Cycling Mountain Bike";
    event.EventID = 10;
    self.theSchedule.Event = event;
    
    //插入测试数据
    ScheduleDAO *dao = [ScheduleDAO sharedInstance];
    [dao create:self.theSchedule];
}

- (void)tearDown {
    //删除测试数据
    self.theSchedule.ScheduleID = 502;
    ScheduleDAO *dao = [ScheduleDAO sharedInstance];
    [dao remove:self.theSchedule];
    
    self.bl = nil;
}

//测试 按照主键查询数据方法
-(void) testFindAll {
    
    NSMutableDictionary* dict =  [self.bl readData];
    
    NSArray  *allkey = [dict allKeys];
    
    //断言 查询记录数为1
    XCTAssertEqual([allkey count], 18);
    
    NSArray* schedules  = dict[self.theSchedule.GameDate];
    Schedule* resSchedule  = schedules[0];
    //断言
    XCTAssertEqualObjects(self.theSchedule.GameDate ,resSchedule.GameDate);
    XCTAssertEqualObjects(self.theSchedule.GameTime ,resSchedule.GameTime);
    XCTAssertEqualObjects(self.theSchedule.GameInfo ,resSchedule.GameInfo);
    XCTAssertEqual(self.theSchedule.Event.EventID ,resSchedule.Event.EventID);
    XCTAssertEqualObjects(self.theSchedule.Event.EventName ,resSchedule.Event.EventName);
    
}

@end
