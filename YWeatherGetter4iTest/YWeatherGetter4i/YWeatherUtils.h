//
//  YWeatherUtils.h
//  YWeatherGetter4iTest
//
//  Created by Wang Zhenghong on 2013/07/27.
//  Copyright (c) 2013年 wang zhenghong. All rights reserved.
//

#ifndef _YWEATHER_UTILS_H_
#define _YWEATHER_UTILS_H_


#import <Foundation/Foundation.h>
#import "YWeatherListener.h"
#import "YWeather4iConsts.h"
#import "WeatherInfo.h"
#import "WOEIDUtils.h"
#import "WOEIDUtilsDelegate.h"

@interface YWeatherUtils : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate, WOEIDUtilsDelegate>

@property (nonatomic, assign) id mAfterRecieveDataDelegate;

+(YWeatherUtils*)getInstance;
-(void)queryYahooWeather:(NSString*)pCityName;
-(NSString*)queryWOIED:(NSString*)pCityName;

@end
#endif /*_YWEATHER_UTILS_H_*/

