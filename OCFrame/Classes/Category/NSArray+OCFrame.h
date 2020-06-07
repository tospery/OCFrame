//
//  NSArray+OCFrame.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/24.
//

#import <UIKit/UIKit.h>

@interface NSArray (OCFrame)

- (id)ocf_objectAtIndex:(NSInteger)index;
- (BOOL)ocf_containsObject:(id)object;
- (NSArray *)ocf_removeEquals;
- (NSArray *)ocf_addObjects:(NSArray *)objects;

@end
