//
//  MTLJSONAdapter+OCFCore.h
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import <Mantle_JX/Mantle.h>

@interface MTLJSONAdapter (OCFCore)

+ (NSValueTransformer *)BOOLJSONTransformer;
+ (NSValueTransformer *)IntJSONTransformer;
+ (NSValueTransformer *)NSStringJSONTransformer;

@end

