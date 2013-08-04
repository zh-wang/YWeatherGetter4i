//
//  WeatherInfo.m
//  YWeatherGetter4iTest
//
//  Created by Wang Zhenghong on 2013/07/27.
//  Copyright (c) 2013年 wang zhenghong. All rights reserved.
//

#import "WeatherInfo.h"

/*
 * Weather Info class
 */
@implementation WeatherInfo

@synthesize RESULT_STATUS;

@synthesize mTitle;
@synthesize mDescription;
@synthesize mLanguage;
@synthesize mLastBuildDate;
@synthesize mUnitsTemperature;
@synthesize mUnitsDistance;
@synthesize mUnitsPressure;
@synthesize mUnitsSpeed;
@synthesize mLocationCity;
@synthesize mLocationRegion;
@synthesize mLocationCountry;
@synthesize mWindChill;
@synthesize mWindDirection;
@synthesize mWindSpeed;
@synthesize mAtmosphereHumidity;
@synthesize mAtmosphereVisibility;
@synthesize mAtmospherePressure;
@synthesize mAtmosphereRising;
@synthesize mAstronomySunrise;
@synthesize mAstronomySunset;
@synthesize mConditionTitle;
@synthesize mConditionLat;
@synthesize mConditionLon;

@synthesize mCurrentCode;
@synthesize mCurrentText;
@synthesize mCurrentTempC;
@synthesize mCurrentTempF;
@synthesize mCurrentConditionIconURL;
@synthesize mCurrentConditionDate;

@synthesize mForecast1Info;
@synthesize mForecast2Info;

-(id)init {
    self = [super init];
	if (self != nil) {
        mForecast1Info = [[ForecastInfo alloc] init];
        mForecast2Info = [[ForecastInfo alloc] init];
    }
    return self;
}

@end

/*
 * Forecast Info class
 */
@implementation ForecastInfo
@synthesize mForecastDay;
@synthesize mForecastDate;
@synthesize mForecastCode;
@synthesize mForecastConditionIconURL;
@synthesize mForecastTempHighC;
@synthesize mForecastTempHighF;
@synthesize mForecastTempLowC;
@synthesize mForecastTempLowF;
@synthesize mForecastText;

@end
