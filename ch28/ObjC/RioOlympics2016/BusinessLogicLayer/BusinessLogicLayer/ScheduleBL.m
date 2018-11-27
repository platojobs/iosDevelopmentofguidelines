//
//  ScheduleBL.m
//  BusinessLogicLayer
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

#import "ScheduleBL.h"

@implementation ScheduleBL

//查询所有数据方法
-(NSMutableDictionary*) readData {
    ScheduleDAO *scheduleDAO = [ScheduleDAO sharedInstance];
    
    NSMutableArray* schedules  = [scheduleDAO findAll];
    NSMutableDictionary *resDict = [[NSMutableDictionary alloc] init];
    
    EventsDAO *eventsDAO = [EventsDAO sharedInstance];
    
    //延迟加载Events数据
    for (Schedule *schedule in schedules) {
        Events *event = [eventsDAO findById:schedule.Event];
        schedule.Event = event;
        
        NSArray  *allkey = [resDict allKeys];
        
        //把NSMutableArray结构转化为NSMutableDictionary结构
        if([allkey containsObject:schedule.GameDate]) {
            NSMutableArray* value = resDict[schedule.GameDate];
             [value addObject:schedule];
        } else {
            NSMutableArray* value = [[NSMutableArray alloc] init];
            [value addObject:schedule];
            resDict[schedule.GameDate] = value;
        }
    }    
    return resDict;
}


@end
