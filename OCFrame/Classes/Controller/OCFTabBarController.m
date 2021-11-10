//
//  OCFTabBarController.m
//  OCFrame
//
//  Created by 杨建祥 on 2020/6/8.
//

#import "OCFTabBarController.h"
#import "OCFTabBarReactor.h"
#import "OCFAppDependency.h"

@interface OCFTabBarController ()
@property (nonatomic, strong, readwrite) OCFTabBarReactor *reactor;
@property (nonatomic, strong, readwrite) OCFNavigator *navigator;

@end

@implementation OCFTabBarController

- (instancetype)initWithReactor:(OCFTabBarReactor *)reactor navigator:(OCFNavigator *)navigator {
    if (self = [super init]) {
        self.reactor = reactor;
        self.navigator = navigator;
        [self setupChildren];
    }
    return self;
}

- (void)setupChildren {
    self.delegate = self;
    @weakify(self)
    [[self rac_signalForSelector:@selector(tabBarController:didSelectViewController:) fromProtocol:@protocol(UITabBarControllerDelegate)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self)
        [self.navigator popNavigationController];
        [self.navigator pushNavigationController:tuple.second];
    }];
}

- (void)bind:(OCFTabBarReactor *)reactor {
}

//+ (instancetype)allocWithZone:(struct _NSZone *)zone {
//    OCFTabBarController *tabBarController = [super allocWithZone:zone];
//    @weakify(tabBarController)
//    //[[tabBarController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
//    [[tabBarController rac_signalForSelector:@selector(initWithReactor:)] subscribeNext:^(id x) {
//        @strongify(tabBarController)
//        [tabBarController bind:tabBarController.reactor];
//    }];
//    return tabBarController;
//}

@end
