//
//  WOEIDUtilsDelegate.h
//  YWeatherGetter4iTest
//
//  Created by Wang Zhenghong on 2013/07/27.
//  Copyright (c) 2013年 wang zhenghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WOEIDUtilsDelegate <NSObject>

-(NSString*)gotWOEIDdata:(NSMutableData*)receivedData;

@end
