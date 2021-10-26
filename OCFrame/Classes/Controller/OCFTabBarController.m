//
//  OCFTabBarController.m
//  OCFrame
//
//  Created by 杨建祥 on 2020/6/8.
//

#import "OCFTabBarController.h"

@interface OCFTabBarController ()
@property (nonatomic, strong, readwrite) OCFTabBarReactor *reactor;

@end

@implementation OCFTabBarController
- (instancetype)initWithReactor:(OCFTabBarReactor *)reactor {
    if (self = [super init]) {
        self.reactor = reactor;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)bind:(OCFTabBarReactor *)reactor {
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    OCFTabBarController *tabBarController = [super allocWithZone:zone];
    @weakify(tabBarController)
    [[tabBarController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        @strongify(tabBarController)
        [tabBarController bind:tabBarController.reactor];
    }];
    return tabBarController;
}

@end
