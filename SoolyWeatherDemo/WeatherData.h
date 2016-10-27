//
//  WeatherData.h
//  SoolyWeatherDemo
//
//  Created by SoolyChristina on 16/9/15.
//  Copyright © 2016年 SoolyChristina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TodayData.h"
#import "Forecast.h"

@class TodayData,Forecast;
@interface WeatherData : NSObject <NSCoding>

@property (nonatomic,copy) NSString *cityName;
@property (nonatomic,strong) TodayData *today;
@property (nonatomic,strong) Forecast *forecast;

-(instancetype)initWithDic:(NSDictionary *)dic;
-(void)writeToFile;

+(WeatherData *)weatherDataWithContentsOfFile;

@end
