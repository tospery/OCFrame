//
//  OCFFunction.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#ifndef OCFFunction_h
#define OCFFunction_h

#import <QMUIKit/QMUIKit.h>

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
NSLog(@"Verbose(%s, %d): " fmt, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define OCFLogDebug(fmt, ...)                                                                   \
NSLog(@"Debug(%s, %d): " fmt, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define OCFLogInfo(fmt, ...)                                                                    \
NSLog(@"Info(%s, %d): " fmt, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define OCFLogWarn(fmt, ...)                                                                    \
NSLog(@"Warn(%s, %d): " fmt, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define OCFLogError(fmt, ...)                                                                   \
NSLog(@"Error(%s, %d): " fmt, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define OCFLogVerbose(fmt, ...)
#define OCFLogDebug(fmt, ...)
#define OCFLogInfo(fmt, ...)                                                                    \
NSLog(@"Info(%s, %d): " fmt, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define OCFLogWarn(fmt, ...)                                                                    \
NSLog(@"Warn(%s, %d): " fmt, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define OCFLogError(fmt, ...)                                                                   \
NSLog(@"Error(%s, %d): " fmt, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#endif

#pragma mark - 尺寸
CG_INLINE CGFloat
OCFMetric(CGFloat value) {
    return flat(value / 375.f * DEVICE_WIDTH);
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


#endif /* OCFFunction_h */
