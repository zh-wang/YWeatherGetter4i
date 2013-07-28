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
    
//    WeatherInfo* weatherInfo = [[WeatherInfo alloc] init];
//    weatherInfo.RESULT_STATUS = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
//    [mAfterRecieveDataDelegate gotWeatherInfo:weatherInfo];
    
    NSError* error;
    TBXML* tbxml = [TBXML newTBXMLWithXMLData:receivedData error:&error];
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
                if ([[TBXML attributeName:attribute] isEqualToString:TAG_CITY]) {
                    result.mLocationCity = [TBXML attributeValue:attribute];
                }
                if ([[TBXML attributeName:attribute] isEqualToString:TAG_REGION]) {
                    result.mLocationRegion = [TBXML attributeValue:attribute];
                }
                if ([[TBXML attributeName:attribute] isEqualToString:TAG_COUNTRY]) {
                    result.mLocationCountry = [TBXML attributeValue:attribute];
                }
                attribute = attribute->next;
            }
        }
    }
    
    return result;
}

@end
