//
//  WOEIDUtils.h
//  YWeatherGetter4iTest
//
//  Created by Wang Zhenghong on 2013/07/27.
//  Copyright (c) 2013年 wang zhenghong. All rights reserved.
//

#ifndef _WOEID_UTILS_H_
#define _WOEID_UTILS_H_

#import <Foundation/Foundation.h>
#import "YWeather4iConsts.h"
#import "WOEIDUtilsDelegate.h"

@interface WOEIDUtils : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>
@property (nonatomic, retain) NSMutableData* receivedData;
@property (nonatomic, assign) id mAfterReceiveDataDelegate;

+(WOEIDUtils*)getInstance;
-(void)queryWOEID:(NSString *)pPlaceName;

@end

#endif /* _WOEID_UTILS_H_ */