//
//  OCFTabBarViewReactor.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "OCFTabBarViewReactor.h"
#import "OCFParameter.h"
#import "NSDictionary+OCFReactor.h"

@interface OCFTabBarViewReactor ()
//@property (nonatomic, strong, readwrite) RACSubject *selectSubject;

@end

@implementation OCFTabBarViewReactor

#pragma mark - Init
- (instancetype)initWithParameters:(NSDictionary *)parameters {
    if (self = [super initWithParameters:parameters]) {
        self.hidesNavigationBar = OCFBoolMember(parameters, OCFParameter.hidesNavigationBar, YES);
    }
    return self;
}

- (void)didInit {
    [super didInit];
}

#pragma mark - View
#pragma mark - Property
//- (RACSubject *)selectSubject {
//    if (!_selectSubject) {
//        RACSubject *subject = [RACSubject subject];
//        @weakify(self)
//        [subject subscribeNext:^(RACTuple *tuple) {
//            @strongify(self)
//            [self.navigator popNavigationController];
//            [self.navigator pushNavigationController:tuple.second];
//        }];
//        _selectSubject = subject;
//    }
//    return _selectSubject;
//}

#pragma mark - Method
#pragma mark super
#pragma mark public
#pragma mark private
#pragma mark - Delegate
#pragma mark - Class


@end
