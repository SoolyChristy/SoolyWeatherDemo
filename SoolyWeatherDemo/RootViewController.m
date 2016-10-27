//
//  RootViewController.m
//  SoolyWeatherDemo
//
//  Created by SoolyChristina on 16/9/8.
//  Copyright © 2016年 SoolyChristina. All rights reserved.
//

#import "RootViewController.h"
#import "CityTableViewController.h"
#import "GetCityWeather.h"
#import "WeatherData.h"
#import "WeatherForecastView.h"
#import <CoreLocation/CoreLocation.h>

@class GetCityWeather,WeatherData;
@interface RootViewController () <GetCityWeatherDelegate,CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIView *oneView;
@property (weak, nonatomic) IBOutlet UIView *twoView;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UILabel *tDetailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherPic;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;
@property (weak, nonatomic) IBOutlet UILabel *airLabel;
@property (weak, nonatomic) IBOutlet UIView *ScorllContentView;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidth;
@property (nonatomic,weak) UIColor *oneViewColor;
@property (nonatomic,weak) UIColor *rainItemColor;
@property (nonatomic,weak) UIColor *textColor;
@property (nonatomic,weak) UIColor *sunColor;

@property (nonatomic,strong) CLLocationManager *locationManage;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    //当初次使用时需要用户添加城市否则先载入本地数据再请求数据
    if (_cityName) {
        GetCityWeather *weather = [[GetCityWeather alloc]initWithCityName:self.cityName];
        weather.delegate = self;
    }else if ([WeatherData weatherDataWithContentsOfFile]){
        //若本地数据数组不为空，给子控件赋值
        WeatherData *weatherData = [WeatherData weatherDataWithContentsOfFile];
        [self setSubviewsUIwithWeatherData:weatherData];
        GetCityWeather *weather = [[GetCityWeather alloc]initWithCityName:weatherData.cityName];
        weather.delegate = self;
    }
}

-(void)setUI{
    UIColor *upColor = [UIColor colorWithRed:0.90 green:0.53 blue:0.3 alpha:1.00];
    UIColor *itemColor = [UIColor colorWithRed:0.34 green:0.42 blue:0.42 alpha:1.00];
    UIColor *downColor = [UIColor colorWithRed:0.95 green:0.91 blue:0.80 alpha:1.00];
    UIColor *textColor = [UIColor colorWithRed:0.34 green:0.42 blue:0.42 alpha:1.00];
    UIColor *cityColor = [UIColor colorWithRed:0.83 green:0.35 blue:0.31 alpha:1.00];
    self.oneViewColor = textColor;
    self.rainItemColor = downColor;
    self.textColor = textColor;
    //设置导航栏背景颜色
    [self.navigationController.navigationBar setBarTintColor:upColor];
    
    self.navigationController.navigationBar.tintColor = itemColor;
    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithObject:downColor forKey:NSForegroundColorAttributeName];
//    [dict setObject:[UIFont fontWithName:@"System" size:0.0] forKey:NSFontAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    //设置顶部view颜色
    [self.oneView setBackgroundColor:upColor];
      //创建天气图标view
    //设置下部view颜色
    [self.twoView setBackgroundColor:downColor];
    
    self.tempLabel.textColor = downColor;
    self.tDetailLabel.textColor = downColor;
    //设置label的颜色
    self.cityLabel.textColor = textColor;
    self.dataLabel.textColor = textColor;
    self.airLabel.textColor = textColor;
    self.cityLabel.textColor = cityColor;
}

//给子控件赋值
-(void)setSubviewsUIwithWeatherData:(WeatherData *)weatherData{
    //调用主线程更新UI
    dispatch_async(dispatch_get_main_queue(), ^{
        self.cityLabel.text = weatherData.cityName;
        self.tempLabel.text = weatherData.today.curTemp;
        self.tDetailLabel.text = [NSString stringWithFormat:@"%@ ~ %@",weatherData.today.lowTemp,weatherData.today.highTemp];
        self.dataLabel.text = [NSString stringWithFormat:@"%@ %@",weatherData.today.time,weatherData.today.week];
        self.airLabel.text = [NSString stringWithFormat:@"空气质量：%@",weatherData.today.api];
        [self getWeatherTypeWithWeatherType:weatherData.today.type];
        
        //创建scrollView的子控件
        for (int i = 0; i < 6; i++) {
            CGFloat margin = 30;
            CGFloat W = ([UIScreen mainScreen].bounds.size.width - 4 * margin) / 3;
            CGFloat H = self.ScorllContentView.bounds.size.height;
            CGFloat X = margin * (i + 1) + W * i;
            CGFloat Y = 0;
            CGRect frames = CGRectMake(X, Y, W, H);
            //创建scrollView里的自定义view
            WeatherForecastView *subview = [[WeatherForecastView alloc]initWithFrame:frames andTextColor:self.textColor];
            //获取数据模型
            subview.forecastArr = [weatherData.forecast.forecastArrs objectAtIndex:i];
            [self.ScorllContentView addSubview:subview];
        }
    });
}

-(void)updateViewConstraints{
    [super updateViewConstraints];
    //设置ScorllView contentView的宽度
    self.contentViewWidth.constant = ([UIScreen mainScreen].bounds.size.width) * 2 - 30;
}

-(void)getWeatherTypeWithWeatherType:(NSString *)type{
    NSLog(@"type - %@",type);
    if ([type isEqualToString:@"晴"]) {
        self.weatherPic.image = [UIImage imageNamed:@"sun1"];
//        self.oneView.backgroundColor = self.sunColor;
//        [self.navigationController.navigationBar setBarTintColor:self.sunColor];
//        self.navigationController.navigationBar.tintColor = self.sunColor;
    }else if ([type isEqualToString:@"多云"]){
        self.weatherPic.image = [UIImage imageNamed:@"cloud1"];
    }else if ([type rangeOfString:@"雨"].length > 0){
        self.oneView.backgroundColor = _oneViewColor;
        [self.navigationController.navigationBar setBarTintColor:self.oneViewColor];
        self.navigationController.navigationBar.tintColor = self.rainItemColor;
        if ([type isEqualToString:@"小雨"]) {
            self.weatherPic.image = [UIImage imageNamed:@"rain1"];
        }else{
            self.weatherPic.image = [UIImage imageNamed:@"heavyrain1"];
        }
    }else if ([type rangeOfString:@"雪"].length > 0){
        self.weatherPic.image = [UIImage imageNamed:@"snow1"];
        self.oneView.backgroundColor = _oneViewColor;
        [self.navigationController.navigationBar setBarTintColor:self.oneViewColor];
        self.navigationController.navigationBar.tintColor = self.rainItemColor;
    }
}

#pragma mark - 数据的持久化
////归档
//-(void)saveWeatherData:(WeatherData *)weatherData{
//    NSMutableData *data = [NSMutableData data];
//    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
//    [archiver encodeObject:weatherData forKey:@"weatherData"];
//    [archiver finishEncoding];
//    [data writeToFile:[self getDataPath] atomically:YES];
//}
//
////解档
//-(WeatherData *)loadWeatherData{
//    NSData *data = [NSData dataWithContentsOfFile:[self getDataPath]];
//    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
//    WeatherData *weatherData = [unarchiver decodeObjectForKey:@"weatherData"];
//    return weatherData;
//}

#pragma mark - 获取本地数据路径

- (NSString *)getDataPath{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    NSString *fileName = [path stringByAppendingPathComponent:@"DataDic.data"];
    return fileName;
}

#pragma mark - GetCityWeather的代理方法

//获取数据成功后调用
-(void)setDataWithWeatherData:(WeatherData *)weatherData{
    //给子控件赋值
    [self setSubviewsUIwithWeatherData:weatherData];
    //数据持久化(存储数据到本地)
//    [self saveWeatherData:weatherData];
    [weatherData writeToFile];
    NSLog(@"路径 - %@",[self getDataPath]);
    //发送通知给WeatherTabelVC
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:weatherData.cityName,@"name",weatherData.today.type,@"type",weatherData.today.curTemp,@"temp",nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"sendDataToWeatherTableVC" object:self userInfo:dict];

}

//获取数据失败调用
-(void)getCityWeatherError{
    NSLog(@"获取数据失败");
    //还原本地数据的UI
    [self setSubviewsUIwithWeatherData:[WeatherData weatherDataWithContentsOfFile]];
}

#pragma mark - 点击定位按钮

- (IBAction)locateBtnClick:(id)sender {
    CLLocationManager *locationManage = [[CLLocationManager alloc]init];
    // 设置定位精确度
    locationManage.desiredAccuracy = kCLLocationAccuracyBest;
    // 设置定位变化最小距离(精确到米)
    locationManage.distanceFilter = 50;
    // 取得定位权限
    [locationManage requestWhenInUseAuthorization];
    locationManage.delegate = self;
    self.locationManage = locationManage;
    
    if ([CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位开始");
        [locationManage startUpdatingHeading];
    }else{
        NSLog(@"没有定位功能");
    }
}

#pragma mark - CLLocationManager的代理方法
//定位获取失败
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"定位调用失败信息 - %@",error);
}

// 定位数据更新调用的代理方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    NSLog(@"11");
    //根据经纬度反向地理编译出地址信息
    [geoCoder reverseGeocodeLocation:locations.lastObject completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = [placemarks objectAtIndex:0];
            NSString *cityName = placeMark.name;
            NSLog(@"%@",placeMark.name);
            GetCityWeather *weather = [[GetCityWeather alloc]initWithCityName:cityName];
            weather.delegate = self;
        }
    }];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    NSLog(@"aa");
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = [placemarks objectAtIndex:0];
            NSString *cityName = placeMark.name;
            NSLog(@"%@",placeMark.name);
            GetCityWeather *weather = [[GetCityWeather alloc]initWithCityName:cityName];
            weather.delegate = self;
        }
    }];
}

@end
