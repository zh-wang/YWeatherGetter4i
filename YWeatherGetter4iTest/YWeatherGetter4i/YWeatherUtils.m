//
//  YWeatherUtils.m
//  YWeatherGetter4iTest
//
//  Created by Wang Zhenghong on 2013/07/27.
//  Copyright (c) 2013年 wang zhenghong. All rights reserved.
//

#import "YWeatherUtils.h"

static YWeatherUtils* _instance = nil;

@implementation YWeatherUtils
@synthesize mAfterRecieveDataDelegate;

+(YWeatherUtils*)getInstance {
    @synchronized([YWeatherUtils class]) {
        if(!_instance)
            _instance = [[self alloc] init];
        return _instance;
    }
}

-(void)queryYahooWeather:(NSString *)pCityName {
    DLog(@"queryYahooWeather start");
    WOEIDUtils* woeidUtils = [WOEIDUtils getInstance];
    [woeidUtils setMAfterReceiveDataDelegate: self];
    [woeidUtils queryWOEID:pCityName];
    DLog(@"queryYahooWeather end");
}

-(NSString *)gotWOEIDdata:(NSMutableData *)receivedData {
    DLog(@"gotWOEIDdata start");
    NSString* woeidResult = [[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
    WeatherInfo* weatherInfo = [[WeatherInfo alloc] init];
    weatherInfo.RESULT_STATUS = woeidResult;
    [mAfterRecieveDataDelegate gotWeatherInfo: weatherInfo];
    DLog(@"gotWOEIDdata end");
    return @"";
}

@end
