//
//  TodayIndex.h
//  SoolyWeatherDemo
//
//  Created by SoolyChristina on 16/9/17.
//  Copyright © 2016年 SoolyChristina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodayIndex : NSObject <NSCoding>

@property (nonatomic,copy)NSString *coldIndex;
@property (nonatomic,copy)NSString *coldDetail;

@property (nonatomic,copy)NSString *SPFindex;
@property (nonatomic,copy)NSString *SPFdetail;

@property (nonatomic,copy)NSString *dressingIndex;
@property (nonatomic,copy)NSString *dressingDetail;

@property (nonatomic,copy)NSString *sportIndex;
@property (nonatomic,copy)NSString *sportDetail;

@property (nonatomic,copy)NSString *carWashingIndex;
@property (nonatomic,copy)NSString *carWashingDetail;

@property (nonatomic,copy)NSString *dryIndex;
@property (nonatomic,copy)NSString *dryDetail;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)initWithDic:(NSDictionary *)dic;

@end
