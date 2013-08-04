//
//  ViewController.m
//  YWeatherGetter4iTest
//
//  Created by wang zhenghong on 13-7-23.
//  Copyright (c) 2013年 wang zhenghong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize mLabelWeatherInfo;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    YWeatherUtils* yweatherUtils = [YWeatherUtils getInstance];
    [yweatherUtils setMAfterRecieveDataDelegate: self];
    [yweatherUtils queryYahooWeather:@"Tokyo"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)gotWeatherInfo:(WeatherInfo *)weatherInfo {
    NSMutableString* text = nil;
    if (weatherInfo == nil) {
        text = [NSMutableString stringWithString:YAHOO_WEATHER_ERROR];
        [mLabelWeatherInfo setText: text];
        return;
    }
    text = [NSMutableString stringWithString:@""];
    if ([self stringIsNonNilOrEmpty:weatherInfo.mDescription]) {
        [text appendString:weatherInfo.mDescription];
        [text appendString:@"\n"];
    }
    if ([self stringIsNonNilOrEmpty:weatherInfo.mLastBuildDate]) {
        [text appendString:weatherInfo.mLastBuildDate];
        [text appendString:@"\n"];
    }
    if ([self stringIsNonNilOrEmpty:weatherInfo.mLocationCity]) {
        [text appendString:weatherInfo.mLocationCity];
        [text appendString:@", "];
    }
    if ([self stringIsNonNilOrEmpty:weatherInfo.mLocationRegion]) {
        [text appendString:weatherInfo.mLocationRegion];
        [text appendString:@", "];
    }
    if ([self stringIsNonNilOrEmpty:weatherInfo.mLocationCountry]) {
        [text appendString:weatherInfo.mLocationCountry];
    }
    [text appendString:@"\n"];
    if ([self stringIsNonNilOrEmpty:weatherInfo.mConditionTitle]) {
        [text appendString:weatherInfo.mConditionTitle];
        [text appendString:@"\n"];
    }
    if ([self stringIsNonNilOrEmpty:weatherInfo.mConditionLat]) {
        [text appendString:weatherInfo.mConditionLat];
        [text appendString:@", "];
    }
    if ([self stringIsNonNilOrEmpty:weatherInfo.mConditionLon]) {
        [text appendString:weatherInfo.mConditionLon];
    }
    [text appendString:@"\n\n"];
    [text appendString:@"***Current weather info***\n"];
    if ([self stringIsNonNilOrEmpty:weatherInfo.mCurrentConditionDate]) {
        [text appendString:weatherInfo.mCurrentConditionDate];
        [text appendString:@"\n"];
    }
    if ([self stringIsNonNilOrEmpty:weatherInfo.mCurrentText]) {
        [text appendString:weatherInfo.mCurrentText];
        [text appendString:@"\n"];
    }
    if ([self stringIsNonNilOrEmpty:[NSString stringWithFormat: @"%d", weatherInfo.mCurrentTempC]]) {
        [text appendString:[NSString stringWithFormat: @"%dºC(%dºF)", weatherInfo.mCurrentTempC, weatherInfo.mCurrentTempF]];
        [text appendString:@"\n"];
    }
    [text appendString:@"\n"];
    [text appendString:@"***Forecast 1***\n"];
    if ([self stringIsNonNilOrEmpty:weatherInfo.mForecast1Info.mForecastDate]) {
        [text appendString:weatherInfo.mForecast1Info.mForecastDate];
        [text appendString:@"\n"];
    }
    if ([self stringIsNonNilOrEmpty:[NSString stringWithFormat: @"%d", weatherInfo.mForecast1Info.mForecastTempLowC]]) {
        [text appendString:[NSString stringWithFormat: @"low: %dºC  high: %dºC", weatherInfo.mForecast1Info.mForecastTempLowC, weatherInfo.mForecast1Info.mForecastTempHighC]];
        [text appendString:@"\n"];
    }
    if ([self stringIsNonNilOrEmpty:weatherInfo.mForecast1Info.mForecastText]) {
        [text appendString:weatherInfo.mForecast1Info.mForecastText];
        [text appendString:@"\n"];
    }
    
    [text appendString:@"\n"];
    [text appendString:@"***Forecast 2***\n"];
    if ([self stringIsNonNilOrEmpty:weatherInfo.mForecast2Info.mForecastDate]) {
        [text appendString:weatherInfo.mForecast2Info.mForecastDate];
        [text appendString:@"\n"];
    }
    if ([self stringIsNonNilOrEmpty:[NSString stringWithFormat: @"%d", weatherInfo.mForecast2Info.mForecastTempLowC]]) {
        [text appendString:[NSString stringWithFormat: @"low: %dºC  high: %dºC", weatherInfo.mForecast2Info.mForecastTempLowC, weatherInfo.mForecast2Info.mForecastTempHighC]];
        [text appendString:@"\n"];
    }
    if ([self stringIsNonNilOrEmpty:weatherInfo.mForecast2Info.mForecastText]) {
        [text appendString:weatherInfo.mForecast2Info.mForecastText];
        [text appendString:@"\n"];
    }
    
    [mLabelWeatherInfo setText: text];
}

- (bool)stringIsNonNilOrEmpty:(NSString*)pString {
    if (pString != nil && ![pString isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

@end
