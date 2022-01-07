////
////  RACBehaviorSubject+OCFExtensions.m
////  OCFrame
////
////  Created by liaoya on 2022/1/6.
////
//
//#import "RACBehaviorSubject+OCFExtensions.h"
//
//@implementation RACBehaviorSubject (OCFExtensions)
//
//- (id)value {
//    SEL sel = NSSelectorFromString(@"currentValue");
//    if ([self respondsToSelector:sel]) {
//        return ((id (*)(id, SEL))[self methodForSelector:sel])(self, sel);
//    }
//    return nil;
//}
//
//@end
