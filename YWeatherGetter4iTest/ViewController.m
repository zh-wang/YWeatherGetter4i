//
//  ViewController.m
//  YWeatherGetter4iTest
//
//  Created by wang zhenghong on 13-7-23.
//  Copyright (c) 2013年 wang zhenghong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize mLabelWeatherInfo;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    YWeatherUtils* yweatherUtils = [YWeatherUtils getInstance];
    [yweatherUtils setMAfterRecieveDataDelegate: self];
    [yweatherUtils queryYahooWeather:@"Tokyo"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)gotWeatherInfo:(WeatherInfo *)receivedData {
    DLog(@"");
    [mLabelWeatherInfo setText: receivedData.RESULT_STATUS];
    DLog(@"%@", receivedData.RESULT_STATUS);
}

@end
