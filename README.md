YfeatherGetter4i
================

An Yahoo Weather API wrapper for iOS

An Android version can be found here.    
[https://github.com/zh-wang/YfeatherGetter4a](https://github.com/zh-wang/YfeatherGetter4a)

It works on iOS 5.0 or above

+ What is this?
This is a wrapper for getting weather information from Yahoo Weather API, for iOS.

+ How do I use it?

First, implement YWeatherUtilsDelegate

    @interface ViewController : UIViewController <YWeatherUtilsDelegate>

Override the following delegate method

    - (void)gotWeatherInfo:(WeatherInfo *)weatherInfo {
        // Add your code here
    }

Second, use the following code to get weather inforamtion.

    YWeatherUtils* yweatherUtils = [YWeatherUtils getInstance];
    [yweatherUtils setMAfterRecieveDataDelegate: self];
    [yweatherUtils queryYahooWeather:@"Name of City or Area"];

Replace "Name of City or Area" to what you want.

+ What kind of weather information can I get?	
You can get current condition of weather, humidity, wind, etc.
And some forecast information for next two days.

Check the XML structure returned by Yahoo Weather API here.    
[http://weather.yahooapis.com/forecastrss?w=2459115](http://weather.yahooapis.com/forecastrss?w=2459115)

Developed By
================
Zhenghong Wang - <viennakanon@gmail.com>

License
================
    Copyright 2012 Zhenghong Wang

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
