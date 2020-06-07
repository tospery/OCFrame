//
//  MTLJSONAdapter+OCFrame.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "MTLJSONAdapter+OCFrame.h"
#import "NSValueTransformer+OCFrame.h"

@implementation MTLJSONAdapter (OCFrame)
+ (NSValueTransformer *)NSStringJSONTransformer {
    return [NSValueTransformer valueTransformerForName:OCFStringValueTransformerName];
}

+ (NSValueTransformer *)UIColorJSONTransformer {
    return [NSValueTransformer valueTransformerForName:OCFColorValueTransformerName];
}

@end
