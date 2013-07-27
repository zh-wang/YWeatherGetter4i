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

+(WOEIDUtils*)getInstance {
    @synchronized([WOEIDUtils class]) {
        if(!_instance)
            _instance = [[self alloc] init];
        return _instance;
    }
}

-(void)queryWOEID:(NSString *)pPlaceName {
    DLog(@"queryWOEID start");
    NSMutableString* woeidRequestUrl = [NSMutableString stringWithUTF8String:[YAHOO_APIS_BASE UTF8String]];
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
//    resultString = [[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
//    return resultString;
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"%@", response);
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    DLog(@"");
    [receivedData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    receivedData = nil;
    DLog(@"");
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    DLog(@"");
    [mAfterReceiveDataDelegate gotWOEIDdata:receivedData];
}

@end
