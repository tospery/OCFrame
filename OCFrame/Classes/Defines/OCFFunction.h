//
//  OCFFunction.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#ifndef OCFFunction_h
#define OCFFunction_h

#import <QMUIKit/QMUIKit.h>
#import "OCFType.h"

#define IS_SMALL_SCREEN         (DEVICE_WIDTH <= 320)
#define IS_MIDDLE_SCREEN        (DEVICE_WIDTH > 320 && DEVICE_WIDTH < 414)
#define IS_LARGE_SCREEN         (DEVICE_WIDTH >= 414)

#pragma mark - 本地化
#ifdef OCFEnableFuncLocalize
#define OCFT(local, display)                 (local)
#else
#define OCFT(local, display)                 (display)
#endif

#pragma mark - 便捷方法
#define OCFRandomNumber(x, y)                ((NSInteger)((x) + (arc4random() % ((y) - (x) + 1))))

#pragma mark - 日志
#ifdef DEBUG
#define OCFLogVerbose(fmt, ...)                                                                 \
NSLog(@"Verbose: " fmt, ##__VA_ARGS__);
#define OCFLogDebug(fmt, ...)                                                                   \
NSLog(@"Debug: " fmt, ##__VA_ARGS__);
#define OCFLogInfo(fmt, ...)                                                                    \
NSLog(@"Info: " fmt, ##__VA_ARGS__);
#define OCFLogWarn(fmt, ...)                                                                    \
NSLog(@"Warn: " fmt, ##__VA_ARGS__);
#define OCFLogError(fmt, ...)                                                                   \
NSLog(@"Error: " fmt, ##__VA_ARGS__);
#else
#define OCFLogVerbose(fmt, ...)
#define OCFLogDebug(fmt, ...)
#define OCFLogInfo(fmt, ...)                                                                    \
NSLog(@"Info: " fmt, ##__VA_ARGS__);
#define OCFLogWarn(fmt, ...)                                                                    \
NSLog(@"Warn: " fmt, ##__VA_ARGS__);
#define OCFLogError(fmt, ...)                                                                   \
NSLog(@"Error: " fmt, ##__VA_ARGS__);
#endif

#pragma mark - 尺寸
#define OCFCheck(arg)                          \
if (OCFDataIsNullOrEmpty(arg)) {                          \
return;                                                 \
}
#define OCFCheckWithResult(arg, ret)                                                                          \
if (OCFDataIsNullOrEmpty(arg)) {                                                                    \
return ret;                                                                                         \
}

#pragma mark - 尺寸
CG_INLINE CGFloat
OCFMetric(CGFloat value) {
    return flat(value / 375.f * DEVICE_WIDTH);
}

CG_INLINE CGFloat
OCFPrefer(CGFloat small, CGFloat middle, CGFloat large) {
    return flat(IS_SMALL_SCREEN ? small : (IS_MIDDLE_SCREEN ? middle : large));
}

CG_INLINE CGFloat
OCFScale(CGFloat value) {
    return flat(value * DEVICE_WIDTH);
}

#pragma mark - 通知
CG_INLINE void
OCFAddObserver(NSString *name, id observer, SEL selector, id object) {
    [NSNotificationCenter.defaultCenter addObserver:observer selector:selector name:name object:object];
}

CG_INLINE void
OCFNotify(NSString *notificationName, id object, NSDictionary *userInfo) {
    [NSNotificationCenter.defaultCenter postNotificationName:notificationName object:object userInfo:userInfo];
}

CG_INLINE void
OCFRemoveObserver(id observer) {
    [NSNotificationCenter.defaultCenter removeObserver:observer];
}

#pragma mark - 默认
CG_INLINE BOOL
OCFBoolWithDft(BOOL value, BOOL dft) {
    if (value == NO) {
        return dft;
    }
    return value;
}

CG_INLINE NSInteger
OCFIntWithDft(NSInteger value, NSInteger dft) {
    if (value == 0) {
        return dft;
    }
    return value;
}

CG_INLINE id
OCFObjWithDft(id value, id dft) {
    if (value == nil || [value isKindOfClass:[NSNull class]]) {
        return dft;
    }
    return value;
}

CG_INLINE NSString *
OCFStrWithDft(NSString *value, NSString *dft) {
    if (![value isKindOfClass:[NSString class]]) {
        return dft;
    }
    if (value.length == 0) {
        return dft;
    }
    return value;
}

CG_INLINE NSArray *
OCFArrWithDft(NSArray *value, NSArray *dft) {
    if (![value isKindOfClass:[NSArray class]]) {
        return dft;
    }
    if (value.count == 0) {
        return dft;
    }
    return value;
}

CG_INLINE BOOL
OCFDataIsNullOrEmpty(id obj) {
    if (!obj) {
        return YES;
    }
    if ([obj isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([obj isKindOfClass:[NSString class]]) {
        NSString *string = (NSString *)obj;
        return string.length == 0 ? YES : NO;
    }
    if ([obj isKindOfClass:[NSNumber class]]) {
        NSNumber *number = (NSNumber *)obj;
        return number.integerValue == 0 ? YES : NO;
    }
    if ([obj isKindOfClass:[NSArray class]]) {
        NSArray *array = (NSArray *)obj;
        return array.count == 0 ? YES : NO;
    }
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = (NSDictionary *)obj;
        return dictionary.count == 0 ? YES : NO;
    }
    return NO;
}

CG_INLINE BOOL
OCFConvertToBool(id obj) {
    if ([obj isKindOfClass:NSNumber.class]) {
        return [(NSNumber *)obj boolValue];
    }
    if ([obj isKindOfClass:NSString.class]) {
        return [(NSString *)obj integerValue] != 0 ? YES : NO;
    }
    return NO;
}

#endif /* OCFFunction_h */
