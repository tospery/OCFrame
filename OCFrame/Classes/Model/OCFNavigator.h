//
//  OCFNavigator.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import <UIKit/UIKit.h>
#import "OCFNavigable.h"

@class OCFViewController;

@interface OCFNavigator : NSObject <OCFNavigable>
//@property (nonatomic, strong, readonly) UIView *topView;
//@property (nonatomic, strong, readonly) UIViewController *topViewController;
//@property (nonatomic, strong, readonly) UINavigationController *topNavigationController;

//- (void)pushNavigationController:(UINavigationController *)navigationController;
//- (UINavigationController *)popNavigationController;

- (void)goLogin;
- (RACSignal *)rac_goLogin;

@end

