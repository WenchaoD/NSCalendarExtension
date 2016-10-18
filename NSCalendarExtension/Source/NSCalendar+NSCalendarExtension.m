//
//  NSCalendar+NSCalendarExtension.m
//  NSCalendarExtension
//
//  Created by dingwenchao on 9/14/16.
//  Copyright © 2016 dingwenchao. All rights reserved.
//

#import "NSCalendar+NSCalendarExtension.h"
#import "NSCalendarExtensionControlCenter.h"
#import <objc/runtime.h>

#if __NSCALENDAR_ALLOWS_COMPILE_INJECTING

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Private interface

NSLock * __ns_get_lazy_components_lock() {
    static NSLock *lock;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lock = [[NSLock alloc] init];
    });
    return lock;
}

NSDateComponents * __ns_get_lazy_components() {
    static NSDateComponents *components;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        components = [[NSDateComponents alloc] init];
    });
    return components;
}

// Combine all larger units together from the lowest. All the unit parsed in must be valid
void __ns_get_larger_units_and_keys(id self, SEL _cmd, NSCalendarUnit unit, NSCalendarUnit *allLargerUnits, NSArray<NSString *> **keys) {
    
    // Find the lowest unit
    NSCalendarUnit unitFlag = unit;
    for (int i = 15; i >= 1; i--) {
        if (i == 8) continue;
        NSCalendarUnit u = 1UL << i;
        if (unitFlag & u) {
            unitFlag = u;
            break;
        }
        if (i == 1) {
            unitFlag = NSCalendarUnitNanosecond;
        }
    }
    
    __block NSUInteger largerUnits = 0;
    __weak NSDictionary<NSNumber *, NSString *> *keyDictionary = __ns_get_lazy_key_dictionary();
    __weak NSDictionary<NSNumber *, NSArray<NSNumber *> *> *largerDictionary = __ns_get_lazy_larger_dictionary();
    NSArray<NSNumber *> *largerArray = largerDictionary[@(unitFlag)];
    NSMutableArray<NSString *> *mutableKeys = [NSMutableArray arrayWithCapacity:largerArray.count];
    [largerArray enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *key = keyDictionary[obj];
        [mutableKeys addObject:key];
        largerUnits |= obj.unsignedIntegerValue;
    }];
    
    *keys = mutableKeys.copy; // Immutable
    *allLargerUnits = largerUnits; // Get the result data
}

#pragma mark - Public interfaces

/**
 * + (nullable NSCalendar *)calendarWithIdentifier:(NSString *)calendarIdentifier;
 */
NSCalendar * _Nullable __ns_calendarWithIdentifier(id self, SEL _cmd, NSString * calendarIdentigier) {
    return [[self alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
}

/**
 * - (nullable NSDate *)dateWithEra:(NSInteger)eraValue year:(NSInteger)yearValue month:(NSInteger)monthValue day:(NSInteger)dayValue hour:(NSInteger)hourValue minute:(NSInteger)minuteValue second:(NSInteger)secondValue nanosecond:(NSInteger)nanosecondValue;
 */
NSDate * _Nullable __ns_dateWithEra_year_month_day_hour_minute_second_nanosecond(id self, SEL _cmd, NSInteger eraValue, NSInteger yearValue, NSInteger monthValue, NSInteger dayValue, NSInteger hourValue, NSInteger minuteValue, NSInteger secondValue, NSInteger nanosecondValue) {
    __weak NSLock *lock = __ns_get_lazy_components_lock();
    __weak NSDateComponents *components = __ns_get_lazy_components();
    [lock lock];
    components.era = eraValue;
    components.year = yearValue;
    components.month = monthValue;
    components.day = dayValue;
    components.hour = hourValue;
    components.minute = minuteValue;
    components.second = secondValue;
    components.nanosecond = nanosecondValue;
    NSDate *date = [self dateFromComponents:components];
    components.era = NSIntegerMax;
    components.year = NSIntegerMax;
    components.month = NSIntegerMax;
    components.day = NSIntegerMax;
    components.hour = NSIntegerMax;
    components.minute = NSIntegerMax;
    components.second = NSIntegerMax;
    components.nanosecond = NSIntegerMax;
    [lock unlock];
    return date;
}

/*
 * - (nullable NSDate *)dateWithEra:(NSInteger)eraValue yearForWeekOfYear:(NSInteger)yearValue weekOfYear:(NSInteger)weekValue weekday:(NSInteger)weekdayValue hour:(NSInteger)hourValue minute:(NSInteger)minuteValue second:(NSInteger)secondValue nanosecond:(NSInteger)nanosecondValue;
 */
NSDate * _Nullable __ns_dateWithEra_yearForWeekOfYear_weekOfYear_weekday_hour_minute_second_nanosecond(id self, SEL _cmd, NSInteger eraValue, NSInteger yearValue, NSInteger weekValue, NSInteger weekdayValue, NSInteger hourValue, NSInteger minuteValue, NSInteger secondValue, NSInteger nanosecondValue) {
    __weak NSLock *lock = __ns_get_lazy_components_lock();
    __weak NSDateComponents *components = __ns_get_lazy_components();
    [lock lock];
    components.era = eraValue;
    components.yearForWeekOfYear = yearValue;
    components.weekOfYear = weekValue;
    components.weekday = weekdayValue;
    components.hour = hourValue;
    components.minute = minuteValue;
    components.second = secondValue;
    components.nanosecond = nanosecondValue;
    NSDate *date = [self dateFromComponents:__ns_get_lazy_components()];
    components.era = NSIntegerMax;
    components.yearForWeekOfYear = NSIntegerMax;
    components.weekOfYear = NSIntegerMax;
    components.weekday = NSIntegerMax;
    components.hour = NSIntegerMax;
    components.minute = NSIntegerMax;
    components.second = NSIntegerMax;
    components.nanosecond = NSIntegerMax;
    [lock unlock];
    return date;
}

/**
 * - (nullable NSDate *)dateBySettingUnit:(NSCalendarUnit)unit value:(NSInteger)v ofDate:(NSDate *)date options:(NSCalendarOptions)opts;
 */
NSDate * _Nullable __ns_dateBySettingUnit_value_ofDate_options(id self, SEL _cmd, NSCalendarUnit unit, NSInteger v, NSDate *date, NSCalendarOptions options) {
    NSDateComponents *components = [self components:NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:date];
    [components setValue:v forComponent:unit];
    NSDate *result = [self dateFromComponents:components];
    // Options
    return result;
}


/**
 * - (nullable NSDate *)dateBySettingHour:(NSInteger)h minute:(NSInteger)m second:(NSInteger)s ofDate:(NSDate *)date options:(NSCalendarOptions)opts;
 */
NSDate * _Nullable __ns_dateBySettingHour_minute_second_ofDate_options(id self, SEL _cmd, NSInteger hour, NSInteger minute, NSInteger second, NSDate *date, NSCalendarOptions options) {
    NSDateComponents *components = [self components:NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:date];
    components.hour = hour;
    components.minute = minute;
    components.second = second;
    NSDate *result = [self dateFromComponents:components];
    // Options
    return result;
}

/**
 * - (NSDate *)dateByAddingUnit:(NSCalendarUnit)unit value:(NSInteger)value toDate:(NSDate *)date options:(NSCalendarOptions)options;
 */
NSDate  * _Nullable __ns_dateByAddingUnit_value_toDate_options(id self, SEL _cmd, NSCalendarUnit unit, NSInteger value, NSDate * date, NSCalendarOptions options) {
    __weak NSDictionary<NSNumber *, NSString *> *keyDictionary = __ns_get_lazy_key_dictionary();
    NSString *key = keyDictionary[@(unit)];
    if (key) {
        __weak NSLock *lock = __ns_get_lazy_components_lock();
        __weak NSDateComponents *components = __ns_get_lazy_components();
        [lock lock];
        [components setValue:@(value) forKey:key];
        NSDate * newDate = [self dateByAddingComponents:__ns_get_lazy_components() toDate:date options:options];
        [components setValue:@(NSIntegerMax) forKey:key];
        [lock unlock];
        return newDate;
    }
    return date.copy;
}

/**
 * - (NSInteger)component:(NSCalendarUnit)component fromDate:(NSDate *)date;
 */
NSInteger __ns_component_from_date(id self, SEL _cmd, NSCalendarUnit component, NSDate * date) {
    __weak NSDictionary<NSNumber *, NSString *> *keyDictionary = __ns_get_lazy_key_dictionary();
    NSString *key = keyDictionary[@(component)];
    if (key.length) {
        NSDateComponents *components = [self components:component fromDate:date];
        id result = [components valueForKey:key];
        NSInteger value = [result respondsToSelector:@selector(integerValue)] ? [result integerValue] : -1;
        return value;
    }
    return -1;
}

/**
 * - (BOOL)isDate:(NSDate *)date1 inSameDayAsDate:(NSDate *)date2;
 */
BOOL __ns_isDate_inSameDayAsDate(id self, SEL _cmd, NSDate * date1, NSDate * date2) {
    NSCalendarUnit unitFlat = NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *c1 = [self components:unitFlat fromDate:date1];
    NSDateComponents *c2 = [self components:unitFlat fromDate:date2];
    return c1.era==c2.era && c1.year==c2.year && c1.month==c2.month && c1.day==c2.day;
}

/**
 * - (BOOL)isDateInToday:(NSDate *)date;
 */
BOOL __ns_isDateInToday(id self, SEL _cmd, NSDate * date) {
    NSCalendarUnit unitFlat = NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *c1 = [self components:unitFlat fromDate:date];
    NSDateComponents *c2 = [self components:unitFlat fromDate:[NSDate date]];
    return c1.era==c2.era && c1.year==c2.year && c1.month==c2.month && c1.day==c2.day;
}

/**
 * - (BOOL)isDateInYesterday:(NSDate *)date
 */
BOOL __ns_isDateInYesterday(id self, SEL _cmd, NSDate * date) {
    NSCalendarUnit unitFlat = NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *c1 = [self components:unitFlat fromDate:date];
    NSDateComponents *c2 = [self components:unitFlat fromDate:[NSDate date]];
    return c1.era==c2.era && c1.year==c2.year && c1.month==c2.month && c1.day==c2.day-1;
}

/**
 * - (BOOL)isDateInTomorrow:(NSDate *)date
 */
BOOL __ns_isDateInTomorrow(id self, SEL _cmd, NSDate * date) {
    NSCalendarUnit unitFlat = NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *c1 = [self components:unitFlat fromDate:date];
    NSDateComponents *c2 = [self components:unitFlat fromDate:[NSDate date]];
    return c1.era==c2.era && c1.year==c2.year && c1.month==c2.month && c1.day==c2.day+1;
}


/**
 * - (BOOL)isDateInWeekend:(NSDate *)date;
 */
BOOL __ns_isDateInWeekend(id self, SEL _cmd, NSDate * date) {
    NSRange weekdayRange = [self maximumRangeOfUnit:NSCalendarUnitWeekday];
    NSDateComponents *components = [self components:NSCalendarUnitWeekday fromDate:date];
    NSUInteger weekdayOfDate = components.weekday;
    BOOL weekend = weekdayOfDate == weekdayRange.location || weekdayOfDate == weekdayRange.length;
    return weekend;
}

/**
 * - (NSComparisonResult)compareDate:(NSDate *)date toDate:(NSDate *)date toUnitGranularity:(NSCalendarUnit)unit;
 */
NSComparisonResult __ns_compareDate_toDate_toUnitGranularity(id self, SEL _cmd, NSDate * date1, NSDate * date2, NSCalendarUnit unit) {
    
    NSArray<NSString *> *allLargerKeys;
    NSCalendarUnit allLargerUnits;
    __ns_get_larger_units_and_keys(self, _cmd, unit, &allLargerUnits, &allLargerKeys);
    
    if (allLargerKeys.count) {
        NSDateComponents *c1 = [self components:allLargerUnits fromDate:date1];
        NSDateComponents *c2 = [self components:allLargerUnits fromDate:date2];
        __block NSInteger result = NSNotFound;
        [allLargerKeys.reverseObjectEnumerator.allObjects enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSInteger i1 = [[c1 valueForKey:obj] integerValue];
            NSInteger i2 = [[c2 valueForKey:obj] integerValue];
            NSInteger i = i2 - i1;
            if (i != 0) {
                result = -i/ABS(i);
                *stop = YES;
            }
        }];
        if (result == NSNotFound) result = 0;
        return (NSComparisonResult)result;
    }
    return [date1 compare:date2]; // Bottom protection
}

/**
 * - (BOOL)isDate:(NSDate *)date1 equalToDate:(NSDate *)date2 toUnitGranularity:(NSCalendarUnit)unit;
 */
BOOL __ns_isDate_equalToDate_toUnitGranularity(id self, SEL _cmd, NSDate * date1, NSDate * date2, NSCalendarUnit unit) {
    return __ns_compareDate_toDate_toUnitGranularity(self, _cmd, date1, date2, unit) == NSOrderedSame;
}

NS_ASSUME_NONNULL_END

@implementation NSCalendar (NSCalendarExtension)

+ (void)load
{
    if (__ns_allows_runtime_injecting()) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [self __ns_forceInjecting];
        });
    }
}

+ (void)__ns_forceInjecting
{
    __ns_inject_function(object_getClass(self), @selector(calendarWithIdentifier:), __ns_calendarWithIdentifier);
    __ns_inject_function(self, @selector(component:fromDate:), __ns_component_from_date);
    __ns_inject_function(self, @selector(dateBySettingUnit:value:ofDate:options:), __ns_dateBySettingUnit_value_ofDate_options);
    __ns_inject_function(self, @selector(dateBySettingHour:minute:second:ofDate:options:), __ns_dateBySettingHour_minute_second_ofDate_options);
    __ns_inject_function(self, @selector(dateByAddingUnit:value:toDate:options:), __ns_dateByAddingUnit_value_toDate_options);
    __ns_inject_function(self, @selector(compareDate:toDate:toUnitGranularity:),__ns_compareDate_toDate_toUnitGranularity);
    __ns_inject_function(self, @selector(isDate:equalToDate:toUnitGranularity:), __ns_isDate_equalToDate_toUnitGranularity);
    __ns_inject_function(self, @selector(dateWithEra:year:month:day:hour:minute:second:nanosecond:),__ns_dateWithEra_year_month_day_hour_minute_second_nanosecond);
    __ns_inject_function(self, @selector(dateWithEra:yearForWeekOfYear:weekOfYear:weekday:hour:minute:second:nanosecond:),__ns_dateWithEra_yearForWeekOfYear_weekOfYear_weekday_hour_minute_second_nanosecond);
    __ns_inject_function(self, @selector(isDate:inSameDayAsDate:), __ns_isDate_inSameDayAsDate);
    __ns_inject_function(self, @selector(isDateInToday:), __ns_isDateInToday);
    __ns_inject_function(self, @selector(isDateInTomorrow:), __ns_isDateInTomorrow);
    __ns_inject_function(self, @selector(isDateInYesterday:), __ns_isDateInYesterday);
    __ns_inject_function(self, @selector(isDateInWeekend:), __ns_isDateInWeekend);
}

@end

#endif

