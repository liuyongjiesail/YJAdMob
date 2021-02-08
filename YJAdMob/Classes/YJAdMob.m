//
//  YJAdMob.m
//  YJAdMob
//
//  Created by mac on 2021/2/8.
//

#import "YJAdMob.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

@implementation YJAdMob

+ (void)launchAdService {
    
    [[GADMobileAds sharedInstance] startWithCompletionHandler:nil];
    // 预加载
    [YJRewardVideoAd.sharedInstance preload];
}

@end
