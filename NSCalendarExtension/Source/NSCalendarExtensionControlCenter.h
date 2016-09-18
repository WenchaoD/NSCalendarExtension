//
//  NSCalendarExtensionControlCenter.h
//  NSCalendarExtension
//
//  Created by dingwenchao on 9/15/16.
//  Copyright © 2016 dingwenchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

static inline NSDictionary <NSNumber *, NSArray<NSNumber *> *> * __ns_get_lazy_larger_dictionary() {
    static dispatch_once_t onceToken;
    static NSDictionary *dictionary;
    dispatch_once(&onceToken, ^{
        dictionary = @{
                       @(NSCalendarUnitEra) :
                           @[@(NSCalendarUnitEra)],
                       @(NSCalendarUnitYear) :
                           @[@(NSCalendarUnitEra),
                             @(NSCalendarUnitYear)],
                       @(NSCalendarUnitMonth) :
                           @[@(NSCalendarUnitEra),
                             @(NSCalendarUnitYear),
                             @(NSCalendarUnitMonth)],
                       @(NSCalendarUnitDay) :
                           @[@(NSCalendarUnitEra),
                             @(NSCalendarUnitYear),
                             @(NSCalendarUnitMonth),
                             @(NSCalendarUnitDay)],
                       @(NSCalendarUnitHour) :
                           @[@(NSCalendarUnitEra),
                             @(NSCalendarUnitYear),
                             @(NSCalendarUnitMonth),
                             @(NSCalendarUnitDay),
                             @(NSCalendarUnitHour)],
                       @(NSCalendarUnitMinute) :
                           @[@(NSCalendarUnitEra),
                             @(NSCalendarUnitYear),
                             @(NSCalendarUnitMonth),
                             @(NSCalendarUnitDay),
                             @(NSCalendarUnitHour),
                             @(NSCalendarUnitMinute)],
                       @(NSCalendarUnitSecond) :
                           @[@(NSCalendarUnitEra),
                             @(NSCalendarUnitYear),
                             @(NSCalendarUnitMonth),
                             @(NSCalendarUnitDay),
                             @(NSCalendarUnitHour),
                             @(NSCalendarUnitMinute),
                             @(NSCalendarUnitSecond)],
                       @(NSCalendarUnitWeekday) :
                           @[@(NSCalendarUnitEra),
                             @(NSCalendarUnitYearForWeekOfYear),
                             @(NSCalendarUnitWeekOfYear),
                             @(NSCalendarUnitWeekday)],
                       @(NSCalendarUnitWeekdayOrdinal) :
                           @[@(NSCalendarUnitEra),
                             @(NSCalendarUnitYearForWeekOfYear),
                             @(NSCalendarUnitWeekOfYear),
                             @(NSCalendarUnitWeekdayOrdinal)],
                       @(NSCalendarUnitQuarter) :
                           @[@(NSCalendarUnitEra),
                             @(NSCalendarUnitYear),
                             @(NSCalendarUnitQuarter)],
                       @(NSCalendarUnitWeekOfMonth) :
                           @[@(NSCalendarUnitEra),
                             @(NSCalendarUnitYear),
                             @(NSCalendarUnitMonth),
                             @(NSCalendarUnitWeekOfMonth)],
                       @(NSCalendarUnitWeekOfYear) :
                           @[@(NSCalendarUnitEra),
                             @(NSCalendarUnitYearForWeekOfYear),
                             @(NSCalendarUnitWeekOfYear)],
                       @(NSCalendarUnitYearForWeekOfYear) :                                     @[@(NSCalendarUnitEra),
                           @(NSCalendarUnitYearForWeekOfYear)],
                       @(NSCalendarUnitNanosecond) :
                           @[@(NSCalendarUnitEra),
                             @(NSCalendarUnitYear),
                             @(NSCalendarUnitMonth),
                             @(NSCalendarUnitDay),
                             @(NSCalendarUnitHour),
                             @(NSCalendarUnitMinute),
                             @(NSCalendarUnitSecond),
                             @(NSCalendarUnitNanosecond)]
                       };
    });
    return dictionary;
}

static inline NSDictionary<NSNumber *, NSString *> *__ns_get_lazy_key_dictionary() {
    static dispatch_once_t onceToken;
    static NSDictionary *dictionary;
    dispatch_once(&onceToken, ^{
        dictionary = @{
                       @(NSCalendarUnitEra) : @"era",
                       @(NSCalendarUnitYear) : @"year",
                       @(NSCalendarUnitMonth) : @"month",
                       @(NSCalendarUnitDay) : @"day",
                       @(NSCalendarUnitHour) : @"hour",
                       @(NSCalendarUnitMinute) : @"minute",
                       @(NSCalendarUnitSecond) : @"second",
                       @(NSCalendarUnitWeekday) : @"weekday",
                       @(NSCalendarUnitWeekdayOrdinal) : @"weekdayOrdinal",
                       @(NSCalendarUnitQuarter) : @"quarter",
                       @(NSCalendarUnitWeekOfMonth) : @"weekOfMonth",
                       @(NSCalendarUnitWeekOfYear) : @"weekOfYear",
                       @(NSCalendarUnitYearForWeekOfYear) : @"yearForWeekOfYear",
                       @(NSCalendarUnitNanosecond) : @"nanosecond",
                      };
    });
    return dictionary;
}

static inline BOOL __ns_allows_runtime_injecting() {
    return [[UIDevice currentDevice].systemVersion compare:@"8.0"]==NSOrderedAscending &&
    [[UIDevice currentDevice].systemVersion compare:@"6.0"]!=NSOrderedAscending;
}

static inline void __ns_inject_function(Class cls, SEL selector, void *func) {
    // Try to add a new function. Usually succeed in NSCalendar but fail in NSDateComponents
    BOOL success = class_addMethod(cls, selector, (IMP)func, method_getTypeEncoding(class_getInstanceMethod(cls, selector)));
    if (!success) {
        // Already added but not well implemented, force overriding. Such as NSDateComponents.
        method_setImplementation(class_getInstanceMethod(cls, selector), (IMP)func);
    }
}

NS_ASSUME_NONNULL_END

#define __NSCALENDAR_ALLOWS_COMPILE_INJECTING (__IPHONE_OS_VERSION_MIN_REQUIRED < 80000 && __IPHONE_OS_VERSION_MAX_ALLOWED >= 60000)


