//
//  WeatherForecastView.m
//  SoolyWeatherDemo
//
//  Created by SoolyChristina on 16/9/17.
//  Copyright © 2016年 SoolyChristina. All rights reserved.
//

#import "WeatherForecastView.h"
#import "Masonry.h"

@interface WeatherForecastView()

@property (nonatomic,weak) UIColor *textColor;

@end

@implementation WeatherForecastView

-(instancetype)initWithFrame:(CGRect)frame andTextColor:(UIColor *)textColor{
    self = [super initWithFrame:frame];
    self.textColor = textColor;
    [self setUI];
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.dateLabel.frame = CGRectMake(0, 0, self.bounds.size.width, 25);
    //添加约束
    __weak typeof(self) weakSelf = self;
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(20);
        make.left.equalTo(weakSelf).offset(0);
        make.right.equalTo(weakSelf).offset(0);
        make.bottom.equalTo(weakSelf.WeatherPic.mas_top);
    }];
    
    [self.WeatherPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.dateLabel.mas_bottom);
        make.left.equalTo(weakSelf).with.offset(10);
        make.right.equalTo(weakSelf).with.offset(-10);
        make.bottom.equalTo(weakSelf.tmpLabel.mas_top);
    }];
    
    [self.tmpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.WeatherPic.mas_bottom);
        make.left.equalTo(weakSelf).with.offset(0);
        make.right.equalTo(weakSelf).with.offset(0);
        make.bottom.equalTo(weakSelf).offset(-20);
    }];
}


-(void)setUI{
    //日期Label
    UILabel *dateLabel = [[UILabel alloc]init];
    dateLabel.font = [UIFont systemFontOfSize:15];
    dateLabel.textAlignment = NSTextAlignmentCenter;
    dateLabel.textColor = self.textColor;
    dateLabel.text = @"明天";
    [self addSubview:dateLabel];
    self.dateLabel = dateLabel;
    self.dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    //天气icon
    UIImageView *icon = [[UIImageView alloc]init];
      //图片自适应
    icon.contentMode = UIViewContentModeScaleAspectFit;
    icon.image = [UIImage imageNamed:@"sun1"];
    [self addSubview:icon];
    self.WeatherPic = icon;
    self.WeatherPic.translatesAutoresizingMaskIntoConstraints = NO;
    //温度Label
    UILabel *tmp = [[UILabel alloc]init];
    tmp.textAlignment = NSTextAlignmentCenter;
    tmp.font = [UIFont systemFontOfSize:15];
    tmp.textColor = self.textColor;
    tmp.text = @"25";
    [self addSubview:tmp];
    self.tmpLabel = tmp;
    self.tmpLabel.translatesAutoresizingMaskIntoConstraints = NO;
}

-(void)setForecastArr:(NSArray *)forecastArr{
    if (forecastArr != _forecastArr) {
        _forecastArr = forecastArr;
    }
    //给子控件赋值
    self.dateLabel.text = [forecastArr objectAtIndex:1];
    NSString *low = [forecastArr objectAtIndex:3];
    NSString *high = [forecastArr objectAtIndex:2];
    self.tmpLabel.text = [NSString stringWithFormat:@"%@~%@",low,high];
    [self getWeatherTypeWith:[forecastArr objectAtIndex:4]];
}

-(void)getWeatherTypeWith:(NSString *)type{
    if ([type isEqualToString:@"晴"]) {
        self.WeatherPic.image = [UIImage imageNamed:@"sun1"];
    }else if ([type isEqualToString:@"多云"]){
        self.WeatherPic.image = [UIImage imageNamed:@"cloud1"];
    }else if ([type rangeOfString:@"雨"].length > 0){
        if ([type isEqualToString:@"小雨"]) {
            self.WeatherPic.image = [UIImage imageNamed:@"rain1"];
        }else{
            self.WeatherPic.image = [UIImage imageNamed:@"heavyrain1"];
        }
    }else if ([type rangeOfString:@"雪"].length > 0){
        self.WeatherPic.image = [UIImage imageNamed:@"snow1"];
    }
}


@end
