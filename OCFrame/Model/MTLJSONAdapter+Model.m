//
//  MTLJSONAdapter+Model.m
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import "MTLJSONAdapter+Model.h"
#import "NSValueTransformer+Model.h"

@implementation MTLJSONAdapter (Model)

+ (NSValueTransformer *)NSStringJSONTransformer {
    return [NSValueTransformer valueTransformerForName:OCFStringValueTransformerName];
}

@end
