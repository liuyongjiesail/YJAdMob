//
//  YJViewController.m
//  YJAdMob
//
//  Created by liuyongjie on 11/09/2020.
//  Copyright (c) 2020 liuyongjie. All rights reserved.
//

#import "YJViewController.h"
#import <YJAdMob/YJAdMob.h>

@interface YJViewController ()

@end

@implementation YJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [YJRewardVideoAd.sharedInstance showFromViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
