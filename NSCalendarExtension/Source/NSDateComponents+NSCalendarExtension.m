//
//  NSDateComponents+NSCalendarExtension.m
//  NSCalendarExtension
//
//  Created by dingwenchao on 9/15/16.
//  Copyright © 2016 dingwenchao. All rights reserved.
//

#import "NSDateComponents+NSCalendarExtension.h"
#import "NSCalendarExtensionControlCenter.h"
#import <objc/runtime.h>

#if __NSCALENDAR_ALLOWS_COMPILE_INJECTING

/**
 * - (void)setValue:(NSInteger)value forComponent:(NSCalendarUnit)unit;
 */
void __ns_setValue_forComponent(id self, SEL _cmd, NSInteger value, NSCalendarUnit unit) {
    __weak NSDictionary<NSNumber *, NSString *> *keyDictionary = __ns_get_lazy_key_dictionary();
    NSString *key = keyDictionary[@(unit)];
    if (key) [self setValue:@(value) forKey:key];
}

/**
 * - (NSInteger)valueForComponent:(NSCalendarUnit)unit;
 */
NSInteger __ns_valueForComponent(id self, SEL _cmd, NSCalendarUnit unit) {
    __weak NSDictionary<NSNumber *, NSString *> *keyDictionary = __ns_get_lazy_key_dictionary();
    NSString *key = keyDictionary[@(unit)];
    if (key) return [[self valueForKey:key] integerValue];
    return NSNotFound;
}

@implementation NSDateComponents (NSCalendarExtension)

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
    __ns_inject_function(self,@selector(setValue:forComponent:),__ns_setValue_forComponent);
    __ns_inject_function(self, @selector(valueForComponent:),__ns_valueForComponent);
}

@end

#endif
