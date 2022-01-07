//
//  MTLJSONAdapter+OCFModel.m
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import "MTLJSONAdapter+OCFModel.h"
#import "NSValueTransformer+OCFModel.h"

@implementation MTLJSONAdapter (OCFModel)

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
