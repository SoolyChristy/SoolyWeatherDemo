//
//  CityName.m
//  SoolyWeatherDemo
//
//  Created by SoolyChristina on 16/9/8.
//  Copyright © 2016年 SoolyChristina. All rights reserved.
//

#import "CityName.h"

@implementation CityName

+(NSDictionary *)citiesWithDic{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"citydict.plist" ofType:nil];
    NSDictionary *cityDic = [NSDictionary dictionaryWithContentsOfFile:path];
    return cityDic;
}

@end

