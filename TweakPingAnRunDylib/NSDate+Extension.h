//
//  NSData+Extension.h
//  OC-Test
//
//  Created by ZhiHua Shen on 2018/4/16.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

@property (nonatomic, readonly) NSInteger day;

+ (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format;

- (NSString *)stringWithFormat:(NSString *)format;

+ (BOOL)isModifyDateToday;

@end
