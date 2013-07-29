//
//  YWeather4iConsts.h
//  YWeatherGetter4iTest
//
//  Created by Wang Zhenghong on 2013/07/27.
//  Copyright (c) 2013年 wang zhenghong. All rights reserved.
//

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif
#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#ifdef DEBUG
#   define ULog(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
#else
#   define ULog(...)
#endif

#define WOEID_NOT_FOUND @"WOEID_NOT_FOUND"
#define YAHOO_WEATHER_ERROR @"Yahoo! Weather - error"
#define YAHOO_WEATHER_SUCCESS = @"Yahoo! Weather - succesful"
#define YAHOO_LOCATION_APIS_BASE @"http://query.yahooapis.com/v1/public/yql?q=select*from%20geo.places%20where%20text="
#define YAHOO_WEATHER_API_BASE @"http://weather.yahooapis.com/forecastrss?w="
#define YAHOO_APIS_FORMAT @"&format=xml"
#define TAG_TITLE @"title"
#define TAG_DISCRIPTION @"description"
#define TAG_LANGUAGE @"language"
#define TAG_LAST_BUILD_DATE @"lastBuildData"
#define TAG_YWEATHER_UNITS @"yweather:units"
#define TAG_UNITS_TEMPERATURE @"temperature"
#define TAG_UNITS_DISTANCE @"distance"
#define TAG_UNITS_PRESSURE @"pressure"
#define TAG_UNITS_SPEED @"speed"
#define TAG_YWEATHER_LOCATION @"yweather:location"
#define TAG_LOCATION_CITY @"city"
#define TAG_LOCATION_REGION @"region"
#define TAG_LOCATION_COUNTRY @"country"
#define TAG_YWEATHER_WIND @"yweather:wind"
#define TAG_WIND_CHILL @"chill"
#define TAG_WIND_DIRECTION @"direction"
#define TAG_WIND_SPEED @"speed"
#define TAG_YWEATHER_ATMOSPHERE @"yweather:atmosphere"
#define TAG_ATMOSPHERE_HUMIDITY @"humidity"
#define TAG_ATMOSPHERE_VISIBILITY @"visibility"
#define TAG_ATMOSPHERE_PRESSURE @"pressure"
#define TAG_ATMOSPHERE_RISING @"rising"
#define TAG_YWEATHER_ASTRONOMY @"yweather:astronomy"
#define TAG_ASTRONOMY_SUNRISE @"sunrise"
#define TAG_ASTRONOMY_SUNSET @"sunset"
#define TAG_ITEM @"item"
#define TAG_CONDITION_TITLE @"title"
#define TAG_CONDITION_GEOLAT @"geo:lat"
#define TAG_CONDITION_GEOLONG @"geo:long"
#define TAG_YWEATHER_CONDITION @"yweather:condition"
#define TAG_CODE @"code"
#define TAG_TEXT @"text"
#define TAG_TEMP @"temp"
#define TAG_DATE @"date"
#define TAG_YWEATHER_FORECAST @"yweather:forecast"
#define TAG_DAY @"day"
#define TAG_HIGH @"high"
#define TAG_LOW @"low"