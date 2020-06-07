//
//  NSDictionary+OCFrame.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "NSDictionary+OCFrame.h"
#import "NSObject+OCFrame.h"
#import "NSString+OCFrame.h"

@implementation NSDictionary (OCFrame)

- (NSString *)ocf_stringForKey:(id)key {
    return [self ocf_stringForKey:key withDefault:nil];
}

- (NSString *)ocf_stringForKey:(id)key withDefault:(NSString *)dft {
    if (!key) {
        return dft;
    }
    
    id string = [self objectForKey:key];
    if (!string || ![string isKindOfClass:[NSString class]]) {
        if ([string isKindOfClass:[NSNumber class]]) {
            NSNumber *number = (NSNumber *)string;
            if (number) {
                return number.stringValue;
            }
        }
        return dft;
    }
    
    return string;
}

- (NSNumber *)ocf_numberForKey:(id)key {
    return [self ocf_numberForKey:key withDefault:nil];
}

- (NSNumber *)ocf_numberForKey:(id)key withDefault:(NSNumber *)dft {
    if (!key) {
        return dft;
    }
    
    id number = [self objectForKey:key];
    if (!number || ![number isKindOfClass:[NSNumber class]]) {
        if ([number isKindOfClass:[NSString class]]) {
            NSString *string = (NSString *)number;
            if (string) {
                return @(string.integerValue);
            }
        }
        return dft;
    }
    
    return number;
}

- (NSArray *)ocf_arrayForKey:(id)key {
    return [self ocf_arrayForKey:key withDefault:nil];
}

- (NSArray *)ocf_arrayForKey:(id)key withDefault:(NSArray *)dft {
    if (!key) {
        return dft;
    }
    
    id array = [self objectForKey:key];
    if (!array || ![array isKindOfClass:[NSArray class]]) {
        return dft;
    }
    
    return array;
}

- (NSDictionary *)ocf_dictionaryForKey:(id)key {
    return [self ocf_dictionaryForKey:key withDefault:nil];
}

- (NSDictionary *)ocf_dictionaryForKey:(id)key withDefault:(NSDictionary *)dft {
    if (!key) {
        return dft;
    }
    
    id dictionary = [self objectForKey:key];
    if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]) {
        return dft;
    }
    
    return dictionary;
}

- (id)ocf_objectForKey:(id)key {
    return [self ocf_objectForKey:key withDefault:nil];
}

- (id)ocf_objectForKey:(id)key withDefault:(id)dft {
    if (!key) {
        return dft;
    }
    
    id object = [self objectForKey:key];
    if (!object) {
        return dft;
    }
    
    return object;
}

- (NSDictionary *)ocf_dictionaryByUnderlineValuesFromCamel {
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithCapacity:self.count];
    for (NSString *key in self.allKeys) {
        NSString *value = [self objectForKey:key];
        if (![value isKindOfClass:NSString.class]) {
            [result setObject:value forKey:key];
            continue;
        }
        value = value.ocf_underlineFromCamel;
        [result setObject:value forKey:key];
    }
    return result;
}

+ (NSDictionary *)ocf_dictionaryFromID:(id)data {
    if (!data || ![data isKindOfClass:NSObject.class]) {
        return nil;
    }
    NSObject *obj = (NSObject *)data;
    return obj.ocf_JSONObject;
}

@end
