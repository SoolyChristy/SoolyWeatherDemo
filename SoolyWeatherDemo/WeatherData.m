//
//  WeatherData.m
//  SoolyWeatherDemo
//
//  Created by SoolyChristina on 16/9/15.
//  Copyright © 2016年 SoolyChristina. All rights reserved.
//

#import "WeatherData.h"

@implementation WeatherData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.cityName = dic[@"city"];
        self.today = [TodayData initWithDic:dic[@"today"]];
        //        NSLog(@"%@",hArray);
        //        [hArray removeObjectsInRange:NSMakeRange(0, 5)];
        NSMutableArray *hArray = [[NSMutableArray alloc]initWithArray:dic[@"history"]];
        NSMutableArray *array = [NSMutableArray arrayWithArray:hArray];
        [array addObjectsFromArray:dic[@"forecast"]];
        self.forecast = [Forecast initWithArray:array];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.cityName forKey:@"cityName"];
    [aCoder encodeObject:self.today forKey:@"today"];
    [aCoder encodeObject:self.forecast forKey:@"forecast"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.cityName = [aDecoder decodeObjectForKey:@"cityName"];
        self.today = [aDecoder decodeObjectForKey:@"today"];
        self.forecast = [aDecoder decodeObjectForKey:@"forecast"];
    }
    return self;
}

#pragma mark - 获取本地数据路径

- (NSString *)getDataPath{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    NSString *fileName = [path stringByAppendingPathComponent:@"DataDic.data"];
    return fileName;
}

#pragma mark - 数据的持久化
//归档
-(void)writeToFile{
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self forKey:@"weatherData"];
    [archiver finishEncoding];
    [data writeToFile:[self getDataPath] atomically:YES];
}

//解档
+(WeatherData *)weatherDataWithContentsOfFile{
    NSData *data = [NSData dataWithContentsOfFile:[[self alloc] getDataPath]];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    WeatherData *weatherData = [unarchiver decodeObjectForKey:@"weatherData"];
    return weatherData;
}

@end
