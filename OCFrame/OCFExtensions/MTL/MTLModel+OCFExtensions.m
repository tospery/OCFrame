//
//  MTLModel+OCFExtensions.m
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import "MTLModel+OCFExtensions.h"

@implementation MTLModel (OCFExtensions)

- (void)mergeValuesWithIgnoreKeys:(NSArray *)ignoreKeys fromModel:(id<MTLModel>)model {
    NSSet *propertyKeys = model.class.propertyKeys;
    for (NSString *key in self.class.propertyKeys) {
        if (![propertyKeys containsObject:key]) continue;
        if ([ignoreKeys containsObject:key]) continue;

        [self mergeValueForKey:key fromModel:model];
    }
}

@end
