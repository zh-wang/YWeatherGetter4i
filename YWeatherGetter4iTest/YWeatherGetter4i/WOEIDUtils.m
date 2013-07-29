//
//  WOEIDUtils.m
//  YWeatherGetter4iTest
//
//  Created by Wang Zhenghong on 2013/07/27.
//  Copyright (c) 2013年 wang zhenghong. All rights reserved.
//

#import "WOEIDUtils.h"

static WOEIDUtils* _instance = nil;

@implementation WOEIDUtils

@synthesize receivedData;
@synthesize mAfterReceiveDataDelegate;
@synthesize mWOEIDelement;

+(WOEIDUtils*)getInstance {
    @synchronized([WOEIDUtils class]) {
        if(!_instance)
            _instance = [[self alloc] init];
        return _instance;
    }
}

-(void)queryWOEID:(NSString *)pPlaceName {
    DLog(@"queryWOEID start");
    NSMutableString* woeidRequestUrl = [NSMutableString stringWithUTF8String:[YAHOO_LOCATION_APIS_BASE UTF8String]];
    [woeidRequestUrl appendString:@"%22"];
    [woeidRequestUrl appendString:pPlaceName];
    [woeidRequestUrl appendString:@"%22"];
    [woeidRequestUrl appendString:YAHOO_APIS_FORMAT];
    
    DLog(@"%@", woeidRequestUrl);
    
    // Create the request.
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:woeidRequestUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
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
    DLog(@"queryWOEID end");
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receivedData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    receivedData = nil;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString* recievedWOEID = [self getFirstMatchingWOEID:receivedData];
    [mAfterReceiveDataDelegate gotWOEIDfromYahooAPIs:recievedWOEID];
}

-(NSString *)getFirstMatchingWOEID:(NSMutableData *)recievedData {
    NSError* error;
    TBXML* tbxml = [TBXML newTBXMLWithXMLData:receivedData error:&error];
    TBXMLElement* rootXMLElement = tbxml.rootXMLElement;
    if (error) {
        NSLog(@"%@ %@", [error localizedDescription], [error userInfo]);
        return WOEID_NOT_FOUND;
    }
    [self traverseElement:rootXMLElement];
    NSString* woeid = [TBXML textForElement:mWOEIDelement];
    return woeid;
}

- (void) traverseElement:(TBXMLElement *)element {
    if (mWOEIDelement != nil) {
        return;
    }
    do {
        // Display the name of the element
//        NSLog(@"%@",[TBXML elementName:element]);
//        NSLog(@"%@",[TBXML textForElement:element]);
        if ([[TBXML elementName:element] isEqualToString:@"woeid"]) {
            mWOEIDelement = element;
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
            [self traverseElement:element->firstChild];
        
        // Obtain next sibling element
    } while ((element = element->nextSibling));  
}

@end
