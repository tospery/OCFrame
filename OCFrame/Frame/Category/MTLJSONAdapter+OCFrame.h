//
//  MTLJSONAdapter+OCFrame.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import <Mantle_JX/Mantle.h>

@interface MTLJSONAdapter (OCFrame)
+ (NSValueTransformer *)IntJSONTransformer;
+ (NSValueTransformer *)BOOLJSONTransformer;
+ (NSValueTransformer *)NSStringJSONTransformer;
+ (NSValueTransformer *)UIColorJSONTransformer;

@end

