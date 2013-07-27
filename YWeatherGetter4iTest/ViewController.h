//
//  ViewController.h
//  YWeatherGetter4iTest
//
//  Created by wang zhenghong on 13-7-23.
//  Copyright (c) 2013年 wang zhenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWeatherGetter4i/YWeatherListener.h"
#import "YWeatherGetter4i/YWeatherUtils.h"

@interface ViewController : UIViewController <YWeatherUtilsDelegate>

@property (weak, nonatomic) IBOutlet UILabel *mLabelWeatherInfo;

@end
