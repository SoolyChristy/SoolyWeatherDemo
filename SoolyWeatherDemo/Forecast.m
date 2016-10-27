//
//  Forecast.m
//  SoolyWeatherDemo
//
//  Created by SoolyChristina on 16/9/28.
//  Copyright © 2016年 SoolyChristina. All rights reserved.
//

#import "Forecast.h"

@interface Forecast()

@property(nonatomic,strong) NSArray *array;

@end

@implementation Forecast

-(NSMutableArray *)forecastArrs{
    if (!_forecastArrs) {
        _forecastArrs = [NSMutableArray array];
    }
    return _forecastArrs;
}

-(instancetype)initWithArray:(NSArray *)array{
    self = [super init];
    if (self) {
        self.array = array;
        [self setAllValue];
    }
    return self;
}

+(instancetype)initWithArray:(NSArray *)array{
    return [[self alloc]initWithArray:array];
}

-(void)setAllValue{
    //前天
    NSMutableArray *arr1 = [NSMutableArray array];
    [arr1 addObject:[self.array objectAtIndex:0][@"date"]];
    [arr1 addObject:[self.array objectAtIndex:0][@"week"]];
    [arr1 addObject:[self.array objectAtIndex:0][@"hightemp"]];
    [arr1 addObject:[self.array objectAtIndex:0][@"lowtemp"]];
    [arr1 addObject:[self.array objectAtIndex:0][@"type"]];
    [self.forecastArrs addObject:arr1];
    //昨天
    NSMutableArray *arr2 = [NSMutableArray array];
    [arr2 addObject:[self.array objectAtIndex:1][@"date"]];
    [arr2 addObject:[self.array objectAtIndex:1][@"week"]];
    [arr2 addObject:[self.array objectAtIndex:1][@"hightemp"]];
    [arr2 addObject:[self.array objectAtIndex:1][@"lowtemp"]];
    [arr2 addObject:[self.array objectAtIndex:1][@"type"]];
    [self.forecastArrs addObject:arr2];
    //明天
    NSMutableArray *arr3 = [NSMutableArray array];
    [arr3 addObject:[self.array objectAtIndex:2][@"date"]];
    [arr3 addObject:[self.array objectAtIndex:2][@"week"]];
    [arr3 addObject:[self.array objectAtIndex:2][@"hightemp"]];
    [arr3 addObject:[self.array objectAtIndex:2][@"lowtemp"]];
    [arr3 addObject:[self.array objectAtIndex:2][@"type"]];
    [self.forecastArrs addObject:arr3];
    
    NSMutableArray *arr4 = [NSMutableArray array];
    [arr4 addObject:[self.array objectAtIndex:3][@"date"]];
    [arr4 addObject:[self.array objectAtIndex:3][@"week"]];
    [arr4 addObject:[self.array objectAtIndex:3][@"hightemp"]];
    [arr4 addObject:[self.array objectAtIndex:3][@"lowtemp"]];
    [arr4 addObject:[self.array objectAtIndex:3][@"type"]];
    [self.forecastArrs addObject:arr4];
    
    NSMutableArray *arr5 = [NSMutableArray array];
    [arr5 addObject:[self.array objectAtIndex:4][@"date"]];
    [arr5 addObject:[self.array objectAtIndex:4][@"week"]];
    [arr5 addObject:[self.array objectAtIndex:4][@"hightemp"]];
    [arr5 addObject:[self.array objectAtIndex:4][@"lowtemp"]];
    [arr5 addObject:[self.array objectAtIndex:4][@"type"]];
    [self.forecastArrs addObject:arr5];
    
    NSMutableArray *arr6 = [NSMutableArray array];
    [arr6 addObject:[self.array objectAtIndex:5][@"date"]];
    [arr6 addObject:[self.array objectAtIndex:5][@"week"]];
    [arr6 addObject:[self.array objectAtIndex:5][@"hightemp"]];
    [arr6 addObject:[self.array objectAtIndex:5][@"lowtemp"]];
    [arr6 addObject:[self.array objectAtIndex:5][@"type"]];
    [self.forecastArrs addObject:arr6];
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.forecastArrs forKey:@"forecastArrs"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.forecastArrs = [aDecoder decodeObjectForKey:@"forecastArrs"];
    }
    return self;
}

@end
