//
//  OCFViewController.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import <UIKit/UIKit.h>
#import "OCFReactive.h"
#import "OCFViewReactor.h"
#import "OCFNavigationBar.h"
#import "OCFNavigator.h"

typedef NS_ENUM(NSInteger, OCFViewControllerBackType){
    OCFViewControllerBackTypePopOne,
    OCFViewControllerBackTypePopAll,
    OCFViewControllerBackTypeDismiss,
    OCFViewControllerBackTypeClose
};

/// UI的显示与操作（视图/导航）
@interface OCFViewController : UIViewController <OCFReactive>
@property (nonatomic, assign, readonly) CGFloat contentTop;
@property (nonatomic, assign, readonly) CGFloat contentBottom;
@property (nonatomic, assign, readonly) CGRect contentFrame;
@property (nonatomic, strong, readonly) OCFNavigationBar *navigationBar;
@property (nonatomic, strong, readonly) OCFNavigator *navigator;
@property (nonatomic, strong, readonly) OCFViewReactor *reactor;

- (instancetype)initWithReactor:(OCFViewReactor *)reactor;

- (void)beginLoad;
- (void)triggerLoad;
- (void)endLoad;

- (void)beginUpdate;
- (void)triggerUpdate;
- (void)endUpdate;

- (void)reloadData;

- (BOOL (^)(NSError *error))errorFilter;
- (BOOL)handleError;

@end

