//
//  EventsViewController.m
//  RioOlympics2016
//
//  Created by 关东升 on 16/2/1.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

#import "EventsViewController.h"
#import "EventsViewCell.h"
#import "EventsDetailViewController.h"

#import <BusinessLogicLayer/EventsBL.h>
#import <PersistenceLayer/Events.h>

@interface EventsViewController () {
    //一行中列数
    NSUInteger COL_COUNT;
}

@property (strong, nonatomic) NSArray * events;

@end

@implementation EventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        //如果是iPhone设备，列数为2
        COL_COUNT = 2;
    } else {
        //如果是iPad设备，列数为5
        COL_COUNT = 5;
    }
    
    if (self.events == nil || [self.events count] == 0) {
        EventsBL* bl = [[EventsBL alloc] init];
        //获取全部数据
        NSMutableArray *array = [bl readData];
        self.events = array;
        [self.collectionView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        NSArray* indexPaths = [self.collectionView indexPathsForSelectedItems];
        NSIndexPath *indexPath = indexPaths[0];
        
        Events *event = self.events[indexPath.section * COL_COUNT + indexPath.row];
        EventsDetailViewController *detailVC = [segue destinationViewController];
        detailVC.event = event;
        
    }
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.events count] / COL_COUNT;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return COL_COUNT;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EventsViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    Events *event = [self.events objectAtIndex:(indexPath.section * COL_COUNT + indexPath.row)];
    cell.imageView.image = [UIImage imageNamed:event.EventIcon];
    return cell;
}


@end
