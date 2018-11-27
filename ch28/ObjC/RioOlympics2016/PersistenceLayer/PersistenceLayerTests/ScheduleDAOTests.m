//
//  ScheduleDAOTests.m
//  PersistenceLayerTests
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

#import "ScheduleDAO.h"
#import "Schedule.h"

@interface ScheduleDAOTests : XCTestCase

@property (nonatomic,strong) ScheduleDAO * dao;
@property (nonatomic,strong) Schedule * theSchedule;

@end

@implementation ScheduleDAOTests

- (void)setUp {
    [super setUp];
    //创建ScheduleDAO对象
    self.dao = [ScheduleDAO sharedInstance];
    //创建Schedule对象
    self.theSchedule = [[Schedule alloc] init];
    self.theSchedule.GameDate = @"test GameDate";
    self.theSchedule.GameTime = @"test GameTime";
    self.theSchedule.GameInfo = @"test GameInfo";
    self.theSchedule.Event.EventID = 1;
}

- (void)tearDown {
    self.dao = nil;
    [super tearDown];
}

//测试 插入Schedule方法
-(void) test_1_Create {
    int res = [self.dao create:self.theSchedule];
    //断言 无异常，返回值为0，
    XCTAssertEqual(res, 0);
}

//测试 按照主键查询数据方法
-(void) test_2_FindById {
    self.theSchedule.ScheduleID = 502;
    Schedule* resSchedule = [self.dao findById:self.theSchedule];
    //断言 查询结果非nil
    XCTAssertNotNil(resSchedule, @"查询记录为nil");
    //断言
    XCTAssertEqualObjects(self.theSchedule.GameDate ,resSchedule.GameDate);
    XCTAssertEqualObjects(self.theSchedule.GameTime ,resSchedule.GameTime);
    XCTAssertEqualObjects(self.theSchedule.GameInfo ,resSchedule.GameInfo);
    XCTAssertEqual(self.theSchedule.Event.EventID ,resSchedule.Event.EventID);
}

//测试 查询所有数据方法
-(void) test_3_FindAll {
    NSArray* list =  [self.dao findAll];
    //断言 查询记录数为1
    XCTAssertEqual([list count], 502);
    
    Schedule* resSchedule  = list[501];
    //断言
    XCTAssertEqualObjects(self.theSchedule.GameDate ,resSchedule.GameDate);
    XCTAssertEqualObjects(self.theSchedule.GameTime ,resSchedule.GameTime);
    XCTAssertEqualObjects(self.theSchedule.GameInfo ,resSchedule.GameInfo);
    XCTAssertEqual(self.theSchedule.Event.EventID ,resSchedule.Event.EventID);
}

//测试 修改Schedule方法
-(void) test_4_Modify {
    self.theSchedule.ScheduleID = 502;
    self.theSchedule.GameInfo = @"test modify GameInfo";
    
    int res = [self.dao modify:self.theSchedule];
    //断言 无异常，返回值为0
    XCTAssertEqual(res, 0);
    
    Schedule* resSchedule = [self.dao findById:self.theSchedule];
    //断言 查询结果非nil
    XCTAssertNotNil(resSchedule, @"查询记录为nil");
    //断言
    XCTAssertEqualObjects(self.theSchedule.GameDate ,resSchedule.GameDate);
    XCTAssertEqualObjects(self.theSchedule.GameTime ,resSchedule.GameTime);
    XCTAssertEqualObjects(self.theSchedule.GameInfo ,resSchedule.GameInfo);
    XCTAssertEqual(self.theSchedule.Event.EventID ,resSchedule.Event.EventID);
    
}

//测试 删除数据方法
-(void) test_5_Remove {
    int res =   [self.dao remove:self.theSchedule];
    //断言 无异常，返回值为0
    XCTAssertEqual(res, 0);
    
    Schedule* resSchedule = [self.dao findById:self.theSchedule];
    //断言 查询结果nil
    XCTAssertNil(resSchedule, @"记录删除失败");
    
}

@end
