//
//  WeatherTableViewCell.m
//  SoolyWeatherDemo
//
//  Created by SoolyChristina on 16/9/8.
//  Copyright © 2016年 SoolyChristina. All rights reserved.
//

#import "WeatherTableViewCell.h"

@interface WeatherTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;

@end

@implementation WeatherTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithXib{
    self = [super init];
    if (self) {
       self = [[[NSBundle mainBundle]loadNibNamed:@"WeatherTableViewCell" owner:nil options:nil]lastObject];
    }
    return self;
}

+(instancetype)WeatherTableViewCellWithTableView:(UITableView *)tableView{
    WeatherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseID"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"WeatherTableViewCell" owner:nil options:nil]lastObject];
    }
    return cell;
}

-(void)setCityData:(NSDictionary *)cityData{
    if (_cityData != cityData) {
        _cityData = cityData;
    }
    UIColor *textColor = [UIColor colorWithRed:0.96 green:0.82 blue:0.55 alpha:1.00];
//    NSLog(@"name - %@",[self.cityData objectForKey:@"name"]);
    self.NameLabel.text = self.cityData[@"name"];
    self.typeLabel.text = self.cityData[@"type"];
    self.tempLabel.text = self.cityData[@"temp"];
    self.NameLabel.textColor = textColor;
    self.typeLabel.textColor = textColor;
    self.tempLabel.textColor = textColor;
}

@end
