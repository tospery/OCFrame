//
//  OCFNavigator.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "OCFNavigator.h"
#import <JLRoutes/JLRoutes.h>
#import "OCFViewReactor.h"
#import "OCFViewController.h"
#import "OCFTabBarViewController.h"
#import "OCFNavigationController.h"

#define kControllerName                             (@"Controller")
#define kReactorName                                (@"Reactor")

@interface OCFNavigator () <UINavigationControllerDelegate>
//@property (nonatomic, strong, readwrite) UINavigationController *topNavigationController;
@property (nonatomic, strong) NSMutableArray *navigationControllers;

@end

@implementation OCFNavigator

#pragma mark - Property
- (UIView *)topView {
    return self.topViewController.view;
}

- (UIViewController *)topViewController {
    return self.topNavigationController.topViewController;
}

- (UINavigationController *)topNavigationController {
    return self.navigationControllers.lastObject;
}

- (NSMutableArray *)navigationControllers {
    if (!_navigationControllers) {
        _navigationControllers = [NSMutableArray array];
    }
    return _navigationControllers;
}

#pragma mark - Navigation
- (void)pushNavigationController:(UINavigationController *)navigationController {
    if ([self.navigationControllers containsObject:navigationController]) {
        return;
    }
    navigationController.delegate = self;
    [self.navigationControllers addObject:navigationController];
}

- (UINavigationController *)popNavigationController {
    UINavigationController *navigationController = self.topNavigationController;
    [self.navigationControllers removeLastObject];
    return navigationController;
}

#pragma mark - Route
- (BOOL)routeURL:(NSURL *)url withParameters:(NSDictionary *)parameters {
    return [JLRoutes routeURL:url withParameters:parameters];
}

#pragma mark - Private
- (OCFViewController *)viewController:(OCFViewReactor *)reactor {
    NSString *name = NSStringFromClass(reactor.class);
    NSParameterAssert([name hasSuffix:kReactorName]);
    name = [name stringByReplacingCharactersInRange:NSMakeRange(name.length - kReactorName.length, kReactorName.length) withString:kControllerName];
    Class cls = NSClassFromString(name);
    NSParameterAssert([cls isSubclassOfClass:OCFViewController.class]);
    NSParameterAssert([cls instancesRespondToSelector:@selector(initWithReactor:)]);
    return [[cls alloc] initWithReactor:reactor];
}

#pragma mark - Delegate
#pragma mark OCFNavigable
- (void)resetRootReactor:(OCFViewReactor *)reactor {
    [self.navigationControllers removeAllObjects];
    UIViewController *viewController = (UIViewController *)[self viewController:reactor];
    if (![viewController isKindOfClass:[UINavigationController class]] &&
        ![viewController isKindOfClass:[UITabBarController class]] &&
        ![viewController isKindOfClass:[OCFTabBarViewController class]]) {
        viewController = [[OCFNavigationController alloc] initWithRootViewController:viewController];
        [self pushNavigationController:(UINavigationController *)viewController];
    }
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    window.rootViewController = viewController;
    [window makeKeyAndVisible];
}

- (UIViewController *)pushReactor:(OCFViewReactor *)reactor animated:(BOOL)animated {
    UIViewController *viewController = (UIViewController *)[self viewController:reactor];
    [self.topNavigationController pushViewController:viewController animated:animated];
    return viewController;
}

- (UIViewController *)presentReactor:(OCFViewReactor *)reactor animated:(BOOL)animated completion:(OCFVoidBlock)completion {
    UIViewController *viewController = (UIViewController *)[self viewController:reactor];
    UINavigationController *presentingViewController = self.topNavigationController;
    if (![viewController isKindOfClass:UINavigationController.class]) {
        viewController = [[OCFNavigationController alloc] initWithRootViewController:viewController];
    }
    [self pushNavigationController:(OCFNavigationController *)viewController];
    [presentingViewController presentViewController:viewController animated:animated completion:completion];
    return viewController;
}

- (UIViewController *)popupReactor:(OCFViewReactor *)reactor animationType:(OCFViewControllerAnimationType)animationType completion:(OCFVoidBlock)completion {
    UIViewController *viewController = (UIViewController *)[self viewController:reactor];
    [self.topNavigationController ocf_popupViewController:viewController animationType:animationType layout:OCFPopupLayoutCenter bgTouch:NO dismissed:completion];
    return viewController;
}

- (void)popReactorAnimated:(BOOL)animated completion:(OCFVoidBlock)completion {
    [CATransaction begin];
    [CATransaction setCompletionBlock:completion];
    [self.topNavigationController popViewControllerAnimated:animated];
    [CATransaction commit];
}

- (void)popToRootReactorAnimated:(BOOL)animated completion:(OCFVoidBlock)completion {
    [CATransaction begin];
    [CATransaction setCompletionBlock:completion];
    [self.topNavigationController popToRootViewControllerAnimated:animated];
    [CATransaction commit];
}

- (void)dismissReactorAnimated:(BOOL)animated completion:(OCFVoidBlock)completion {
    UINavigationController *dismissingViewController = self.topNavigationController;
    [self popNavigationController];
    [dismissingViewController dismissViewControllerAnimated:animated completion:completion];
}

- (void)closeReactorWithAnimationType:(OCFViewControllerAnimationType)animationType completion:(OCFVoidBlock)completion {
    [self.topNavigationController ocf_closeViewControllerWithAnimationType:animationType dismissed:completion];
}

@end
