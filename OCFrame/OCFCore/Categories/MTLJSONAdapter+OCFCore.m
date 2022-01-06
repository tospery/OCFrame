//
//  MTLJSONAdapter+OCFCore.m
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import "MTLJSONAdapter+OCFCore.h"
#import "NSValueTransformer+OCFCore.h"

@implementation MTLJSONAdapter (OCFCore)

+ (NSValueTransformer *)BOOLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:OCFBOOLValueTransformerName];
}

+ (NSValueTransformer *)IntJSONTransformer {
    return [NSValueTransformer valueTransformerForName:OCFIntValueTransformerName];
}

+ (NSValueTransformer *)NSStringJSONTransformer {
    return [NSValueTransformer valueTransformerForName:OCFStringValueTransformerName];
}

@end
