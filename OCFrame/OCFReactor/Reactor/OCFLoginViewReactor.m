//
//  OCFLoginViewReactor.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import "OCFLoginViewReactor.h"
#import "OCFStrings.h"
#import "NSDictionary+OCFReactor.h"
#import "OCFParameter.h"

@interface OCFLoginViewReactor ()
@property (nonatomic, strong, readwrite) RACSignal *validateSignal;

@end

@implementation OCFLoginViewReactor

- (instancetype)initWithParameters:(NSDictionary *)parameters {
    if (self = [super initWithParameters:parameters]) {
        self.title = OCFStrMember(parameters, OCFParameter.title, kStringLogin);
    }
    return self;
}

- (void)didInit {
    [super didInit];
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
