//
//  TodayData.h
//  SoolyWeatherDemo
//
//  Created by SoolyChristina on 16/9/15.
//  Copyright © 2016年 SoolyChristina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TodayIndex.h"

@class TodayIndex;
@interface TodayData : NSObject <NSCoding>

@property (nonatomic,copy) NSString *curTemp;
@property (nonatomic,copy) NSString *date;
@property (nonatomic,copy) NSString *fengli;
@property (nonatomic,copy) NSString *fengxiang;
@property (nonatomic,copy) NSString *highTemp;
@property (nonatomic,copy) NSString *lowTemp;
@property (nonatomic,copy) NSString *api;
@property (nonatomic,copy) NSString *pm;
@property (nonatomic,copy) NSString *week;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,strong) TodayIndex *index;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)initWithDic:(NSDictionary *)dic;
@end
