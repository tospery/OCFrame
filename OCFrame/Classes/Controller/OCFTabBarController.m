//
//  OCFTabBarController.m
//  OCFrame
//
//  Created by 杨建祥 on 2020/6/8.
//

#import "OCFTabBarController.h"
#import "OCFTabBarReactor.h"

@interface OCFTabBarController ()
@property (nonatomic, strong, readwrite) OCFTabBarReactor *reactor;

@end

@implementation OCFTabBarController

- (instancetype)initWithReactor:(OCFTabBarReactor *)reactor {
    if (self = [super init]) {
        self.reactor = reactor;
        [self setupChildren];
    }
    return self;
}

- (void)setupChildren {
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
