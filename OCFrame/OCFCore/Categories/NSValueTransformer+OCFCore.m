//
//  NSValueTransformer+OCFCore.m
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import "NSValueTransformer+OCFCore.h"
#import <Mantle_JX/Mantle.h>
#import "OCFDefines.h"

NSString * const OCFBOOLValueTransformerName = @"OCFBOOLValueTransformerName";
NSString * const OCFIntValueTransformerName = @"OCFIntValueTransformerName";
NSString * const OCFStringValueTransformerName = @"OCFStringValueTransformerName";

@implementation NSValueTransformer (OCFCore)

+ (void)load {
    @autoreleasepool {
        MTLValueTransformer *boolValueTransformer = [MTLValueTransformer transformerUsingForwardBlock:^id(id obj, BOOL *success, NSError *__autoreleasing *error) {
            return @(OCFBoolWithObj(obj));
        }];
        [NSValueTransformer setValueTransformer:boolValueTransformer forName:OCFBOOLValueTransformerName];
        
        MTLValueTransformer *intValueTransformer = [MTLValueTransformer transformerUsingForwardBlock:^id(id obj, BOOL *success, NSError *__autoreleasing *error) {
            return @(OCFIntWithObj(obj));
        }];
        [NSValueTransformer setValueTransformer:intValueTransformer forName:OCFIntValueTransformerName];
        
        MTLValueTransformer *stringValueTransformer = [MTLValueTransformer transformerUsingForwardBlock:^id(id obj, BOOL *success, NSError *__autoreleasing *error) {
            return OCFStrWithObj(obj);
        }];
        [NSValueTransformer setValueTransformer:stringValueTransformer forName:OCFStringValueTransformerName];
    }
}

@end
