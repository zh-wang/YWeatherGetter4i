//
//  YWeatherUtils.m
//  YWeatherGetter4iTest
//
//  Created by Wang Zhenghong on 2013/07/27.
//  Copyright (c) 2013年 wang zhenghong. All rights reserved.
//

#import "YWeatherUtils.h"

static YWeatherUtils* _instance = nil;

@implementation YWeatherUtils {
    int mForecastCount;
}

@synthesize mAfterRecieveDataDelegate;
@synthesize receivedData;
@synthesize mResultElement;
@synthesize mSearchTagName;

+(YWeatherUtils*)getInstance {
    @synchronized([YWeatherUtils class]) {
        if(!_instance)
            _instance = [[self alloc] init];
        return _instance;
    }
}

-(id) init {
    self = [super init];
	if (self != nil) {
        mForecastCount = 1;
    }
    return self;
}

-(void)queryYahooWeather:(NSString *)pCityName {
    DLog(@"queryYahooWeather start");
    WOEIDUtils* woeidUtils = [WOEIDUtils getInstance];
    [woeidUtils setMAfterReceiveDataDelegate: self];
    [woeidUtils queryWOEID:pCityName];
    DLog(@"queryYahooWeather end");
}

-(void)gotWOEIDfromYahooAPIs:(NSString *)receivedWOEID {
    DLog(@"gotWOEIDdata start");
    
    if ([receivedWOEID isEqualToString: WOEID_NOT_FOUND]) {
        [mAfterRecieveDataDelegate gotWeatherInfo: nil];
        return;
    }
    
    NSMutableString* yweatherQuery = [NSMutableString stringWithUTF8String:[YAHOO_WEATHER_API_BASE UTF8String]];
    [yweatherQuery appendString:receivedWOEID];
    
    DLog(@"%@", yweatherQuery);
    
    // Create the request.
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:yweatherQuery] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    // create the connection with the request
    // and start loading the data
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (theConnection) {
        // Create the NSMutableData to hold the received data.
        // receivedData is an instance variable declared elsewhere.
        receivedData = [NSMutableData data];
    } else {
        // Inform the user that the connection failed.
    }
    
    DLog(@"gotWOEIDdata end");
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receivedData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    receivedData = nil;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if (receivedData == nil) {
        [mAfterRecieveDataDelegate gotWeatherInfo:nil];
        return;
    }
    
    NSError* error;
    TBXML* tbxml = [TBXML newTBXMLWithXMLData:receivedData error:&error];
    if (error) {
        NSLog(@"%@ %@", [error localizedDescription], [error userInfo]);
        return;
    }
    TBXMLElement* rootElement = tbxml.rootXMLElement;
    
    mResultElement = nil;
    mSearchTagName = TAG_TITLE;
    [self searchElementByNameFrom:rootElement];
    
    WeatherInfo* weatherInfo = [self parseXML:mResultElement];
    [mAfterRecieveDataDelegate gotWeatherInfo:weatherInfo];
}

- (void) searchElementByNameFrom:(TBXMLElement *)element {
    if (mResultElement != nil) {
        return;
    }
    do {
        // Display the name of the element
        //        NSLog(@"%@",[TBXML elementName:element]);
        //        NSLog(@"%@",[TBXML textForElement:element]);
        if ([[TBXML elementName:element] isEqualToString: mSearchTagName]) {
            mResultElement = element;
            return;
        }
        
        // Obtain first attribute from element
        TBXMLAttribute * attribute = element->firstAttribute;
        
        // if attribute is valid
        while (attribute) {
            // Display name and value of attribute to the log window
            //            NSLog(@"%@->%@ = %@",  [TBXML elementName:element],
            //                  [TBXML attributeName:attribute],
            //                  [TBXML attributeValue:attribute]);
            
            // Obtain the next attribute
            attribute = attribute->next;
        }
        
        // if the element has child elements, process them
        if (element->firstChild)
            [self searchElementByNameFrom:element->firstChild];
        
        // Obtain next sibling element
    } while ((element = element->nextSibling));  
}

-(WeatherInfo *)parseXML:(TBXMLElement *) element {
    WeatherInfo* result = nil;
    if ([[TBXML textForElement:element] isEqualToString: YAHOO_WEATHER_ERROR]) {
        return result;
    }
    
    result = [[WeatherInfo alloc] init];
    
    result.mTitle = [TBXML textForElement:element];
    
    while ((element = element->nextSibling)) {
        if ([[TBXML elementName:element] isEqualToString: TAG_DISCRIPTION]) {
            result.mDescription = [TBXML textForElement:element];
        }
        if ([[TBXML elementName:element] isEqualToString: TAG_LANGUAGE]) {
            result.mLanguage = [TBXML textForElement:element];
        }
        if ([[TBXML elementName:element] isEqualToString: TAG_LAST_BUILD_DATE]) {
            result.mLastBuildDate = [TBXML textForElement:element];
        }
        if ([[TBXML elementName:element] isEqualToString: TAG_YWEATHER_LOCATION]) {
            TBXMLAttribute * attribute = element->firstAttribute;
            while (attribute) {
                if ([[TBXML attributeName:attribute] isEqualToString:TAG_LOCATION_CITY]) {
                    result.mLocationCity = [TBXML attributeValue:attribute];
                }
                if ([[TBXML attributeName:attribute] isEqualToString:TAG_LOCATION_REGION]) {
                    result.mLocationRegion = [TBXML attributeValue:attribute];
                }
                if ([[TBXML attributeName:attribute] isEqualToString:TAG_LOCATION_COUNTRY]) {
                    result.mLocationCountry = [TBXML attributeValue:attribute];
                }
                attribute = attribute->next;
            }
        }
        if ([[TBXML elementName:element] isEqualToString: TAG_YWEATHER_UNITS]) {
            TBXMLAttribute* attribute = element->firstAttribute;
            while (attribute) {
                if ([[TBXML attributeName:attribute] isEqualToString:TAG_UNITS_TEMPERATURE]) {
                    result.mUnitsTemperature = [TBXML attributeValue:attribute];
                }
                if ([[TBXML attributeName:attribute] isEqualToString:TAG_UNITS_DISTANCE]) {
                    result.mUnitsDistance = [TBXML attributeValue:attribute];
                }
                if ([[TBXML attributeName:attribute] isEqualToString:TAG_UNITS_PRESSURE]) {
                    result.mUnitsPressure = [TBXML attributeValue:attribute];
                }
                if ([[TBXML attributeName:attribute] isEqualToString:TAG_UNITS_SPEED]) {
                    result.mUnitsSpeed = [TBXML attributeValue:attribute];
                }
                attribute = attribute->next;
            }
        }
        if ([[TBXML elementName:element] isEqualToString: TAG_YWEATHER_WIND]) {
            TBXMLAttribute* attribute = element->firstAttribute;
            while (attribute) {
                if ([[TBXML attributeName:attribute] isEqualToString: TAG_WIND_CHILL]) {
                    result.mWindChill = [TBXML attributeValue:attribute];
                }
                if ([[TBXML attributeName:attribute] isEqualToString: TAG_WIND_DIRECTION]) {
                    result.mWindDirection = [TBXML attributeValue:attribute];
                }
                if ([[TBXML attributeName:attribute] isEqualToString: TAG_WIND_SPEED]) {
                    result.mWindSpeed = [TBXML attributeValue:attribute];
                }
                attribute = attribute->next;
            }
        }
        if ([[TBXML elementName:element] isEqualToString: TAG_YWEATHER_ATMOSPHERE]) {
            TBXMLAttribute* attribute = element->firstAttribute;
            while (attribute) {
                if ([[TBXML attributeName:attribute] isEqualToString: TAG_ATMOSPHERE_HUMIDITY]) {
                    result.mAtmosphereHumidity = [TBXML attributeValue:attribute];
                }
                if ([[TBXML attributeName:attribute] isEqualToString: TAG_ATMOSPHERE_PRESSURE]) {
                    result.mAtmospherePressure = [TBXML attributeValue:attribute];
                }
                if ([[TBXML attributeName:attribute] isEqualToString: TAG_ATMOSPHERE_RISING]) {
                    result.mAtmosphereRising = [TBXML attributeValue:attribute];
                }
                if ([[TBXML attributeName:attribute] isEqualToString: TAG_ATMOSPHERE_VISIBILITY]) {
                    result.mAtmosphereVisibility = [TBXML attributeValue:attribute];
                }
                attribute = attribute->next;
            }
        }
        if ([[TBXML elementName:element] isEqualToString: TAG_YWEATHER_ASTRONOMY]) {
            TBXMLAttribute* attribute = element->firstAttribute;
            while (attribute) {
                if ([[TBXML attributeName:attribute] isEqualToString: TAG_ASTRONOMY_SUNRISE]) {
                    result.mAstronomySunrise = [TBXML attributeValue:attribute];
                }
                if ([[TBXML attributeName:attribute] isEqualToString: TAG_ASTRONOMY_SUNSET]) {
                    result.mAstronomySunset = [TBXML attributeValue:attribute];
                }
                attribute = attribute->next;
            }
        }
        if ([[TBXML elementName:element] isEqualToString: TAG_ITEM]) {
            TBXMLElement* childElement = element->firstChild;
            do {
                if ([[TBXML elementName:childElement] isEqualToString: TAG_CONDITION_TITLE]) {
                    result.mConditionTitle = [TBXML textForElement:childElement];
                }
                if ([[TBXML elementName:childElement] isEqualToString: TAG_CONDITION_GEOLAT]) {
                    result.mConditionLat = [TBXML textForElement:childElement];
                }
                if ([[TBXML elementName:childElement] isEqualToString: TAG_CONDITION_GEOLONG]) {
                    result.mConditionLon = [TBXML textForElement:childElement];
                }
                if ([[TBXML elementName:childElement] isEqualToString: TAG_YWEATHER_CONDITION]) {
                    TBXMLAttribute* attribute = childElement->firstAttribute;
                    while (attribute) {
                        if ([[TBXML attributeName:attribute] isEqualToString: TAG_TEXT]) {
                            result.mCurrentText = [TBXML attributeValue:attribute];
                        }
                        if ([[TBXML attributeName:attribute] isEqualToString: TAG_CODE]) {
                            result.mCurrentCode = [[TBXML attributeValue:attribute] intValue];
                        }
                        if ([[TBXML attributeName:attribute] isEqualToString: TAG_TEMP]) {
                            int t = [[TBXML attributeValue:attribute] intValue];
                            if ([result.mUnitsTemperature isEqualToString: @"F"]) {
                                result.mCurrentTempF = t;
                                result.mCurrentTempC = [self F2C:result.mCurrentTempF];
                            } else {
                                result.mCurrentTempC = t;
                                result.mCurrentTempF = [self C2F:result.mCurrentTempC];
                            }
                        }
                        if ([[TBXML attributeName:attribute] isEqualToString: TAG_DATE]) {
                            result.mCurrentConditionDate = [TBXML attributeValue:attribute];
                        }
                        attribute = attribute->next;
                    }
                }
                if ([[TBXML elementName:childElement] isEqualToString: TAG_YWEATHER_FORECAST] && mForecastCount == 1) {
                    mForecastCount++;
                    TBXMLAttribute* attribute = childElement->firstAttribute;
                    while (attribute) {
                        if ([[TBXML attributeName:attribute] isEqualToString: TAG_DAY]) {
                            result.mForecast1Day = [TBXML attributeValue:attribute];
                        }
                        if ([[TBXML attributeName:attribute] isEqualToString: TAG_DATE]) {
                            result.mForecast1Date = [TBXML attributeValue:attribute];
                        }
                        if ([[TBXML attributeName:attribute] isEqualToString: TAG_LOW]) {
                            int t = [[TBXML attributeValue:attribute] intValue];
                            if ([result.mUnitsTemperature isEqualToString: @"F"]) {
                                result.mForecast1TempLowF = t;
                                result.mForecast1TempLowC = [self F2C:result.mForecast1TempLowF];
                            } else {
                                result.mForecast1TempLowC = t;
                                result.mForecast1TempLowF = [self C2F:result.mForecast1TempLowC];
                            }                        }
                        if ([[TBXML attributeName:attribute] isEqualToString: TAG_HIGH]) {
                            int t = [[TBXML attributeValue:attribute] intValue];
                            if ([result.mUnitsTemperature isEqualToString: @"F"]) {
                                result.mForecast1TempHighF = t;
                                result.mForecast1TempHighC = [self F2C:result.mForecast1TempHighF];
                            } else {
                                result.mForecast1TempHighC = t;
                                result.mForecast1TempHighF = [self C2F:result.mForecast1TempHighC];
                            }
                        }
                        if ([[TBXML attributeName:attribute] isEqualToString: TAG_CODE]) {
                            result.mForecast1Code = [[TBXML attributeValue:attribute] intValue];
                        }
                        if ([[TBXML attributeName:attribute] isEqualToString: TAG_TEXT]) {
                            result.mForecast1Text = [TBXML attributeName:attribute];
                        }
                        attribute = attribute->next;
                    }
                }
            } while ((childElement = childElement->nextSibling));
        }
    }
    
    return result;
}

-(int) F2C:(int) tempInF {
    return (tempInF - 32) * 5 / 9;
}

-(int) C2F:(int) tempInC {
    return tempInC * 9 / 5 + 32;
}

@end
