//
//  MTLModel+OCFExtensions.h
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import <Mantle_JX/Mantle.h>

@interface MTLModel (OCFExtensions)

- (void)mergeValuesWithIgnoreKeys:(NSArray *)ignoreKeys fromModel:(id<MTLModel>)model;

@end

