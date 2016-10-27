//
//  Forecast.h
//  SoolyWeatherDemo
//
//  Created by SoolyChristina on 16/9/28.
//  Copyright © 2016年 SoolyChristina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Forecast : NSObject <NSCoding>

@property (nonatomic,strong) NSMutableArray *forecastArrs;

-(instancetype)initWithArray:(NSArray *)array;
+(instancetype)initWithArray:(NSArray *)array;

@end
