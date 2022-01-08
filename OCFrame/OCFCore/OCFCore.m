//
//  OCFCore.m
//  OCFrame
//
//  Created by liaoya on 2022/1/7.
//

#import "OCFCore.h"

DDLogLevel ddLogLevel = DDLogLevelAll;

@interface OCFCore ()

@end

@implementation OCFCore

- (instancetype)init {
    if (self = [super init]) {
        [DDLog addLogger:DDOSLogger.sharedInstance];
    }
    return self;
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [OCFCore sharedInstance];
    });
}

+ (instancetype)sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

@end
