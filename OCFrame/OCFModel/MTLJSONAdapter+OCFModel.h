//
//  MTLJSONAdapter+OCFModel.h
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import <Mantle_JX/Mantle.h>

@interface MTLJSONAdapter (OCFModel)

+ (NSValueTransformer *)BOOLJSONTransformer;
+ (NSValueTransformer *)IntJSONTransformer;
+ (NSValueTransformer *)NSStringJSONTransformer;

@end

