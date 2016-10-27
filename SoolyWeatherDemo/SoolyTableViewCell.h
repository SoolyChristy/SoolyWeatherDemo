//
//  SoolyTableViewCell.h
//  SoolyWeatherDemo
//
//  Created by SoolyChristina on 16/9/8.
//  Copyright © 2016年 SoolyChristina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SoolyTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *tittleLabel;

- (instancetype)initWithXib;
+ (instancetype)soolyTableViewCellWithTableView:(UITableView *)tableView;

@end
