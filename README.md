# NSCalendarExtension

## Introduction

* Use high-level interfaces of **NSCalendar** and **NSDateComponents** in lower iOS version than iOS8

> The main purpose of this repo is to support [FSCalendar](https://github.com/WenchaoD/FSCalendar) with a `iOS7-compatibility`, but even if you didn't use it, you can also benefit with this repo and get rid of the `unrecognized selector` crash when you use these api **UNDER iOS8.0**.

```objc

// NSCalendar
@interface NSCalendar

 + (nullable NSCalendar *)calendarWithIdentifier:(NSString *)calendarIdentifier;
 
 - (nullable NSDate *)dateWithEra:(NSInteger)eraValue year:(NSInteger)yearValue month:(NSInteger)monthValue day:(NSInteger)dayValue hour:(NSInteger)hourValue minute:(NSInteger)minuteValue second:(NSInteger)secondValue nanosecond:(NSInteger)nanosecondValue;
 
 - (nullable NSDate *)dateWithEra:(NSInteger)eraValue yearForWeekOfYear:(NSInteger)yearValue weekOfYear:(NSInteger)weekValue weekday:(NSInteger)weekdayValue hour:(NSInteger)hourValue minute:(NSInteger)minuteValue second:(NSInteger)secondValue nanosecond:(NSInteger)nanosecondValue;
 
 - (NSDate *)dateByAddingUnit:(NSCalendarUnit)unit value:(NSInteger)value toDate:(NSDate *)date options:(NSCalendarOptions)options;
 
 - (NSInteger)component:(NSCalendarUnit)component fromDate:(NSDate *)date;
 
 - (BOOL)isDate:(NSDate *)date1 inSameDayAsDate:(NSDate *)date2;
 
 - (BOOL)isDateInToday:(NSDate *)date;
 
 - (BOOL)isDateInYesterday:(NSDate *)date;
 
 - (BOOL)isDateInTomorrow:(NSDate *)date;
 
 - (BOOL)isDateInWeekend:(NSDate *)date;
 
 - (NSComparisonResult)compareDate:(NSDate *)date toDate:(NSDate *)date toUnitGranularity:(NSCalendarUnit)unit;
 
 - (BOOL)isDate:(NSDate *)date1 equalToDate:(NSDate *)date2 toUnitGranularity:(NSCalendarUnit)unit;

@end

// NSDateComponents
@interface NSDateComponents

 - (void)setValue:(NSInteger)value forComponent:(NSCalendarUnit)unit;
 
 - (NSInteger)valueForComponent:(NSCalendarUnit)unit;
 
@end


```


## How to use
* Just drag files under `Source` folder into your project..

* Available in iOS6 and iOS7

> * As the implementations are injected with runtime techs, you **DON'T** have to do `#import`.
> * All testings are going under the Unit Test target.



