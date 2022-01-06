//
//  OCFDefines.h
//  Pods
//
//  Created by liaoya on 2022/1/6.
//

#ifndef OCFDefines_h
#define OCFDefines_h

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CocoaLumberjack/CocoaLumberjack.h>
#import "NSObject+OCFCore.h"
#import "NSURL+OCFCore.h"
#import "NSDictionary+OCFCore.h"

#pragma mark - 类型
typedef void        (^OCFVoidBlock)(void);
typedef BOOL        (^OCFBoolBlock)(void);
typedef NSInteger   (^OCFIntBlock) (void);
typedef id          (^OCFIdBlock)  (void);

typedef void        (^OCFVoidBlock_bool)(BOOL);
typedef BOOL        (^OCFBoolBlock_bool)(BOOL);
typedef NSInteger   (^OCFIntBlock_bool) (BOOL);
typedef id          (^OCFIdBlock_bool)  (BOOL);

typedef void        (^OCFVoidBlock_int)(NSInteger);
typedef BOOL        (^OCFBoolBlock_int)(NSInteger);
typedef NSInteger   (^OCFIntBlock_int) (NSInteger);
typedef id          (^OCFIdBlock_int)  (NSInteger);

typedef void        (^OCFVoidBlock_string)(NSString *);
typedef BOOL        (^OCFBoolBlock_string)(NSString *);
typedef NSInteger   (^OCFIntBlock_string) (NSString *);
typedef id          (^OCFIdBlock_string)  (NSString *);

typedef void        (^OCFVoidBlock_id)(id);
typedef BOOL        (^OCFBoolBlock_id)(id);
typedef NSInteger   (^OCFIntBlock_id) (id);
typedef id          (^OCFIdBlock_id)  (id);

#pragma mark - 常量
#pragma mark Identifier
#define kOCFIdentifierTableCell                      (@"kOCFIdentifierTableCell")
#define kOCFIdentifierTableHeaderFooter              (@"kOCFIdentifierTableHeaderFooter")
#define kOCFIdentifierCollectionCell                 (@"kOCFIdentifierCollectionCell")
#define kOCFIdentifierCollectionHeader               (@"kOCFIdentifierCollectionHeader")
#define kOCFIdentifierCollectionFooter               (@"kOCFIdentifierCollectionFooter")

#pragma mark Scheme
#define kOCFSchemeHTTP                              (@"http")
#define kOCFSchemeAsset                             (@"asset")
#define kOCFSchemeFrame                             (@"frame")
#define kOCFSchemeResource                          (@"resource")
#define kOCFSchemeDocuments                         (@"documents")

#pragma mark Host
#define kOCFHostAny                                 (@"*")
#define kOCFHostToast                               (@"toast")
#define kOCFHostAlert                               (@"alert")
#define kOCFHostSheet                               (@"sheet")
#define kOCFHostPopup                               (@"popup")
#define kOCFHostLogin                               (@"login")
#define kOCFHostThirdparty                          (@"thirdparty")

#pragma mark Back
#define kOCFBackAuto                                (@"back")
#define kOCFBackPopone                              (@"back/popone")
#define kOCFBackPopall                              (@"back/popall")
#define kOCFBackDismiss                             (@"back/dismiss")
#define kOCFBackFadeaway                            (@"back/fadeaway")

#pragma mark Animation
//#define kOCFAnimationFade                           (@"fade")
//#define kOCFAnimationGrow                           (@"grow")
//#define kOCFAnimationShrink                         (@"shrink")
//#define kOCFAnimationSlide                          (@"slide")
//#define kOCFAnimationBounce                         (@"bounce")

#pragma mark Log
#define kOCFLogTagTest                              (@"Test")
#define kOCFLogTagNormal                            (@"Normal")
#define kOCFLogTagLibrary                           (@"Library")
#define kOCFLogTagArgument                          (@"Argument")

#pragma mark Convenient
#define kOCFFrameName                               (@"OCFrame")
#define kOCFBindObjectKey                           (@"kOCFBindObjectKey")
#define kOCFErrorResponse                           (@"kOCFErrorResponse")

#pragma mark - 函数
#pragma mark Log
#ifdef DEBUG
#define OCFLogVerbose(fmt, ...)                                                                 \
DDLogVerbose(@"Verbose: " fmt, ##__VA_ARGS__);
#define OCFLogDebug(fmt, ...)                                                                   \
DDLogDebug(@"Debug: " fmt, ##__VA_ARGS__);
#define OCFLogInfo(fmt, ...)                                                                    \
DDLogInfo(@"Info: " fmt, ##__VA_ARGS__);
#define OCFLogWarn(fmt, ...)                                                                    \
DDLogWarn(@"Warn: " fmt, ##__VA_ARGS__);
#define OCFLogError(fmt, ...)                                                                   \
DDLogError(@"Error: " fmt, ##__VA_ARGS__);
#else
#define OCFLogVerbose(fmt, ...)
#define OCFLogDebug(fmt, ...)
#define OCFLogInfo(fmt, ...)                                                                    \
DDLogInfo(@"Info: " fmt, ##__VA_ARGS__);
#define OCFLogWarn(fmt, ...)                                                                    \
DDLogWarn(@"Warn: " fmt, ##__VA_ARGS__);
#define OCFLogError(fmt, ...)                                                                   \
DDLogError(@"Error: " fmt, ##__VA_ARGS__);
#endif

#pragma mark Check
#define OCFCheck(arg)                                           \
if (OCFObjectIsNullOrEmpty(arg)) {                              \
return;                                                         \
}
#define OCFCheckWithResult(arg, ret)                            \
if (OCFObjectIsNullOrEmpty(arg)) {                              \
return ret;                                                     \
}

#pragma mark Random
#define OCFRandomNumber(x, y)                ((NSInteger)((x) + (arc4random() % ((y) - (x) + 1))))

#pragma mark Notification
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

#pragma mark Default
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

CG_INLINE id
OCFObjWithDft(id value, id dft) {
    if (value == nil || [value isKindOfClass:[NSNull class]]) {
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

#pragma mark With
CG_INLINE BOOL
OCFBoolWithObj(id obj) {
    if ([obj isKindOfClass:NSNumber.class]) {
        return [(NSNumber *)obj boolValue];
    }
    if ([obj isKindOfClass:NSString.class]) {
        return [(NSString *)obj integerValue] != 0 ? YES : NO;
    }
    return NO;
}

CG_INLINE NSInteger
OCFIntWithObj(id obj) {
    if ([obj isKindOfClass:NSNumber.class]) {
        return [(NSNumber *)obj integerValue];
    }
    if ([obj isKindOfClass:NSString.class]) {
        return [(NSString *)obj integerValue];
    }
    return 0;
}

CG_INLINE NSString *
OCFStrWithObj(id obj) {
    if ([obj isKindOfClass:NSString.class]) {
        return (NSString *)obj;
    }
    if ([obj isKindOfClass:NSNumber.class]) {
        return [(NSNumber *)obj stringValue];
    }
    return [obj ocf_JSONString];
}

#pragma mark Member
CG_INLINE BOOL
OCFBoolMember(NSDictionary *dict, NSString *key, BOOL dft) {
    if (!dict || ![dict isKindOfClass:NSDictionary.class] || !dict.count) {
        return dft;
    }
    return [dict ocf_numberForKey:key withDefault:@(dft)].boolValue;
}

CG_INLINE NSInteger
OCFIntMember(NSDictionary *dict, NSString *key, NSInteger dft) {
    if (!dict || ![dict isKindOfClass:NSDictionary.class] || !dict.count) {
        return dft;
    }
    return [dict ocf_numberForKey:key withDefault:@(dft)].integerValue;
}

CG_INLINE CGFloat
OCFFltMember(NSDictionary *dict, NSString *key, CGFloat dft) {
    if (!dict || ![dict isKindOfClass:NSDictionary.class] || !dict.count) {
        return dft;
    }
    return [dict ocf_numberForKey:key withDefault:@(dft)].floatValue;
}

CG_INLINE id
OCFObjMember(NSDictionary *dict, NSString *key, id dft) {
    if (!dict || ![dict isKindOfClass:NSDictionary.class] || !dict.count) {
        return dft;
    }
    return [dict ocf_objectForKey:key withDefault:dft];
}

CG_INLINE NSString *
OCFStrMember(NSDictionary *dict, NSString *key, NSString *dft) {
    if (!dict || ![dict isKindOfClass:NSDictionary.class] || !dict.count) {
        return dft;
    }
    return [dict ocf_stringForKey:key withDefault:dft];
}

CG_INLINE NSNumber *
OCFNumMember(NSDictionary *dict, NSString *key, id dft) {
    if (!dict || ![dict isKindOfClass:NSDictionary.class] || !dict.count) {
        return dft;
    }
    id value = OCFObjMember(dict, key, dft);
    if ([value isKindOfClass:NSNumber.class]) {
        return value;
    }else if ([value isKindOfClass:NSString.class]) {
        return @([(NSString *)value integerValue]);
    }
    return dft;
}

CG_INLINE NSArray *
OCFArrMember(NSDictionary *dict, NSString *key, NSArray *dft) {
    if (!dict || ![dict isKindOfClass:NSDictionary.class] || !dict.count) {
        return dft;
    }
    return [dict ocf_arrayForKey:key withDefault:dft];
}

CG_INLINE NSDictionary *
OCFDictMember(NSDictionary *dict, NSString *key, NSDictionary *dft) {
    if (!dict || ![dict isKindOfClass:NSDictionary.class] || !dict.count) {
        return dft;
    }
    return [dict ocf_dictionaryForKey:key withDefault:dft];
}

CG_INLINE NSURL *
OCFURLMember(NSDictionary *dict, NSString *key, NSURL *dft) {
    if (!dict || ![dict isKindOfClass:NSDictionary.class] || !dict.count) {
        return dft;
    }
    id value = OCFObjMember(dict, key, dft);
    if ([value isKindOfClass:NSURL.class]) {
        return value;
    }else if ([value isKindOfClass:NSString.class]) {
        return OCFObjWithDft(OCFURLWithStr(value), dft);
    }
    return dft;
}

#pragma mark Convenient
CG_INLINE BOOL
OCFObjectIsNullOrEmpty(id obj) {
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

#endif /* OCFDefines_h */
