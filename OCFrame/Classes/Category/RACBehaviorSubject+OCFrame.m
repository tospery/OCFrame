//
//  RACBehaviorSubject+OCFrame.m
//  OCFrame
//
//  Created by liaoya on 2021/12/27.
//

#import "RACBehaviorSubject+OCFrame.h"

@implementation RACBehaviorSubject (OCFrame)

- (id)value {
    SEL sel = NSSelectorFromString(@"currentValue"); // @selector(currentValue);
    if ([self respondsToSelector:sel]) {
        return ((id (*)(id, SEL))[self methodForSelector:sel])(self, sel);
    }
    return nil;
}

@end
