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

@interface YJRewardVideoAd () <GADFullScreenContentDelegate>

@property(nonatomic, strong) GADRewardedAd *rewardedAd;
@property(nonatomic, assign) BOOL isRewarded;
@property (copy, nonatomic) void(^tempComplete)(void);

@end

@implementation YJRewardVideoAd

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static YJRewardVideoAd *instance;
    dispatch_once(&onceToken, ^{
        instance = [YJRewardVideoAd new];
#ifdef DEBUG
        GADMobileAds.sharedInstance.requestConfiguration.testDeviceIdentifiers = @[@"860d59e8b20518f9dd1c793249d743b9"];
#else
#endif
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
    [GADRewardedAd loadWithAdUnitID:NSBundle.mainBundle.infoDictionary[@"GADRewardVideoAdUnitID"] request:[GADRequest request] completionHandler:^(GADRewardedAd * _Nullable rewardedAd, NSError * _Nullable error) {
        self.rewardedAd = rewardedAd;
        self.rewardedAd.fullScreenContentDelegate = self;
    }];
}

- (void)showFromViewController:(UIViewController *)viewController {
    [self showFromViewController:viewController complete:nil];
}

- (void)showFromViewController:(UIViewController *)viewController complete:(void(^ __nullable)(void))complete {
    self.tempComplete = complete;
    if ([self.rewardedAd canPresentFromRootViewController:viewController error:nil]) {
        [self.rewardedAd presentFromRootViewController:viewController userDidEarnRewardHandler:^{
            self.isRewarded = YES;
        }];
    } else {
        [self preload];
        if (complete) {
            complete();
        }
    }
}

#pragma mark - GADFullScreenContentDelegate

/// Tells the delegate that the user earned a reward.
- (void)adDidRecordImpression:(nonnull id<GADFullScreenPresentingAd>)ad {
    // TODO: Reward the user.
    NSLog(@"adDidRecordImpression:");
}

/// Tells the delegate that the rewarded ad was presented.
- (void)ad:(nonnull id<GADFullScreenPresentingAd>)ad didFailToPresentFullScreenContentWithError:(nonnull NSError *)error {
    NSLog(@"ad:didFailToPresentFullScreenContentWithError:");
}

/// Tells the delegate that the rewarded ad failed to present.
- (void)adDidPresentFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad {
    NSLog(@"adDidPresentFullScreenContent");
}

/// Tells the delegate that the rewarded ad was dismissed.
- (void)adDidDismissFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad {
    NSLog(@"adDidDismissFullScreenContent:");
    if (self.tempComplete && self.isRewarded) {
        self.tempComplete();
    }
    [self preload];
    self.isRewarded = NO;
}

@end
