//
//  CityTableViewController.m
//  SoolyWeatherDemo
//
//  Created by SoolyChristina on 16/9/8.
//  Copyright © 2016年 SoolyChristina. All rights reserved.
//

#import "CityTableViewController.h"
#import "CityName.h"
#import "RootViewController.h"

@class CityName;
@interface CityTableViewController ()

@property (nonatomic,strong) NSDictionary *citiesDic;
@property (nonatomic,strong) NSMutableArray *keys;

@end

@implementation CityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //获取城市信息
    [self getCitiesData];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIColor *warmColor = [UIColor colorWithRed:0.95 green:0.91 blue:0.80 alpha:1.00];
    self.tableView.backgroundColor = warmColor;
    //索引字体颜色
    self.tableView.sectionIndexColor = [UIColor colorWithRed:0.34 green:0.42 blue:0.42 alpha:1.00];
    self.tableView.sectionIndexBackgroundColor = warmColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 获取城市信息

-(void)getCitiesData{
    //初始化
    self.keys = [NSMutableArray array];
    self.citiesDic = [CityName citiesWithDic];
    //获取排序后字典里的keys
    NSArray *tmparray = [[self.citiesDic allKeys]sortedArrayUsingSelector:@selector(compare:)];
    [self.keys addObjectsFromArray:tmparray];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.citiesDic.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = [self.keys objectAtIndex:section];
    NSArray *citySection = [self.citiesDic objectForKey:key];
    return citySection.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //创建可重用的cell
    static NSString *reuseId = @"reuseId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    cell.backgroundColor = [UIColor colorWithRed:0.95 green:0.91 blue:0.80 alpha:1.00];
    cell.textLabel.textColor = [UIColor colorWithRed:0.34 green:0.42 blue:0.42 alpha:1.00];
    //获取城市数据
    NSArray *citySection = [self.citiesDic objectForKey:[self.keys objectAtIndex:indexPath.section]];
    NSString *cityName = [citySection objectAtIndex:indexPath.row];
    cell.textLabel.text = cityName;
    return cell;
}

//返回组头 名
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.keys objectAtIndex:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.keys;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    if(section == 0)
//}

//点击每个cell的响应
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //1.获取城市数据
    NSArray *citySection = [self.citiesDic objectForKey:[self.keys objectAtIndex:indexPath.section]];
    NSString *cityName = [citySection objectAtIndex:indexPath.row];
    
    //2.push进入根控制器
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RootViewController *rootVc = [main instantiateViewControllerWithIdentifier:@"rootView"];
    rootVc.cityName = [NSString stringWithString:cityName];
    [self.navigationController pushViewController:rootVc animated:YES];

}
@end
