//
//  RACBehaviorSubject+OCFReactor.m
//  OCFrame
//
//  Created by liaoya on 2022/1/7.
//

#import "RACBehaviorSubject+OCFReactor.h"

@implementation RACBehaviorSubject (OCFReactor)

- (id)value {
    SEL sel = NSSelectorFromString(@"currentValue");
    if ([self respondsToSelector:sel]) {
        return ((id (*)(id, SEL))[self methodForSelector:sel])(self, sel);
    }
    return nil;
}

@end
