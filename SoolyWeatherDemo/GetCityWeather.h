//
//  GetCityWeather.h
//  SoolyWeatherDemo
//
//  Created by SoolyChristina on 16/9/13.
//  Copyright © 2016年 SoolyChristina. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WeatherData;
@protocol GetCityWeatherDelegate <NSObject>

-(void)setDataWithWeatherData:(WeatherData *)weatherData;
-(void)getCityWeatherError;

@end

@interface GetCityWeather : NSObject

@property (nonatomic,weak) id <GetCityWeatherDelegate> delegate;

-(instancetype)initWithCityName:(NSString *)cityName;

@end
