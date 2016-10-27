//
//  TodayData.m
//  SoolyWeatherDemo
//
//  Created by SoolyChristina on 16/9/15.
//  Copyright © 2016年 SoolyChristina. All rights reserved.
//

#import "TodayData.h"

@implementation TodayData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        NSString *str = [dic[@"curTemp"] substringWithRange:NSMakeRange(0, [dic[@"curTemp"] length] - 1)];
        str = [str stringByAppendingString:@"°"];
        self.curTemp = str;
        self.date = dic[@"date"];
        self.fengli = dic[@"fengli"];
        self.fengxiang = dic[@"fengxiang"];
        self.highTemp = dic[@"hightemp"];
        self.lowTemp = dic[@"lowtemp"];
        self.pm = dic[@"aqi"];
        self.week = dic[@"week"];
        self.type = dic[@"type"];
        self.time = [self getCurrentTime];
        self.api = [self getAirPollutionIndex];
        self.index = [TodayIndex initWithDic:dic[@"index"]];
    }
    return self;
}

+(instancetype)initWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

-(NSString *)getCurrentTime{
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"MM/dd HH:mm"];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
    NSLog(@"locationString:%@",locationString);
    
    return locationString;
}

-(NSString *)getAirPollutionIndex{
    NSLog(@"api: - %@",self.pm);
    if ((NSNull *)self.pm == [NSNull null]){
        return @"无数据";
    }else if (self.pm.intValue <= 50) {
        return @"优";
    }else if (self.pm.intValue <= 100 && self.pm.intValue > 50){
        return @"良";
    }else if (self.pm.intValue <= 150 && self.pm.intValue > 100){
        return @"轻度污染";
    }else if (self.pm.intValue <= 200 && self.pm.intValue > 150){
        return @"中度污染";
    }else if (self.pm.intValue <= 300 && self.pm.intValue > 200){
        return @"重度污染";
    }else{
        return @"严重污染";
    }
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.curTemp forKey:@"curTemp"];
    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeObject:self.fengli forKey:@"fengli"];
    [aCoder encodeObject:self.fengxiang forKey:@"fengxiang"];
    [aCoder encodeObject:self.highTemp forKey:@"highTemp"];
    [aCoder encodeObject:self.lowTemp forKey:@"lowTemp"];
    [aCoder encodeObject:self.api forKey:@"api"];
    [aCoder encodeObject:self.pm forKey:@"pm"];
    [aCoder encodeObject:self.week forKey:@"week"];
    [aCoder encodeObject:self.type forKey:@"type"];
    [aCoder encodeObject:self.time forKey:@"time"];
    [aCoder encodeObject:self.index forKey:@"index"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.curTemp = [aDecoder decodeObjectForKey:@"curTemp"];
        self.date = [aDecoder decodeObjectForKey:@"date"];
        self.fengli = [aDecoder decodeObjectForKey:@"fengli"];
        self.fengxiang = [aDecoder decodeObjectForKey:@"fengxiang"];
        self.highTemp = [aDecoder decodeObjectForKey:@"highTemp"];
        self.lowTemp = [aDecoder decodeObjectForKey:@"lowTemp"];
        self.api = [aDecoder decodeObjectForKey:@"api"];
        self.pm = [aDecoder decodeObjectForKey:@"pm"];
        self.week = [aDecoder decodeObjectForKey:@"week"];
        self.type = [aDecoder decodeObjectForKey:@"type"];
        self.time = [aDecoder decodeObjectForKey:@"time"];
        self.index = [aDecoder decodeObjectForKey:@"index"];
    }
    return self;
}

@end
