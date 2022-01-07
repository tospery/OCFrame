//
//  NSDictionary+OCFExtensions.h
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import <Foundation/Foundation.h>
#import <OCFrame/OCFCore.h>
#import <OCFrame/OCFModel.h>
#import "NSURL+OCFExtensions.h"
#import "NSString+OCFExtensions.h"
#import "UIColor+OCFExtensions.h"

@interface NSDictionary (OCFExtensions)
@property (nonatomic, strong, readonly) NSString *ocf_queryString;
@property (nonatomic, strong, readonly) NSDictionary *ocf_dictionaryByUnderlineValuesFromCamel;
    
@end

CG_INLINE NSURL *
OCFURLMember(NSDictionary *dict, id key, NSURL *dft) {
    if (!dict || ![dict isKindOfClass:NSDictionary.class] || !dict.count || !key) {
        return dft;
    }
    NSURL *url = OCFObjMember(dict, key, nil);
    if (!url) {
        return dft;
    }
    if (![url isKindOfClass:[NSURL class]]) {
        if ([url isKindOfClass:[NSString class]]) {
            NSString *string = (NSString *)url;
            url = OCFURLWithStr(string);
        } else {
            return dft;
        }
    }
    return url;
}

CG_INLINE UIColor *
OCFColorMember(NSDictionary *dict, id key, UIColor *dft) {
    if (!dict || ![dict isKindOfClass:NSDictionary.class] || !dict.count || !key) {
        return dft;
    }
    UIColor *color = OCFObjMember(dict, key, nil);
    if (!color) {
        return dft;
    }
    if (![color isKindOfClass:[UIColor class]]) {
        if ([color isKindOfClass:[NSString class]]) {
            NSString *string = (NSString *)color;
            color = OCFObjWithDft(OCFColorStr(string), dft);
        }
    }
    return color;
}

CG_INLINE OCFModel *
OCFModelMember(NSDictionary *dict, id key, Class cls) {
    id object = OCFObjMember(dict, key, nil);
    if (object && [object isKindOfClass:cls]) {
        return object;
    }
    NSDictionary *json = OCFDictMember(dict, key, nil);
    if (json.count != 0) {
        OCFModel *model = [MTLJSONAdapter modelOfClass:cls fromJSONDictionary:json error:nil];
        if (model.isValid) {
            return model;
        }
    }
    NSMutableArray *strings = [NSMutableArray arrayWithCapacity:2];
    NSString *string = OCFStrMember(dict, key, nil);
    if (string.length != 0) {
        [strings addObject:string];
    }
    string = [string ocf_base64Decoded];
    if (string.length != 0) {
        [strings addObject:string];
    }
    for (NSString *string in strings) {
        id json = [string ocf_JSONObject];
        if (![json isKindOfClass:NSDictionary.class]) {
            continue;
        }
        NSDictionary *dict = (NSDictionary *)json;
        if (dict.count == 0) {
            continue;
        }
        OCFModel *model = [MTLJSONAdapter modelOfClass:cls fromJSONDictionary:dict error:nil];
        if (model.isValid) {
            return model;
        }
    }
    return nil;
}
