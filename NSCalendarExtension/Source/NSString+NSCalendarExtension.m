//
//  NSString+NSCalendarExtension.m
//  NSCalendarExtension
//
//  Created by dingwenchao on 9/16/16.
//  Copyright © 2016 dingwenchao. All rights reserved.
//

#import "NSString+NSCalendarExtension.h"
#import "NSCalendarExtensionControlCenter.h"
#import <objc/runtime.h>

#if __NSCALENDAR_ALLOWS_COMPILE_INJECTING

NS_ASSUME_NONNULL_BEGIN

/**
 * - (BOOL)containsString:(NSString *)string;
 */
BOOL __ns_containsString(id self, SEL _cmd, NSString * _Nonnull string) {
    return [self rangeOfString:string].location != NSNotFound;
}

NS_ASSUME_NONNULL_END

@implementation NSString (NSCalendarExtension)

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
    __ns_inject_function(self, @selector(containsString:), __ns_containsString);
}

@end

#endif
