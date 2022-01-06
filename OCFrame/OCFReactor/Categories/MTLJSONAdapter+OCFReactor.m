//
//  MTLJSONAdapter+OCFReactor.m
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import "MTLJSONAdapter+OCFReactor.h"
#import "NSValueTransformer+OCFReactor.h"

@implementation MTLJSONAdapter (OCFReactor)

+ (NSValueTransformer *)UIColorJSONTransformer {
    return [NSValueTransformer valueTransformerForName:OCFColorValueTransformerName];
}

@end
