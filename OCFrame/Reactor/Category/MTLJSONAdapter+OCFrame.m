//
//  MTLJSONAdapter+OCFrame.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "MTLJSONAdapter+OCFrame.h"
#import "NSValueTransformer+OCFrame.h"

@implementation MTLJSONAdapter (OCFrame)
+ (NSValueTransformer *)IntJSONTransformer {
    return [NSValueTransformer valueTransformerForName:OCFIntValueTransformerName];
}

+ (NSValueTransformer *)BOOLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:OCFBOOLValueTransformerName];
}

+ (NSValueTransformer *)UIColorJSONTransformer {
    return [NSValueTransformer valueTransformerForName:OCFColorValueTransformerName];
}

@end
