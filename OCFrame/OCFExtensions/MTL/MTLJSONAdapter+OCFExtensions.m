//
//  MTLJSONAdapter+OCFExtensions.m
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import "MTLJSONAdapter+OCFExtensions.h"
#import "NSValueTransformer+OCFExtensions.h"

@implementation MTLJSONAdapter (OCFExtensions)

+ (NSValueTransformer *)UIColorJSONTransformer {
    return [NSValueTransformer valueTransformerForName:OCFColorValueTransformerName];
}

@end
