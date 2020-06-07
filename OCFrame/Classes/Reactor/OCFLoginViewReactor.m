//
//  OCFLoginViewReactor.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import "OCFLoginViewReactor.h"

@interface OCFLoginViewReactor ()
@property (nonatomic, strong, readwrite) RACSignal *validateSignal;

@end

@implementation OCFLoginViewReactor

- (instancetype)initWithRouteParameters:(NSDictionary *)parameters {
    if (self = [super initWithRouteParameters:parameters]) {
    }
    return self;
}

- (void)didInitialize {
    [super didInitialize];
}

- (RACSignal *)validateSignal {
    if (!_validateSignal) {
        RACSignal *signal = [RACSignal combineLatest:@[RACObserve(self, username), RACObserve(self, password)] reduce:^(NSString *username, NSString *password) {
            return @(username.length > 0 && password.length > 0);
        }].distinctUntilChanged;
        _validateSignal = signal;
    }
    return _validateSignal;
}

@end
