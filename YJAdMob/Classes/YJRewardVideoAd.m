//
//  YJRewardVideoAd.m
//  YJAdMob
//
//  Created by mac on 2021/2/8.
//

#import "YJRewardVideoAd.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/AdSupport.h>

@interface YJRewardVideoAd () <GADRewardedAdDelegate>

@property(nonatomic, strong) GADRewardedAd *rewardedAd;

@end

@implementation YJRewardVideoAd

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static YJRewardVideoAd *instance;
    dispatch_once(&onceToken, ^{
        instance = [YJRewardVideoAd new];
        GADMobileAds.sharedInstance.requestConfiguration.testDeviceIdentifiers = @[@"860d59e8b20518f9dd1c793249d743b9"];
        if (@available(iOS 14, *)) {
            [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
                [instance preload];
            }];
        } else {
            // Fallback on earlier versions
        }
    });
    return instance;
}

- (void)preload {
    self.rewardedAd = [self createAndLoadRewardedAd];
}

- (void)showFromViewController:(UIViewController *)viewController {
    if (self.rewardedAd.isReady) {
        [self.rewardedAd presentFromRootViewController:viewController delegate:self];
    } else {
        [self preload];
    }
}

#pragma mark - GADRewardedAdDelegate

/// Tells the delegate that the user earned a reward.
- (void)rewardedAd:(GADRewardedAd *)rewardedAd userDidEarnReward:(GADAdReward *)reward {
    // TODO: Reward the user.
    NSLog(@"rewardedAd:userDidEarnReward:");
}

/// Tells the delegate that the rewarded ad was presented.
- (void)rewardedAdDidPresent:(GADRewardedAd *)rewardedAd {
    NSLog(@"rewardedAdDidPresent:");
}

/// Tells the delegate that the rewarded ad failed to present.
- (void)rewardedAd:(GADRewardedAd *)rewardedAd didFailToPresentWithError:(NSError *)error {
    NSLog(@"rewardedAd:didFailToPresentWithError");
}

/// Tells the delegate that the rewarded ad was dismissed.
- (void)rewardedAdDidDismiss:(GADRewardedAd *)rewardedAd {
    NSLog(@"rewardedAdDidDismiss:");
    self.rewardedAd = [self createAndLoadRewardedAd];
}

#pragma mark - Private

- (GADRewardedAd *)createAndLoadRewardedAd {
    
    GADRewardedAd *rewardedAd = [[GADRewardedAd alloc]
      initWithAdUnitID:@"ca-app-pub-3940256099942544/1712485313"];
    GADRequest *request = [GADRequest request];
    [rewardedAd loadRequest:request completionHandler:^(GADRequestError * _Nullable error) {
        if (error) {
          // Handle ad failed to load case.
        } else {
          // Ad successfully loaded.
        }
    }];
    return rewardedAd;
}

@end
