//
//  NSData+Extension.m
//  OC-Test
//
//  Created by ZhiHua Shen on 2018/4/16.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

- (BOOL)isToday {
    if (fabs(self.timeIntervalSinceNow) >= 60 * 60 * 24) return NO;
    return [NSDate new].day == self.day;
}

- (NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setLocale:[NSLocale currentLocale]];
    return [formatter stringFromDate:self];
}

+ (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter dateFromString:dateString];
}

- (NSInteger)day {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self] day];
}

+ (BOOL)isModifyDateToday {
    NSDate *modifyDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"mofidyDate"];
    if (modifyDate && [modifyDate isToday]) {
        return YES;
    }
    else {
        return NO;
    }
}

@end
