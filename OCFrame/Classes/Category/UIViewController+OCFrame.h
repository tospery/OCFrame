//
//  UIViewController+OCFrame.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import <UIKit/UIKit.h>

@class OCFPopupBackgroundView;

typedef NS_ENUM(NSInteger, OCFViewControllerAnimationType){
    OCFViewControllerAnimationTypeNone,
    OCFViewControllerAnimationTypeFade,
    OCFViewControllerAnimationTypeGrow,
    OCFViewControllerAnimationTypeShrink,
    OCFViewControllerAnimationTypeBounce
};

typedef NS_ENUM(NSInteger, OCFPopupLayoutHorizontal) {
    OCFPopupLayoutHorizontalCustom = 0,
    OCFPopupLayoutHorizontalLeft,
    OCFPopupLayoutHorizontalLeadCenter,
    OCFPopupLayoutHorizontalCenter,
    OCFPopupLayoutHorizontalTrailCenter,
    OCFPopupLayoutHorizontalRight,
};

typedef NS_ENUM(NSInteger, OCFPopupLayoutVertical) {
    OCFPopupLayoutVerticalCustom = 0,
    OCFPopupLayoutVerticalTop,
    OCFPopupLayoutVerticalAboveCenter,
    OCFPopupLayoutVerticalCenter,
    OCFPopupLayoutVerticalBelowCenter,
    OCFPopupLayoutVerticalBottom,
};

struct OCFPopupLayout {
    OCFPopupLayoutHorizontal horizontal;
    OCFPopupLayoutVertical vertical;
};
typedef struct OCFPopupLayout OCFPopupLayout;

extern OCFPopupLayout OCFPopupLayoutMake(OCFPopupLayoutHorizontal horizontal, OCFPopupLayoutVertical vertical);
extern const OCFPopupLayout OCFPopupLayoutCenter;

@interface UIViewController (OCFrame)
@property (class, nonatomic, strong, readonly) UIViewController *ocf_topMostViewController;
@property (nonatomic, assign) BOOL ocf_automaticallySetModalPresentationStyle;
@property (nonatomic, retain) UIViewController *ocf_popupViewController;
@property (nonatomic, retain) OCFPopupBackgroundView *ocf_popupBackgroundView;

- (void)ocf_popupViewController:(UIViewController *)popupViewController animationType:(OCFViewControllerAnimationType)animationType layout:(OCFPopupLayout)layout bgTouch:(BOOL)bgTouch dismissed:(void(^)(void))dismissed;
- (void)ocf_closeViewControllerWithAnimationType:(OCFViewControllerAnimationType)animationType;
- (void)ocf_closeViewControllerWithAnimationType:(OCFViewControllerAnimationType)animationType dismissed:(void(^)(void))dismissed;

@end

OCFViewControllerAnimationType OCFViewControllerAnimationTypeFromString(NSString *value);
