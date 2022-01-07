//
//  NSArray+OCFExtensions.h
//  Pods
//
//  Created by liaoya on 2022/1/6.
//

#import <Foundation/Foundation.h>

@interface NSArray (OCFExtensions)

- (id)ocf_objectAtIndex:(NSInteger)index;
- (BOOL)ocf_containsObject:(id)object;
- (NSArray *)ocf_removeEquals;
- (NSArray *)ocf_addObjects:(NSArray *)objects;

@end

