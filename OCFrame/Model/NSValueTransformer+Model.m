//
//  NSValueTransformer+Model.m
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import "NSValueTransformer+Model.h"
#import <Mantle_JX/Mantle.h>

NSString * const OCFStringValueTransformerName = @"OCFStringValueTransformerName";

@implementation NSValueTransformer (Model)

+ (void)load {
    @autoreleasepool {
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
