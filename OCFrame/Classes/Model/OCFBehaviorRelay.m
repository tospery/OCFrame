//
//  OCFBehaviorRelay.m
//  OCFrame
//
//  Created by 杨建祥 on 2021/12/25.
//

#import "OCFBehaviorRelay.h"
#import <ReactiveObjC/RACSubscriptionScheduler.h>

@interface RACScheduler (OCFBehaviorRelay)

+ (RACScheduler *)behaviorRelaySubscriptionScheduler;
    
@end

@implementation RACScheduler (OCFBehaviorRelay)

+ (RACScheduler *)behaviorRelaySubscriptionScheduler {
    static dispatch_once_t onceToken;
    static RACScheduler *behaviorRelaySubscriptionScheduler;
    dispatch_once(&onceToken, ^{
        behaviorRelaySubscriptionScheduler = [[RACSubscriptionScheduler alloc] init];
    });

    return behaviorRelaySubscriptionScheduler;
}

@end

@interface OCFBehaviorRelay<ValueType> ()
@property (nonatomic, strong, readwrite) ValueType currentValue;

@end

@implementation OCFBehaviorRelay

+ (instancetype)behaviorRelayWithDefaultValue:(id)value {
    OCFBehaviorRelay *subject = [self subject];
    subject.currentValue = value;
    return subject;
}

- (RACDisposable *)subscribe:(id<RACSubscriber>)subscriber {
    RACDisposable *subscriptionDisposable = [super subscribe:subscriber];
    RACDisposable *schedulingDisposable = [RACScheduler.behaviorRelaySubscriptionScheduler schedule:^{
        @synchronized (self) {
            [subscriber sendNext:self.currentValue];
        }
    }];
    
    return [RACDisposable disposableWithBlock:^{
        [subscriptionDisposable dispose];
        [schedulingDisposable dispose];
    }];
}

- (void)sendNext:(id)value {
    @synchronized (self) {
        self.currentValue = value;
        [super sendNext:value];
    }
}

@end

