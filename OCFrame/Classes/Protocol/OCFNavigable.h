//
//  OCFNavigable.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <ReactiveObjC/NSObject+RACKVOWrapper.h>
#import "OCFType.h"
#import "UIViewController+OCFrame.h"

@class OCFViewReactor;

//typedef NS_ENUM(NSInteger, OCFPopupStyle){
//    OCFPopupStyleAlert,
//    OCFPopupStyleSheet,
//    OCFPopupStylePopup
//};

typedef NS_ENUM(NSInteger, OCFForwardType){
    OCFForwardTypePush,
    OCFForwardTypePresent,
    OCFForwardTypeToast,
    OCFForwardTypeAlert,
    OCFForwardTypeSheet,
    OCFForwardTypePopup
};

typedef NS_ENUM(NSInteger, OCFToastPosition){
    OCFToastPositionTop,
    OCFToastPositionCenter,
    OCFToastPositionBottom
};

@protocol OCFNavigable <NSObject>

@required
- (void)resetRootReactor:(OCFViewReactor *)reactor;

- (UIViewController *)pushReactor:(OCFViewReactor *)viewModel animated:(BOOL)animated;
- (UIViewController *)presentReactor:(OCFViewReactor *)viewModel animated:(BOOL)animated completion:(OCFVoidBlock)completion;
- (UIViewController *)popupReactor:(OCFViewReactor *)viewModel animationType:(OCFViewControllerAnimationType)animationType completion:(OCFVoidBlock)completion;
// popup -> hide

- (void)popReactorAnimated:(BOOL)animated completion:(OCFVoidBlock)completion;
- (void)popToRootReactorAnimated:(BOOL)animated completion:(OCFVoidBlock)completion;
- (void)dismissReactorAnimated:(BOOL)animated completion:(OCFVoidBlock)completion;
- (void)fadeawayReactorWithAnimationType:(OCFViewControllerAnimationType)animationType completion:(OCFVoidBlock)completion;

- (id)forwardReactor:(OCFViewReactor *)reactor;

//- (void)makeToastActivity:(OCFToastPosition)position;
// 无reactor: Toast/Alert
// 有reactor: push/present/popup<issheet=false>

#pragma mark - URL
- (BOOL)routeURL:(NSURL *)url withParameters:(NSDictionary *)parameters;
- (RACSignal *)rac_routeURL:(NSURL *)url withParameters:(NSDictionary *)parameters;

#pragma mark - Convenient
#pragma mark toast
- (void)toastMessage:(NSString *)message;
- (void)showToastActivity:(OCFToastPosition)position;
- (void)hideToastActivity;

#pragma mark alert
- (void)alertTitle:(NSString *)title message:(NSString *)message actions:(NSArray<NSNumber *> *)actions;
- (RACSignal *)rac_alertTitle:(NSString *)title message:(NSString *)message actions:(NSArray<NSNumber *> *)actions;

#pragma mark forward (push/present/popup)

@end


CG_INLINE OCFForwardType
OCFForwardTypeWithDft(NSInteger value, OCFForwardType dft) {
    if (value >= OCFForwardTypePush && value <= OCFForwardTypePopup) {
        return value;
    }
    return dft;
}
