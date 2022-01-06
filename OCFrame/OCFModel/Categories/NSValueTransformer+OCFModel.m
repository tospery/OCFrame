//
//  NSValueTransformer+OCFModel.m
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import "NSValueTransformer+OCFModel.h"
#import <Mantle_JX/Mantle.h>

NSString * const OCFBOOLValueTransformerName = @"OCFBOOLValueTransformerName";
NSString * const OCFIntValueTransformerName = @"OCFIntValueTransformerName";
NSString * const OCFStringValueTransformerName = @"OCFStringValueTransformerName";

@implementation NSValueTransformer (OCFModel)

+ (void)load {
    @autoreleasepool {
        MTLValueTransformer *boolValueTransformer = [MTLValueTransformer transformerUsingForwardBlock:^id(id obj, BOOL *success, NSError *__autoreleasing *error) {
            if ([obj isKindOfClass:NSNumber.class]) {
                return @([(NSNumber *)obj boolValue]);
            }
            if ([obj isKindOfClass:NSString.class]) {
                return @([(NSString *)obj integerValue] != 0 ? YES : NO);
            }
            return @(NO);
        }];
        [NSValueTransformer setValueTransformer:boolValueTransformer forName:OCFBOOLValueTransformerName];
        
        MTLValueTransformer *intValueTransformer = [MTLValueTransformer transformerUsingForwardBlock:^id(id obj, BOOL *success, NSError *__autoreleasing *error) {
            if ([obj isKindOfClass:NSNumber.class]) {
                return obj;
            }
            if ([obj isKindOfClass:NSString.class]) {
                return @([(NSString *)obj integerValue]);
            }
            return @(0);
        }];
        [NSValueTransformer setValueTransformer:intValueTransformer forName:OCFIntValueTransformerName];
        
        MTLValueTransformer *stringValueTransformer = [MTLValueTransformer transformerUsingForwardBlock:^id(id obj, BOOL *success, NSError *__autoreleasing *error) {
            if ([obj isKindOfClass:NSString.class]) {
                return obj;
            } else if ([obj isKindOfClass:NSNumber.class]) {
                return [(NSNumber *)obj stringValue];
            }
            return nil;
        }];
        [NSValueTransformer setValueTransformer:stringValueTransformer forName:OCFStringValueTransformerName];
    }
}

@end
