//
//  OCFFunctions.h
//  Pods
//
//  Created by liaoya on 2022/1/7.
//

#ifndef OCFFunctions_h
#define OCFFunctions_h

#import <CoreGraphics/CoreGraphics.h>

#pragma mark - Notification
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

#pragma mark - Default
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

#pragma mark - With
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
    return nil; // [obj ocf_JSONString];
}

#pragma mark - Member
CG_INLINE NSNumber *
OCFNumMember(NSDictionary *dict, id key, NSNumber *dft) {
    if (!dict || ![dict isKindOfClass:NSDictionary.class] || !dict.count || !key) {
        return dft;
    }
    NSNumber *number = [dict objectForKey:key];
    if (!number) {
        return dft;
    }
    if (![number isKindOfClass:[NSNumber class]]) {
        if ([number isKindOfClass:[NSString class]]) {
            NSString *string = (NSString *)number;
            number = @(string.integerValue);
        } else {
            return dft;
        }
    }
    return number;
}

CG_INLINE BOOL
OCFBoolMember(NSDictionary *dict, id key, BOOL dft) {
    NSNumber *number = OCFNumMember(dict, key, nil);
    if (!number) {
        return dft;
    }
    return number.boolValue;
}

CG_INLINE NSInteger
OCFIntMember(NSDictionary *dict, id key, NSInteger dft) {
    NSNumber *number = OCFNumMember(dict, key, nil);
    if (!number) {
        return dft;
    }
    return number.integerValue;
}

CG_INLINE CGFloat
OCFFltMember(NSDictionary *dict, id key, CGFloat dft) {
    NSNumber *number = OCFNumMember(dict, key, nil);
    if (!number) {
        return dft;
    }
    return number.floatValue;
}

CG_INLINE NSString *
OCFStrMember(NSDictionary *dict, id key, NSString *dft) {
    if (!dict || ![dict isKindOfClass:NSDictionary.class] || !dict.count || !key) {
        return dft;
    }
    NSString *string = [dict objectForKey:key];
    if (!string) {
        return dft;
    }
    if (![string isKindOfClass:[NSString class]]) {
        if ([string isKindOfClass:[NSNumber class]]) {
            NSNumber *number = (NSNumber *)string;
            string = number.stringValue;
        } else {
            return dft;
        }
    }
    return string;
}

CG_INLINE id
OCFObjMember(NSDictionary *dict, id key, id dft) {
    if (!dict || ![dict isKindOfClass:NSDictionary.class] || !dict.count || !key) {
        return dft;
    }
    id object = [dict objectForKey:key];
    if (!object) {
        return dft;
    }
    return object;
}

CG_INLINE NSArray *
OCFArrMember(NSDictionary *dict, id key, NSArray *dft) {
    if (!dict || ![dict isKindOfClass:NSDictionary.class] || !dict.count || !key) {
        return dft;
    }
    NSArray *array = [dict objectForKey:key];
    if (!array || ![array isKindOfClass:[NSArray class]]) {
        return dft;
    }
    return array;
}

CG_INLINE NSDictionary *
OCFDictMember(NSDictionary *dict, id key, NSDictionary *dft) {
    if (!dict || ![dict isKindOfClass:NSDictionary.class] || !dict.count || !key) {
        return dft;
    }
    NSDictionary *dictionary = [dict objectForKey:key];
    if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]) {
        return dft;
    }
    return dictionary;
}

#pragma mark - Convenient
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

#endif /* OCFFunctions_h */
