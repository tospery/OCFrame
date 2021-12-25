//
//  OCFReachManager.m
//  OCFrame
//
//  Created by liaoya on 2021/12/6.
//

#import "OCFReachManager.h"
#import <AFNetworking/AFNetworking.h>
#import "OCFFunction.h"

@interface OCFReachManager ()
@property (nonatomic, strong, readwrite) OCFBehaviorRelay *behaviorRelay;

@end

@implementation OCFReachManager

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (OCFBehaviorRelay *)behaviorRelay {
    if (!_behaviorRelay) {
        OCFBehaviorRelay *subject = [OCFBehaviorRelay behaviorRelayWithDefaultValue:@(AFNetworkReachabilityStatusUnknown)];
        _behaviorRelay = subject;
    }
    return _behaviorRelay;
}

- (void)start {
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        OCFLogDebug(@"网络状态: %@", @(status));
        [REACH_SUBJECT sendNext:@(status)];
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
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
