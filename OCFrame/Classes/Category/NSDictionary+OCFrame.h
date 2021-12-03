//
//  NSDictionary+OCFrame.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import <UIKit/UIKit.h>
#import "OCFFunction.h"
#import "NSURL+OCFrame.h"
#import "UIColor+OCFrame.h"

@interface NSDictionary (OCFrame)

- (NSString *)ocf_stringForKey:(id)key;
- (NSString *)ocf_stringForKey:(id)key withDefault:(NSString *)dft;
- (NSNumber *)ocf_numberForKey:(id)key;
- (NSNumber *)ocf_numberForKey:(id)key withDefault:(NSNumber *)dft;
- (NSArray *)ocf_arrayForKey:(id)key;
- (NSArray *)ocf_arrayForKey:(id)key withDefault:(NSArray *)dft;
- (NSDictionary *)ocf_dictionaryForKey:(id)key;
- (NSDictionary *)ocf_dictionaryForKey:(id)key withDefault:(NSDictionary *)dft;
- (id)ocf_objectForKey:(id)key;
- (id)ocf_objectForKey:(id)key withDefault:(id)dft;

- (NSDictionary *)ocf_dictionaryByUnderlineValuesFromCamel;

+ (NSDictionary *)ocf_dictionaryFromID:(id)data;

@end

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

CG_INLINE NSString *
OCFStrMember(NSDictionary *dict, NSString *key, NSString *dft) {
    if (!dict || ![dict isKindOfClass:NSDictionary.class] || !dict.count) {
        return dft;
    }
    return [dict ocf_stringForKey:key withDefault:dft];
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

CG_INLINE id
OCFObjMember(NSDictionary *dict, NSString *key, id dft) {
    if (!dict || ![dict isKindOfClass:NSDictionary.class] || !dict.count) {
        return dft;
    }
    return [dict ocf_objectForKey:key withDefault:dft];
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

CG_INLINE UIColor *
OCFColorMember(NSDictionary *dict, NSString *key, UIColor *dft) {
    if (!dict || ![dict isKindOfClass:NSDictionary.class] || !dict.count) {
        return dft;
    }
    id value = OCFObjMember(dict, key, dft);
    if ([value isKindOfClass:UIColor.class]) {
        return value;
    }else if ([value isKindOfClass:NSString.class]) {
        return OCFObjWithDft(OCFColorStr(value), dft);
    }
    return dft;
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
