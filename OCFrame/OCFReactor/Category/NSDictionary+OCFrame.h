//
//  NSDictionary+OCFrame.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import <UIKit/UIKit.h>
#import "OCFFunction.h"
#import "OCFBaseModel.h"
#import "NSURL+OCFrame.h"
#import "UIColor+OCFrame.h"
#import "NSString+OCFrame.h"

@interface NSDictionary (OCFrame)

@end

CG_INLINE id
OCFModelMember(NSDictionary *dict, NSString *key, Class cls) {
    id object = OCFObjMember(dict, key, nil);
    if (object && [object isKindOfClass:cls]) {
        return object;
    }
    NSDictionary *json = OCFDictMember(dict, key, nil);
    if (json.count != 0) {
        OCFBaseModel *model = [MTLJSONAdapter modelOfClass:cls fromJSONDictionary:json error:nil];
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
        OCFBaseModel *model = [MTLJSONAdapter modelOfClass:cls fromJSONDictionary:dict error:nil];
        if (model.isValid) {
            return model;
        }
    }
    return nil;
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
