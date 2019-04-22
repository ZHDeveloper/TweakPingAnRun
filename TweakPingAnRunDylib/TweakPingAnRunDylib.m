//  weibo: http://weibo.com/xiaoqing28
//  blog:  http://www.alonemonkey.com
//
//  TweakPingAnRunDylib.m
//  TweakPingAnRunDylib
//
//  Created by ZhiHua Shen on 2018/4/18.
//  Copyright (c) 2018年 ZhiHua Shen. All rights reserved.
//

#import "TweakPingAnRunDylib.h"
#import <CaptainHook/CaptainHook.h>
#import <UIKit/UIKit.h>
#import <Cycript/Cycript.h>
#import "ModiyfDataViewController.h"
#import "NSDate+Extension.h"
#import "Tweak.h"

CHConstructor{
    NSLog(INSERT_SUCCESS_WELCOME);
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
#ifndef __OPTIMIZE__
        CYListenServer(6666);
#endif
        
    }];
}


CHDeclareClass(CustomViewController)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wstrict-prototypes"

//add new method
CHDeclareMethod1(void, CustomViewController, newMethod, NSString*, output){
    NSLog(@"This is a new method : %@", output);
}

#pragma clang diagnostic pop

CHOptimizedClassMethod0(self, void, CustomViewController, classMethod){
    NSLog(@"hook class method");
    CHSuper0(CustomViewController, classMethod);
}

CHOptimizedMethod0(self, NSString*, CustomViewController, getMyName){
    //get origin value
    NSString* originName = CHSuper(0, CustomViewController, getMyName);
    
    NSLog(@"origin name is:%@",originName);
    
    //get property
    NSString* password = CHIvar(self,_password,__strong NSString*);
    
    NSLog(@"password is %@",password);
    
    [self newMethod:@"output"];
    
    //set new property
    self.newProperty = @"newProperty";
    
    NSLog(@"newProperty : %@", self.newProperty);
    
    //change the value
    return @"AloneMonkey";
    
}

//add new property
CHPropertyRetainNonatomic(CustomViewController, NSString*, newProperty, setNewProperty);

CHDeclareClass(PARSSpecialHomeViewController)
CHOptimizedMethod(0, self, void, PARSSpecialHomeViewController,clickWithOnLineServiceBtn) {
    
    ModiyfDataViewController *vc = [ModiyfDataViewController new];
    UINavigationController *naviVC = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:naviVC animated:true completion:nil];
}

CHOptimizedMethod(0, self, void, PARSSpecialHomeViewController,viewDidLoad) {
    
    if (![NSDate isModifyDateToday]) {
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"stepCount"];
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"heartRate"];
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"是否修改步数、心率数据？" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            ModiyfDataViewController *vc = [ModiyfDataViewController new];
            UINavigationController *naviVC = [[UINavigationController alloc] initWithRootViewController:vc];
            [self presentViewController:naviVC animated:true completion:nil];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alertVC addAction:sureAction];
        [alertVC addAction:cancelAction];
        
        [self presentViewController:alertVC animated:YES completion:nil];
    }
    
    CHSuper0(PARSSpecialHomeViewController, viewDidLoad);
}

CHDeclareClass(PARSPedometerInfo)

CHOptimizedMethod(0, self, long long, PARSPedometerInfo,heartRate) {
    NSInteger heartRate = [[NSUserDefaults standardUserDefaults] integerForKey:@"heartRate"];
    if (![NSDate isModifyDateToday] || heartRate == 0) {
        return CHSuper0(PARSPedometerInfo, heartRate);
    }
    else {
        return heartRate;
    }
}

CHOptimizedMethod(0, self, long long, PARSPedometerInfo,integratedSteps) {
    
    NSInteger stepCount = [[NSUserDefaults standardUserDefaults] integerForKey:@"stepCount"];
    
    if (![NSDate isModifyDateToday] || stepCount == 0) {
        long long originStep = CHSuper0(PARSPedometerInfo, integratedSteps);
        return originStep;
    }
    else {
        return stepCount;
    }
}

CHConstructor{
    CHLoadLateClass(CustomViewController);
    CHClassHook0(CustomViewController, getMyName);
    CHClassHook0(CustomViewController, classMethod);
    
    CHHook0(CustomViewController, newProperty);
    CHHook1(CustomViewController, setNewProperty);
    
    CHLoadLateClass(PARSSpecialHomeViewController);
    CHClassHook(0, PARSSpecialHomeViewController, clickWithOnLineServiceBtn);
    CHClassHook(0, PARSSpecialHomeViewController, viewDidLoad);
    
    CHLoadLateClass(PARSPedometerInfo);
    CHClassHook(0, PARSPedometerInfo, heartRate);
    CHClassHook(0, PARSPedometerInfo, integratedSteps);
}

