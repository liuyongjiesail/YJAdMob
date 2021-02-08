//
//  YJRewardVideoAd.h
//  YJAdMob
//
//  Created by mac on 2021/2/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJRewardVideoAd : NSObject

+ (instancetype)sharedInstance;

- (void)preload;

- (void)showFromViewController:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
