//
//  WeatherInfo.h
//  YWeatherGetter4iTest
//
//  Created by Wang Zhenghong on 2013/07/27.
//  Copyright (c) 2013年 wang zhenghong. All rights reserved.
//

#import <Foundation/Foundation.h>

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
@property (nonatomic, retain) NSString* mForecast1Day;
@property (nonatomic, retain) NSString* mForecast1Date;
@property (nonatomic, readwrite) int mForecast1Code;
@property (nonatomic, retain) NSString* mForecast1Text;
@property (nonatomic, readwrite) int mForecast1TempHighC;
@property (nonatomic, readwrite) int mForecast1TempLowC;
@property (nonatomic, readwrite) int mForecast1TempHighF;
@property (nonatomic, readwrite) int mForecast1TempLowF;
@property (nonatomic, retain) NSString* mForecast1ConditionIconURL;

/*
 * information in the second tag "yweather:forecast"
 */
@property (nonatomic, retain) NSString* mForecast2Day;
@property (nonatomic, retain) NSString* mForecast2Date;
@property (nonatomic, readwrite) int mForecast2Code;
@property (nonatomic, retain) NSString* mForecast2Text;
@property (nonatomic, readwrite) int mForecast2TempHighC;
@property (nonatomic, readwrite) int mForecast2TempLowC;
@property (nonatomic, readwrite) int mForecast2TempHighF;
@property (nonatomic, readwrite) int mForecast2TempLowF;
@property (nonatomic, retain) NSString* mForecast2ConditionIconURL;

@end
