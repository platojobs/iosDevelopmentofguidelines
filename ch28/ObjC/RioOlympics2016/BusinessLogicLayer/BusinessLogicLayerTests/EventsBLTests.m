//
//  EventsBLTests.m
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

#import "EventsBL.h"
#import <PersistenceLayer/EventsDAO.h>
#import <PersistenceLayer/Events.h>


@interface EventsBLTests : XCTestCase

@property (nonatomic,strong) EventsBL * bl;
@property (nonatomic,strong) Events * theEvents;

@end

@implementation EventsBLTests


- (void)setUp {
    //创建EventsBL对象
    self.bl = [[EventsBL alloc] init];
    //创建Events对象
    self.theEvents = [[Events alloc] init];
    self.theEvents.EventName = @"test EventName";
    self.theEvents.EventIcon = @"test EventIcon";
    self.theEvents.KeyInfo = @"test KeyInfo";
    self.theEvents.BasicsInfo = @"test BasicsInfo";
    self.theEvents.OlympicInfo = @"test OlympicInfo";
    
    //插入测试数据
    EventsDAO *dao = [EventsDAO sharedInstance];
    [dao create:self.theEvents];
}

- (void)tearDown {
    //删除测试数据
    self.theEvents.EventID = 41;
    EventsDAO *dao = [EventsDAO sharedInstance];
    [dao remove:self.theEvents];
    
    self.bl = nil;
}

//测试 按照主键查询数据方法
-(void) testFindAll {
    
    NSArray* list =  [self.bl readData];
    //断言 查询记录数为1
    XCTAssertEqual([list count], 41);
    
    Events* resEvents  = list[40];
    //断言
    XCTAssertEqualObjects(self.theEvents.EventName ,resEvents.EventName, @"比赛项目名测试失败");
    XCTAssertEqualObjects(self.theEvents.EventIcon ,resEvents.EventIcon, @"比赛项目图标测试失败");
    XCTAssertEqualObjects(self.theEvents.KeyInfo ,resEvents.KeyInfo, @"项目关键信息测试失败");
    XCTAssertEqualObjects(self.theEvents.BasicsInfo ,resEvents.BasicsInfo, @"项目基本信息测试失败");
    XCTAssertEqualObjects(self.theEvents.OlympicInfo ,resEvents.OlympicInfo, @"项目奥运会历史信息测试失败");
}

@end
