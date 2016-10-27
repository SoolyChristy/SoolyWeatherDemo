//
//  WeatherForecastView.h
//  SoolyWeatherDemo
//
//  Created by SoolyChristina on 16/9/17.
//  Copyright © 2016年 SoolyChristina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherForecastView : UIView

@property (nonatomic,weak) UILabel *dateLabel;
@property (nonatomic,weak) UIImageView *WeatherPic;
@property (nonatomic,weak) UILabel *tmpLabel;

@property (nonatomic,strong) NSArray *forecastArr;

-(instancetype)initWithFrame:(CGRect)frame andTextColor:(UIColor *)textColor;
@end
