//
//  WeatherTableViewCell.h
//  SoolyWeatherDemo
//
//  Created by SoolyChristina on 16/9/8.
//  Copyright © 2016年 SoolyChristina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherTableViewCell : UITableViewCell

@property (nonatomic,strong) NSDictionary *cityData;

- (instancetype)initWithXib;
+ (instancetype)WeatherTableViewCellWithTableView:(UITableView *)tableView;

@end
