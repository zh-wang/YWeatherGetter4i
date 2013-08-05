//
//  YWeatherUtils.h
//  YWeatherGetter4iTest
//
//  Created by Wang Zhenghong on 2013/07/27.
//  Copyright (c) 2013年 wang zhenghong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YWeatherInfoDelegate.h"
#import "WeatherInfo.h"
#import "WOEIDUtils.h"
#import "WOEIDUtilsDelegate.h"

@interface YWeatherUtils : NSObject <NSURLConnectionDelegate, WOEIDUtilsDelegate>

@property (nonatomic, assign) id mAfterRecieveDataDelegate;
@property (nonatomic, retain) NSMutableData* receivedData;
@property (nonatomic, assign) TBXMLElement* mResultElement;
@property (nonatomic, retain) NSString* mSearchTagName;

+(YWeatherUtils*)getInstance;
-(void)queryYahooWeather:(NSString*)pCityName;

@end

