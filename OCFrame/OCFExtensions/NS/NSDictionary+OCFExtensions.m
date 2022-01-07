//
//  NSDictionary+OCFExtensions.m
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import "NSDictionary+OCFExtensions.h"

@implementation NSDictionary (OCFExtensions)

- (NSString *)ocf_queryString {
    if (self.count == 0) {
        return nil;
    }
    NSString *string = @"";
    for (NSString *key in self.allKeys) {
        id object = [self objectForKey:key];
        NSString *value = OCFStrWithObj(object);
        if (!value) {
            value = [(NSObject *)object ocf_JSONString];
        }
        value = OCFStrWithDft(value, @"");
        string = OCFStrWithFmt(@"%@&%@=%@", string, key, value);
    }
    return [string substringFromIndex:1];
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

@end
