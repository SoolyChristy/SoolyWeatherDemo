//
//  TodayIndex.m
//  SoolyWeatherDemo
//
//  Created by SoolyChristina on 16/9/17.
//  Copyright © 2016年 SoolyChristina. All rights reserved.
//

#import "TodayIndex.h"

@implementation TodayIndex

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self getDataWithDic:dic];
    }
    return self;
}

+(instancetype)initWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

//获取今日指数
-(void)getDataWithDic:(NSDictionary*)dic{
    for (NSDictionary *dict in dic) {
        if ([dict[@"code"]isEqualToString:@"gm"]) {
            self.coldIndex = dict[@"index"];
            self.coldDetail = dict[@"details"];
        }else if ([dict[@"code"]isEqualToString:@"fs"]){
            self.SPFindex = dict[@"index"];
            self.SPFdetail = dict[@"details"];
        }else if ([dict[@"code"]isEqualToString:@"ct"]){
            self.dressingIndex = dict[@"index"];
            self.dressingDetail = dict[@"details"];
        }else if ([dict[@"code"]isEqualToString:@"yd"]){
            self.sportIndex = dict[@"index"];
            self.sportDetail = dict[@"details"];
        }else if ([dict[@"code"]isEqualToString:@"xc"]){
            self.carWashingIndex = dict[@"index"];
            self.carWashingDetail = dict[@"details"];
        }else{
            self.dryIndex = dict[@"index"];
            self.dryDetail = dict[@"details"];
        }
    }
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.coldIndex forKey:@"coldIndex"];
    [aCoder encodeObject:self.coldDetail forKey:@"coldDetail"];
    [aCoder encodeObject:self.SPFindex forKey:@"SPFindex"];
    [aCoder encodeObject:self.SPFdetail forKey:@"SPFdetail"];
    [aCoder encodeObject:self.dressingIndex forKey:@"dressingIndex"];
    [aCoder encodeObject:self.dressingDetail forKey:@"dressingDetail"];
    [aCoder encodeObject:self.sportIndex forKey:@"sportIndex"];
    [aCoder encodeObject:self.sportDetail forKey:@"sportDetail"];
    [aCoder encodeObject:self.carWashingIndex forKey:@"carWashingIndex"];
    [aCoder encodeObject:self.carWashingDetail forKey:@"carWashingDetail"];
    [aCoder encodeObject:self.dryIndex forKey:@"dryIndex"];
    [aCoder encodeObject:self.dryDetail forKey:@"dryDetail"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.coldDetail = [aDecoder decodeObjectForKey:@"coldDetail"];
        self.coldIndex = [aDecoder decodeObjectForKey:@"coldIndex"];
        self.SPFindex = [aDecoder decodeObjectForKey:@"SPFindex"];
        self.SPFdetail = [aDecoder decodeObjectForKey:@"SPFdetail"];
        self.dressingDetail = [aDecoder decodeObjectForKey:@"dressingDetail"];
        self.dressingIndex = [aDecoder decodeObjectForKey:@"dressingIndex"];
        self.sportIndex = [aDecoder decodeObjectForKey:@"sportIndex"];
        self.carWashingDetail = [aDecoder decodeObjectForKey:@"carWashingDetail"];
        self.carWashingIndex = [aDecoder decodeObjectForKey:@"carWashingIndex"];
        self.dryDetail = [aDecoder decodeObjectForKey:@"dryDetail"];
        self.dryIndex = [aDecoder decodeObjectForKey:@"dryIndex"];
    }
    return  self;
}

@end
