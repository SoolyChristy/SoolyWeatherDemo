//
//  GetCityWeather.m
//  SoolyWeatherDemo
//
//  Created by SoolyChristina on 16/9/13.
//  Copyright © 2016年 SoolyChristina. All rights reserved.
//

#import "GetCityWeather.h"
#import "WeatherData.h"

@class WeatherData;
@interface GetCityWeather()

@property (nonatomic,copy) NSString *cityName;
@property (nonatomic,copy) NSString *cityID;

@end

@implementation GetCityWeather

-(instancetype)initWithCityName:(NSString *)cityName{
    self = [super init];
    if (self) {
        self.cityName = [NSString stringWithString:cityName];
        [self getWeatherWithCityID];
    }
    return self;
}


-(void)getWeatherWithCityID{
    //1.获取城市ID
    NSString *httpUrl = @"http://apis.baidu.com/apistore/weatherservice/citylist";
      //弃用方法
//    NSString *utf8 = [self.cityName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *utf8 = [self.cityName stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *httpArg = [NSString stringWithFormat:@"cityname=%@",utf8];
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, httpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    //创建request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval: 3];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"68263df2935d265f87b2eb49f066953a" forHTTPHeaderField: @"apikey"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            [self.delegate getCityWeatherError];
            NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
        }else{
            NSDictionary *cityDic = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil]objectForKey:@"retData"];
            for (NSDictionary *dic in cityDic) {
                if ([[dic objectForKey:@"name_cn"]isEqualToString:self.cityName]) {
                    self.cityID = [dic objectForKey:@"area_id"];
                }
            }
            NSLog(@"cityID - %@",self.cityID);
            //2.获取城市天气信息
            [self requestCityWeather];
        }
    }];
    [task resume];
}

-(void)requestCityWeather{
    NSString *httpUrl = @"http://apis.baidu.com/apistore/weatherservice/recentweathers";
    NSString *utf8 = [self.cityName stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //    NSLog(@"%@",self.cityID);
    NSString *httpArg = [NSString stringWithFormat:@"cityname=%@&cityid=%@",utf8,self.cityID];
    [self request:httpUrl withHttpArg:httpArg];
    
}
//获取数据
-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"68263df2935d265f87b2eb49f066953a" forHTTPHeaderField: @"apikey"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            [self.delegate getCityWeatherError];
            NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
        } else {
            NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
//            NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                        NSLog(@"HttpResponseCode:%ld", responseCode);
//                        NSLog(@"HttpResponseBody %@",responseString);
            NSDictionary *dataDic = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil] objectForKey:@"retData"];
//            NSLog(@"dataDic - %@",self.weatherDic);
            if (dataDic.count != 0) {
                //获取数据完成后字典转模型
                WeatherData *weatherData = [[WeatherData alloc]initWithDic:dataDic];
                //获取数据完成后调用代理方法
                [self.delegate setDataWithWeatherData:weatherData];
            }else{
                NSLog(@"数据无法请求");
            }
        }
    }];
    [task resume];
}

@end
