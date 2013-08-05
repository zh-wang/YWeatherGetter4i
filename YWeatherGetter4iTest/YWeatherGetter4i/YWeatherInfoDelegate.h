//
//  YWeatherListener.h
//  YWeatherGetter4iTest
//
//  Created by Wang Zhenghong on 2013/07/27.
//  Copyright (c) 2013年 wang zhenghong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherInfo.h"

@protocol YWeatherInfoDelegate <NSObject>

-(void)gotWeatherInfo:(WeatherInfo*)recievedData;

@end
