//
//  WeatherInfo.h
//  YWeatherGetter4iTest
//
//  Created by Wang Zhenghong on 2013/07/27.
//  Copyright (c) 2013年 wang zhenghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WeatherInfo;
@class ForecastInfo;

/*
 * Weather Info class
 */
@interface WeatherInfo : NSOperation

/*
 * Result of querying weather
 */
@property (nonatomic, retain) NSString* RESULT_STATUS;

/*
 * Detail weather information abount the querying place
 */
@property (nonatomic, retain) NSString* mTitle;
@property (nonatomic, retain) NSString* mDescription;
@property (nonatomic, retain) NSString* mLanguage;
@property (nonatomic, retain) NSString* mLastBuildDate;
@property (nonatomic, retain) NSString* mLocationCity;
@property (nonatomic, retain) NSString* mLocationRegion; // region may be null
@property (nonatomic, retain) NSString* mLocationCountry;

@property (nonatomic, retain) NSString* mUnitsTemperature;
@property (nonatomic, retain) NSString* mUnitsDistance;
@property (nonatomic, retain) NSString* mUnitsPressure;
@property (nonatomic, retain) NSString* mUnitsSpeed;

@property (nonatomic, retain) NSString* mWindChill;
@property (nonatomic, retain) NSString* mWindDirection;
@property (nonatomic, retain) NSString* mWindSpeed;

@property (nonatomic, retain) NSString* mAtmosphereHumidity;
@property (nonatomic, retain) NSString* mAtmosphereVisibility;
@property (nonatomic, retain) NSString* mAtmospherePressure;
@property (nonatomic, retain) NSString* mAtmosphereRising;

@property (nonatomic, retain) NSString* mAstronomySunrise;
@property (nonatomic, retain) NSString* mAstronomySunset;

@property (nonatomic, retain) NSString* mConditionTitle;
@property (nonatomic, retain) NSString* mConditionLat;
@property (nonatomic, retain) NSString* mConditionLon;

/*
 * information in tag "yweather:condition"
 */
@property (nonatomic, readwrite) int mCurrentCode;
@property (nonatomic, retain) NSString* mCurrentText;
@property (nonatomic, readwrite) int mCurrentTempC;
@property (nonatomic, readwrite) int mCurrentTempF;
@property (nonatomic, retain) NSString* mCurrentConditionIconURL;
@property (nonatomic, retain) NSString* mCurrentConditionDate;

/*
 * information in the first tag "yweather:forecast"
 */
@property (nonatomic, retain) ForecastInfo* mForecast1Info;

/*
 * information in the second tag "yweather:forecast"
 */
@property (nonatomic, retain) ForecastInfo* mForecast2Info;

@end

/*
 * Forecast Info class
 */
@interface ForecastInfo : NSObject

@property (nonatomic, retain) NSString* mForecastDay;
@property (nonatomic, retain) NSString* mForecastDate;
@property (nonatomic, readwrite) int mForecastCode;
@property (nonatomic, retain) NSString* mForecastText;
@property (nonatomic, readwrite) int mForecastTempHighC;
@property (nonatomic, readwrite) int mForecastTempLowC;
@property (nonatomic, readwrite) int mForecastTempHighF;
@property (nonatomic, readwrite) int mForecastTempLowF;
@property (nonatomic, retain) NSString* mForecastConditionIconURL;

@end
