//
//  OCFRouterManager.m
//  OCFrame-OCFrame
//
//  Created by liaoya on 2021/10/25.
//

#import "OCFRouterManager.h"

@interface OCFRouterManager ()
@property (nonatomic, strong) OCFProvider *provider;
@property (nonatomic, strong) OCFNavigator *navigator;

@end

@implementation OCFRouterManager

- (void)setupWithProvider:(OCFProvider *)provider navigator:(OCFNavigator *)navigator {
    self.provider = provider;
    self.navigator = navigator;
}

+ (instancetype)sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self.class alloc] init];
    });
    return instance;
}

@end
