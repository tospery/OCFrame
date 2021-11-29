//
//  OCFNavigator.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <ReactiveObjC/NSObject+RACKVOWrapper.h>
#import "OCFNavigable.h"

@class OCFViewController;

@interface OCFNavigator : NSObject <OCFNavigable>
//@property (nonatomic, strong, readonly) UIView *topView;
//@property (nonatomic, strong, readonly) UIViewController *topViewController;
//@property (nonatomic, strong, readonly) UINavigationController *topNavigationController;

//- (void)pushNavigationController:(UINavigationController *)navigationController;
//- (UINavigationController *)popNavigationController;

- (BOOL)routeURL:(NSURL *)url withParameters:(NSDictionary *)parameters;
- (RACSignal *)rac_routeURL:(NSURL *)url withParameters:(NSDictionary *)parameters;

- (void)goLogin;

@end

