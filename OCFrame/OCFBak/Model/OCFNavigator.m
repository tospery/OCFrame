//
//  OCFNavigator.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "OCFNavigator.h"
#import <QMUIKit/QMUIKit.h>
#import <JLRoutes/JLRoutes.h>
#import "OCFConstant.h"
#import "OCFFunction.h"
#import "OCFParameter.h"
#import "OCFViewReactor.h"
#import "OCFViewController.h"
#import "OCFTabBarController.h"
#import "OCFTabBarViewController.h"
#import "OCFNavigationController.h"
#import "NSURL+OCFrame.h"
#import "UINavigationController+OCFrame.h"

#define kControllerName                             (@"Controller")
#define kReactorName                                (@"Reactor")

@interface OCFNavigator () <UINavigationControllerDelegate>
//@property (nonatomic, strong, readwrite) UINavigationController *topNavigationController;
//@property (nonatomic, strong) NSMutableArray *navigationControllers;

@end

@implementation OCFNavigator

#pragma mark - Property
//- (UIView *)topView {
//    return self.topViewController.view;
//}
//
//- (UIViewController *)topViewController {
//    return self.topNavigationController.topViewController;
//}
//
//- (UINavigationController *)topNavigationController {
//    return self.navigationControllers.lastObject;
//}

//- (NSMutableArray *)navigationControllers {
//    if (!_navigationControllers) {
//        _navigationControllers = [NSMutableArray array];
//    }
//    return _navigationControllers;
//}

#pragma mark - Navigation
//- (void)pushNavigationController:(UINavigationController *)navigationController {
//    if ([self.navigationControllers containsObject:navigationController]) {
//        return;
//    }
//    navigationController.delegate = self;
//    [self.navigationControllers addObject:navigationController];
//}
//
//- (UINavigationController *)popNavigationController {
//    UINavigationController *navigationController = self.topNavigationController;
//    [self.navigationControllers removeLastObject];
//    return navigationController;
//}

#pragma mark - Private
- (OCFViewController *)viewController:(OCFViewReactor *)reactor {
    NSString *name = NSStringFromClass(reactor.class);
    NSParameterAssert([name hasSuffix:kReactorName]);
    name = [name stringByReplacingCharactersInRange:NSMakeRange(name.length - kReactorName.length, kReactorName.length) withString:kControllerName];
    Class cls = NSClassFromString(name);
    NSParameterAssert([cls isSubclassOfClass:OCFViewController.class] || [cls isSubclassOfClass:OCFTabBarController.class]);
    NSParameterAssert([cls instancesRespondToSelector:@selector(initWithReactor:navigator:)]);
    return [[cls alloc] initWithReactor:reactor navigator:self];
}

#pragma mark - Delegate
#pragma mark OCFNavigable
- (void)resetRootReactor:(OCFViewReactor *)reactor {
    //[self.navigationControllers removeAllObjects];
    UIViewController *viewController = (UIViewController *)[self viewController:reactor];
    if (![viewController isKindOfClass:[UINavigationController class]] &&
        ![viewController isKindOfClass:[UITabBarController class]] &&
        ![viewController isKindOfClass:[OCFTabBarViewController class]]) {
        viewController = [[OCFNavigationController alloc] initWithRootViewController:viewController];
        //[self pushNavigationController:(UINavigationController *)viewController];
    }
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    window.rootViewController = viewController;
    [window makeKeyAndVisible];
}

//- (UIViewController *)pushReactor:(OCFViewReactor *)reactor animated:(BOOL)animated {
//    UIViewController *viewController = (UIViewController *)[self viewController:reactor];
//    [UINavigationController.ocf_currentNavigationController pushViewController:viewController animated:animated];
//    return viewController;
//}

//- (UIViewController *)presentReactor:(OCFViewReactor *)reactor animated:(BOOL)animated completion:(OCFVoidBlock)completion {
//    UIViewController *viewController = (UIViewController *)[self viewController:reactor];
//    UINavigationController *presentingViewController = UINavigationController.ocf_currentNavigationController;
//    if (![viewController isKindOfClass:UINavigationController.class]) {
//        viewController = [[OCFNavigationController alloc] initWithRootViewController:viewController];
//    }
//    //[self pushNavigationController:(OCFNavigationController *)viewController];
//    [presentingViewController presentViewController:viewController animated:animated completion:completion];
//    return viewController;
//}

//- (UIViewController *)popupReactor:(OCFViewReactor *)reactor animationType:(OCFViewControllerAnimationType)animationType completion:(OCFVoidBlock)completion {
//    UIViewController *viewController = (UIViewController *)[self viewController:reactor];
//    [UINavigationController.ocf_currentNavigationController ocf_popupViewController:viewController animationType:animationType layout:OCFPopupLayoutCenter bgTouch:NO dismissed:completion];
//    return viewController;
//}

//- (void)popReactorAnimated:(BOOL)animated completion:(OCFVoidBlock)completion {
//    [CATransaction begin];
//    [CATransaction setCompletionBlock:completion];
//    [UINavigationController.ocf_currentNavigationController popViewControllerAnimated:animated];
//    [CATransaction commit];
//}
//
//- (void)popToRootReactorAnimated:(BOOL)animated completion:(OCFVoidBlock)completion {
//    [CATransaction begin];
//    [CATransaction setCompletionBlock:completion];
//    [UINavigationController.ocf_currentNavigationController popToRootViewControllerAnimated:animated];
//    [CATransaction commit];
//}
//
//- (void)dismissReactorAnimated:(BOOL)animated completion:(OCFVoidBlock)completion {
//    UINavigationController *dismissingViewController = UINavigationController.ocf_currentNavigationController;
//    //[self popNavigationController];
//    [dismissingViewController dismissViewControllerAnimated:animated completion:completion];
//}
//
//- (void)fadeawayReactorWithAnimationType:(OCFViewControllerAnimationType)animationType completion:(OCFVoidBlock)completion {
//    [UINavigationController.ocf_currentNavigationController ocf_closeViewControllerWithAnimationType:animationType dismissed:completion];
//}

#pragma mark - URL
- (BOOL)routeURL:(NSURL *)url withParameters:(NSDictionary *)parameters {
    return [JLRoutes routeURL:url withParameters:parameters];
}

- (RACSignal *)rac_routeURL:(NSURL *)url withParameters:(NSDictionary *)parameters {
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        NSMutableDictionary *myParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
        [myParameters setObject:subscriber forKey:OCFParameter.subscriber];
        [self routeURL:url withParameters:myParameters];
        return [RACDisposable disposableWithBlock:^{
        }];
    }];
}

#pragma mark Toast
- (void)toastMessage:(NSString *)message {
    OCFCheck(message);
    [self routeURL:OCFURLWithUniversal(kOCFHostToast) withParameters:@{
        OCFParameter.message: message
    }];
}

- (void)showToastActivity:(OCFToastPosition)position {
    [self routeURL:OCFURLWithUniversal(kOCFHostToast) withParameters:@{
        OCFParameter.active: @YES,
        OCFParameter.position: @(position)
    }];
}

- (void)hideToastActivity {
    [self routeURL:OCFURLWithUniversal(kOCFHostToast) withParameters:@{
        OCFParameter.active: @NO
    }];
}

#pragma mark Alert
- (void)alertTitle:(NSString *)title message:(NSString *)message actions:(NSArray<NSNumber *> *)actions {
    if (title.length == 0 && message.length == 0) {
        return;
    }
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:3];
    if (title.length != 0) {
        [parameters setObject:title forKey:OCFParameter.title];
    }
    if (message.length != 0) {
        [parameters setObject:message forKey:OCFParameter.message];
    }
    if (actions.count != 0) {
        [parameters setObject:actions forKey:OCFParameter.actions];
    }
    [self routeURL:OCFURLWithUniversal(kOCFHostAlert) withParameters:parameters];
}

- (RACSignal *)rac_alertTitle:(NSString *)title message:(NSString *)message actions:(NSArray<NSNumber *> *)actions {
    if (title.length == 0 && message.length == 0) {
        return RACSignal.empty;
    }
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:3];
        if (title.length != 0) {
            [parameters setObject:title forKey:OCFParameter.title];
        }
        if (message.length != 0) {
            [parameters setObject:message forKey:OCFParameter.message];
        }
        if (actions.count != 0) {
            [parameters setObject:actions forKey:OCFParameter.actions];
        }
        [parameters setObject:subscriber forKey:OCFParameter.subscriber];
        [self routeURL:OCFURLWithUniversal(kOCFHostAlert) withParameters:parameters];
        return [RACDisposable disposableWithBlock:^{
        }];
    }];
}

#pragma mark Forward (push/present/popup)
- (id)forwardReactor:(OCFViewReactor *)reactor {
    UIViewController *viewController = (UIViewController *)[self viewController:reactor];
    UINavigationController *navigationController = UINavigationController.ocf_currentNavigationController;
    OCFForwardType forwardType = reactor.forwardType;
    if (!navigationController && forwardType == OCFForwardTypePush) {
        forwardType = OCFForwardTypePresent;
    }
    if (forwardType == OCFForwardTypePush) {
        [navigationController pushViewController:viewController animated:reactor.animated];
    } else if (forwardType == OCFForwardTypePresent) {
        UIViewController *presentingViewController = navigationController;
        if (!presentingViewController) {
            presentingViewController = UIViewController.ocf_topMostViewController;
        }
        if (![viewController isKindOfClass:UINavigationController.class]) {
            viewController = [[OCFNavigationController alloc] initWithRootViewController:viewController];
        }
        [presentingViewController presentViewController:viewController animated:reactor.animated completion:nil];
    }
    return viewController;
}

#pragma mark Login
- (void)goLogin {
    [self routeURL:OCFURLWithUniversal(kOCFHostLogin) withParameters:nil];
}

- (RACSignal *)rac_goLogin {
    return [self rac_routeURL:OCFURLWithUniversal(kOCFHostLogin) withParameters:nil];
}

@end
