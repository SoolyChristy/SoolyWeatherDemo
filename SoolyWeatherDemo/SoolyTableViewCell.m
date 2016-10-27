//
//  SoolyTableViewCell.m
//  SoolyWeatherDemo
//
//  Created by SoolyChristina on 16/9/8.
//  Copyright © 2016年 SoolyChristina. All rights reserved.
//

#import "SoolyTableViewCell.h"

@implementation SoolyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithXib{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"SoolyTableViewCell" owner:nil options:nil]lastObject];
    }
    return self;
}

+(instancetype)soolyTableViewCellWithTableView:(UITableView *)tableView{
    SoolyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseID"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SoolyTableViewCell" owner:nil options:nil]lastObject];
        
    }
    return cell;
}

@end
