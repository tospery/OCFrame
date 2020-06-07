//
//  NSArray+OCFrame.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/24.
//

#import "NSArray+OCFrame.h"

@implementation NSArray (OCFrame)
- (id)ocf_objectAtIndex:(NSInteger)index {
    if (index <= -1 || index >= self.count) {
        return nil;
    }
    return [self objectAtIndex:index];
}

- (BOOL)ocf_containsObject:(id)object {
    BOOL result = NO;
    for (id obj in self) {
        if (obj == object) {
            result = YES;
            break;
        }
    }
    return result;
}

- (NSArray *)ocf_removeEquals {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:self.count];
    for (id obj1 in self) {
        BOOL isEqual = NO;
        for (id obj2 in arr) {
            if ([obj1 isEqual:obj2]) {
                isEqual = YES;
                break;
            }
        }
        if (!isEqual) {
            [arr addObject:obj1];
        }
    }
    return arr;
}

- (NSArray *)ocf_addObjects:(NSArray *)objects {
    NSMutableArray *array = [NSMutableArray arrayWithArray:self];
    for (id obj1 in objects) {
        BOOL isUnique = YES;
        for (id obj2 in array) {
            if ([obj1 isEqual:obj2]) {
                isUnique = NO;
                break;
            }
        }
        if (isUnique) {
            [array addObject:obj1];
        }
    }
    return array;
}

@end
