//
//  OCFBaseReactor.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "OCFBaseReactor.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface OCFBaseReactor ()

@end

@implementation OCFBaseReactor

- (void)didInitialize {
    
}

- (void)willBind {
    
}

- (void)didBind {
    
}

- (void)unbinded {
    
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    OCFBaseReactor *reactor = [super allocWithZone:zone];
    @weakify(reactor)
    [[reactor rac_signalForSelector:@selector(init)] subscribeNext:^(id x) {
        @strongify(reactor)
        [reactor didInitialize];
    }];
    return reactor;
}

@end
