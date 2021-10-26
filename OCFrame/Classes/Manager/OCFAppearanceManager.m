//
//  OCFAppearanceManager.m
//  OCFrame-OCFrame
//
//  Created by liaoya on 2021/10/25.
//

#import "OCFAppearanceManager.h"

@interface OCFAppearanceManager ()

@end

@implementation OCFAppearanceManager

+ (instancetype)sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self.class alloc] init];
    });
    return instance;
}

@end
