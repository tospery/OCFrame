//
//  OCFNavigable.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import <UIKit/UIKit.h>
#import "OCFType.h"
#import "UIViewController+OCFrame.h"

@class OCFViewReactor;

@protocol OCFNavigable <NSObject>

- (void)resetRootReactor:(OCFViewReactor *)reactor;

- (UIViewController *)pushReactor:(OCFViewReactor *)viewModel animated:(BOOL)animated;
- (UIViewController *)presentReactor:(OCFViewReactor *)viewModel animated:(BOOL)animated completion:(OCFVoidBlock)completion;
- (UIViewController *)popupReactor:(OCFViewReactor *)viewModel animationType:(OCFViewControllerAnimationType)animationType completion:(OCFVoidBlock)completion;

- (void)popReactorAnimated:(BOOL)animated completion:(OCFVoidBlock)completion;
- (void)popToRootReactorAnimated:(BOOL)animated completion:(OCFVoidBlock)completion;
- (void)dismissReactorAnimated:(BOOL)animated completion:(OCFVoidBlock)completion;
- (void)closeReactorWithAnimationType:(OCFViewControllerAnimationType)animationType completion:(OCFVoidBlock)completion;

@end

