//
//  CityTableViewController.h
//  SoolyWeatherDemo
//
//  Created by SoolyChristina on 16/9/8.
//  Copyright © 2016年 SoolyChristina. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CityTableViewController;

@protocol CityTableViewControllerDelegate <NSObject>


@end

@interface CityTableViewController : UITableViewController

@property (nonatomic,weak) id <CityTableViewControllerDelegate> delegate;

@end
