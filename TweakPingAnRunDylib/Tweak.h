//
//  Tweak.h
//  TweakPingAnRun
//
//  Created by ZhiHua Shen on 2018/4/18.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PARSHomePageViewController: UIViewController

- (void)clickWithOnLineServiceBtn;

- (void)viewDidLoad;

@end

@interface PARSPedometerInfo: NSObject

@property(nonatomic) long long heartRate;
@property(nonatomic) long long integratedSteps;

- (long long)heartRate;

- (long long)integratedSteps;

@end


