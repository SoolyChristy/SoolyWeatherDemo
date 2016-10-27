//
//  SettingsTableViewController.m
//  SoolyWeatherDemo
//
//  Created by SoolyChristina on 16/9/8.
//  Copyright © 2016年 SoolyChristina. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "SoolyTableViewCell.h"
#import "WeatherTableViewController.h"

@class SoolyTableViewCell;

@interface SettingsTableViewController ()

@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = backBtn;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.91 blue:0.80 alpha:1.00];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //1.创建自定义cell
    SoolyTableViewCell *cell = [[SoolyTableViewCell alloc]initWithXib];
    //2.子控件赋值
    cell.tittleLabel.text = @"城市管理";
    cell.backgroundColor = [UIColor colorWithRed:0.95 green:0.91 blue:0.80 alpha:1.00];
//      //选中不变色
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //3.给cell添加点击响应

    return cell;
    
}

// 每个cell点击跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        WeatherTableViewController *WeatherVC = [[WeatherTableViewController alloc]init];
        [self.navigationController pushViewController:WeatherVC animated:YES];
    }
}


@end
