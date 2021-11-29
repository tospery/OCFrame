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

//typedef NS_ENUM(NSInteger, OCFPopupStyle){
//    OCFPopupStyleAlert,
//    OCFPopupStyleSheet,
//    OCFPopupStylePopup
//};

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
- (void)closeReactorWithAnimationType:(OCFViewControllerAnimationType)animationType completion:(OCFVoidBlock)completion;

- (id)forwardReactor:(OCFViewReactor *)reactor;

- (void)makeToastActivity:(OCFToastPosition)position;
- (void)hideToastActivity;

// 无reactor: Toast/Alert
// 有reactor: push/present/popup<issheet=false>

@end

