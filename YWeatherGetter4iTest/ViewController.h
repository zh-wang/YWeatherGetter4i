//
//  ViewController.h
//  YWeatherGetter4iTest
//
//  Created by wang zhenghong on 13-7-23.
//  Copyright (c) 2013年 wang zhenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWeatherGetter4i/YWeatherInfoDelegate.h"
#import "YWeatherGetter4i/YWeatherUtils.h"

@interface ViewController : UIViewController <YWeatherInfoDelegate>

@property (weak, nonatomic) IBOutlet UILabel *mLabelWeatherInfo;

@end
