//
//  WeatherTableViewController.m
//  SoolyWeatherDemo
//
//  Created by SoolyChristina on 16/9/8.
//  Copyright © 2016年 SoolyChristina. All rights reserved.
//

#import "WeatherTableViewController.h"
#import "WeatherTableViewCell.h"
#import "CityTableViewController.h"
#import "AppDelegate.h"

@class CityTableViewController;
@class WeatherTableViewCell;
@interface WeatherTableViewController ()

@end

@implementation WeatherTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //导航栏颜色
    UIColor *barColor = [UIColor colorWithRed:0.95 green:0.91 blue:0.80 alpha:1.00];
    UIColor *barTitleColor = [UIColor colorWithRed:0.34 green:0.42 blue:0.42 alpha:1.00];
    self.navigationController.navigationBar.barTintColor = barColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:barTitleColor};
    self.navigationController.navigationBar.tintColor = barTitleColor;
                                                                    
    self.navigationItem.title = @"城市管理";
    //创建导航条右button
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBtnClick)];
    self.navigationItem.rightBarButtonItem = addBtn;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.91 blue:0.80 alpha:1.00];
    //row行高
    self.tableView.rowHeight = 60;
    //取消cell分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //设置navigationBar颜色
//    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:0.95 green:0.91 blue:0.80 alpha:1.00]];
    
    //监听通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setData:) name:@"sendDataToWeatherTableVC" object:nil];
}

//监听通知后调用
-(void)setData:(NSNotification *)notification{
    NSLog(@"dict - %@",notification.userInfo);
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    
    //判断传过来的城市名是否重复 不重复则添加城市进入全局变量数组
    if (myDelegate.userCities.count == 0) {
        [myDelegate.userCities addObject:notification.userInfo];
    }else{
        for (int i = 0; i < myDelegate.userCities.count; i++) {
            if ([notification.userInfo[@"name"]isEqualToString:[myDelegate.userCities objectAtIndex:i][@"name"]]) {
                //若城市名相同&&温度不相同 更新数据
                if ([notification.userInfo[@"temp"]isEqualToString:[myDelegate.userCities objectAtIndex:i][@"temp"]]) {
                    return;
                }else{
                    [myDelegate.userCities replaceObjectAtIndex:i withObject:notification.userInfo];
                    return;
                }
            }else{
                //在for循环最后一次仍找不到相同城市名则 添加
                if (i == myDelegate.userCities.count - 1) {
                    [myDelegate.userCities addObject:notification.userInfo];
                }
            }
        }
    }
}

//移除需要观察的通知
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:@"sendDataToWeatherTableVC"];
}

//添加城市按钮点击事件
- (void)addBtnClick{
    CityTableViewController *cityVC = [[CityTableViewController alloc]init];
    //跳转到城市选择VC
    [self.navigationController pushViewController:cityVC animated:YES];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    return myDelegate.userCities.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //1.创建自定义的cell
    WeatherTableViewCell *cell = [WeatherTableViewCell WeatherTableViewCellWithTableView:self.tableView];
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    //选中不变色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //2.赋值
    cell.cityData = [myDelegate.userCities objectAtIndex:indexPath.row];
    //设置cell的颜色
    if ([cell.cityData[@"type"]isEqualToString:@"晴"]) {
        cell.backgroundColor = [UIColor colorWithRed:0.83 green:0.35 blue:0.31 alpha:1.00];
    }else if ([cell.cityData[@"type"]rangeOfString:@"雨"].length > 0 || [cell.cityData[@"type"]rangeOfString:@"雪"].length > 0){
        cell.backgroundColor = [UIColor colorWithRed:0.34 green:0.42 blue:0.42 alpha:1.00];
    }else{
        cell.backgroundColor = [UIColor colorWithRed:0.90 green:0.53 blue:0.30 alpha:1.00];
    }
    
    return cell;
}

//左滑删除
-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
        //移除用户城市数据
        [myDelegate.userCities removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
        NSLog(@"点击了删除");
    }];
    deleteAction.backgroundColor = [UIColor colorWithRed:0.96 green:0.82 blue:0.55 alpha:1.00];
    return @[deleteAction];
}
@end
