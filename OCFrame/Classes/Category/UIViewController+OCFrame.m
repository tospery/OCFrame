//
//  UIViewController+OCFrame.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import "UIViewController+OCFrame.h"
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>
#import <QMUIKit/QMUIKit.h>
#import "NSObject+OCFrame.h"
#import "OCFConstant.h"
#import "OCFFunction.h"
#import "OCFPopupBackgroundView.h"

#define kOCFPopupAnimationDuration               (0.25)
#define kOCFPopupDurationTime                    (@"kOCFPopupDurationTime")
#define kOCFPopupViewController                  (@"kOCFPopupViewController")
#define kOCFPopupBackgroundView                  (@"kOCFPopupBackgroundView")
#define kOCFSourceViewTag                        (53941)
#define kOCFPopupViewTag                         (53942)
#define kOCFOverlayViewTag                       (53945)

static NSInteger const kOCFPopupAnimationOptionCurveIOS7 = (7 << 16);
static NSString *kOCFPopupDismissKey = @"kOCFPopupDismissKey";

OCFPopupLayout OCFPopupLayoutMake(OCFPopupLayoutHorizontal horizontal, OCFPopupLayoutVertical vertical) {
    OCFPopupLayout layout;
    layout.horizontal = horizontal;
    layout.vertical = vertical;
    return layout;
}

const OCFPopupLayout OCFPopupLayoutCenter = {OCFPopupLayoutHorizontalCenter, OCFPopupLayoutVerticalCenter};

@interface UIViewController (OCFFrame_Popup)
- (UIView *)ocf_topView;
- (void)presentPopupView:(UIView *)popupView;

@end

@implementation UIViewController (OCFrame)
QMUISynthesizeBOOLProperty(ocf_automaticallySetModalPresentationStyle, setOcf_automaticallySetModalPresentationStyle)

static void * const keypath = (void*)&keypath;

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ExchangeImplementations(self.class, @selector(presentViewController:animated:completion:), @selector(ocf_presentViewController:animated:completion:));
    });
}

+ (UIViewController *)ocf_topMostViewController {
    return QMUIHelper.visibleViewController;
}

- (void)ocf_presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^ __nullable)(void))completion {
    if (@available(iOS 13.0, *)) {
        BOOL need = YES;
        if (self.ocf_automaticallySetModalPresentationStyle) {
            need = NO;
        } else {
            if ([self isKindOfClass:UIAlertController.class] ||
                [self isKindOfClass:UIImagePickerController.class]) {
                need = NO;
            } else {
                NSString *className = viewControllerToPresent.ocf_className;
                if ([className isEqualToString:@"PopupDialog"] ||
                    [className isEqualToString:@"TYAlertController"] ||
                    [className isEqualToString:@"SideMenuNavigationController"]) {
                    need = NO;
                }
            }
        }
        if (need) {
            viewControllerToPresent.modalPresentationStyle = UIModalPresentationFullScreen;
        }
    }
    [self ocf_presentViewController:viewControllerToPresent animated:flag completion:completion];
}

#pragma mark - Popup
#pragma mark property
- (UIViewController *)ocf_popupViewController {
    return objc_getAssociatedObject(self, kOCFPopupViewController);
}

- (void)setOcf_popupViewController:(UIViewController *)popupViewController {
    objc_setAssociatedObject(self, kOCFPopupViewController, popupViewController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (OCFPopupBackgroundView *)ocf_popupBackgroundView {
    return objc_getAssociatedObject(self, kOCFPopupBackgroundView);
}

- (void)setOcf_popupBackgroundView:(OCFPopupBackgroundView *)popupBackgroundView {
    objc_setAssociatedObject(self, kOCFPopupBackgroundView, popupBackgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setDismissedCallback:(void(^)(void))dismissed {
    objc_setAssociatedObject(self, &kOCFPopupDismissKey, dismissed, OBJC_ASSOCIATION_RETAIN);
}

- (void(^)(void))dismissedCallback {
    return objc_getAssociatedObject(self, &kOCFPopupDismissKey);
}

#pragma mark present
- (void)ocf_popupViewController:(UIViewController*)popupViewController animationType:(OCFViewControllerAnimationType)animationType layout:(OCFPopupLayout)layout bgTouch:(BOOL)bgTouch dismissed:(void(^)(void))dismissed {
    self.ocf_popupViewController = popupViewController;
    [self presentPopupView:popupViewController.view animationType:animationType layout:layout bgTouch:bgTouch dismissed:dismissed];
}

#pragma mark dismiss
- (void)ocf_closeViewControllerWithAnimationType:(OCFViewControllerAnimationType)animationType {
    [self ocf_closeViewControllerWithAnimationType:animationType dismissed:nil];
}

- (void)ocf_closeViewControllerWithAnimationType:(OCFViewControllerAnimationType)animationType dismissed:(void(^)(void))dismissed {
    UIView *sourceView = [self ocf_topView];
    UIView *popupView = [sourceView viewWithTag:kOCFPopupViewTag];
    UIView *overlayView = [sourceView viewWithTag:kOCFOverlayViewTag];
    
    //    switch (animationType) {
    //        case OCFCloseAnimationTypeNone:
    //            [self hideViewOut:popupView sourceView:sourceView overlayView:overlayView];
    //            break;
    //        case OCFCloseAnimationTypeFadeOut:
    //            [self fadeViewOut:popupView sourceView:sourceView overlayView:overlayView];
    //            break;
    //        case OCFCloseAnimationTypeGrowOut:
    //            [self growViewOut:popupView sourceView:sourceView overlayView:overlayView];
    //            break;
    //        case OCFCloseAnimationTypeShrinkOut:
    //            [self shrinkViewOut:popupView sourceView:sourceView overlayView:overlayView];
    //            break;
    //        case OCFCloseAnimationTypeSlideOutToTop:
    //        case OCFCloseAnimationTypeSlideOutToBottom:
    //        case OCFCloseAnimationTypeSlideOutToLeft:
    //        case OCFCloseAnimationTypeSlideOutToRight:
    //            [self slideViewOut:popupView sourceView:sourceView overlayView:overlayView withAnimationType:animationType];
    //            break;
    //        case OCFCloseAnimationTypeBounceOut:
    //        case OCFCloseAnimationTypeBounceOutToTop:
    //        case OCFCloseAnimationTypeBounceOutToBottom:
    //        case OCFCloseAnimationTypeBounceOutToLeft:
    //        case OCFCloseAnimationTypeBounceOutToRight:
    //            [self bounceViewOut:popupView sourceView:sourceView overlayView:overlayView withAnimationType:animationType];
    //            break;
    //        default:
    //            break;
    //    }
    [self hideViewIn:popupView sourceView:sourceView overlayView:overlayView animationType:animationType];
    [self setDismissedCallback:dismissed];
}

#pragma mark view
- (void)presentPopupView:(UIView *)popupView animationType:(OCFViewControllerAnimationType)animationType layout:(OCFPopupLayout)layout bgTouch:(BOOL)bgTouch dismissed:(void(^)(void))dismissed {
    UIView *sourceView = [self ocf_topView];
    sourceView.tag = kOCFSourceViewTag;
    popupView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
    popupView.tag = kOCFPopupViewTag;
    
    // check if source view controller is not in destination
    if ([sourceView.subviews containsObject:popupView]) return;
    
    // customize popupView
    popupView.layer.masksToBounds = NO;
//    popupView.layer.shadowPath = [UIBezierPath bezierPathWithRect:popupView.bounds].CGPath;
//    popupView.layer.shadowOffset = CGSizeMake(5, 5);
//    popupView.layer.shadowRadius = 5;
//    popupView.layer.shadowOpacity = 0.5;
//    popupView.layer.shouldRasterize = YES;
//    popupView.layer.rasterizationScale = UIScreen.mainScreen.scale;
    
    // Add semi overlay
    UIView *overlayView = [[UIView alloc] initWithFrame:sourceView.bounds];
    overlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    overlayView.tag = kOCFOverlayViewTag;
    overlayView.backgroundColor = [UIColor clearColor];
    
    // BackgroundView
    self.ocf_popupBackgroundView = [[OCFPopupBackgroundView alloc] initWithFrame:sourceView.bounds];
    self.ocf_popupBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.ocf_popupBackgroundView.backgroundColor = [UIColor clearColor];
    self.ocf_popupBackgroundView.alpha = 0.0f;
    [overlayView addSubview:self.ocf_popupBackgroundView];
    
    // Make the Background Clickable
    if (bgTouch) {
        UIButton * dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
        dismissButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        dismissButton.backgroundColor = [UIColor clearColor];
        dismissButton.frame = sourceView.bounds;
        dismissButton.tag = animationType;
        [dismissButton addTarget:self action:@selector(dismissButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [overlayView addSubview:dismissButton];
    }
    
    popupView.alpha = 0.0f;
    [overlayView addSubview:popupView];
    [sourceView addSubview:overlayView];
    
    [self showViewIn:popupView sourceView:sourceView overlayView:overlayView animationType:animationType layout:layout];
    [self setDismissedCallback:dismissed];
}

-(UIView *)ocf_topView {
    UIViewController *recentView = self;
    
    while (recentView.parentViewController != nil) {
        recentView = recentView.parentViewController;
    }
    return recentView.view;
}

- (void)dismissButtonPressed:(UIButton *)sender {
    [self ocf_closeViewControllerWithAnimationType:(OCFViewControllerAnimationType)sender.tag];
//    if ([sender isKindOfClass:[UIButton class]]) {
//        UIButton* dismissButton = sender;
////        switch (dismissButton.tag) {
////                //            case OCFPopupViewAnimationSlideBottomTop:
////                //            case OCFPopupViewAnimationSlideBottomBottom:
////                //            case OCFPopupViewAnimationSlideTopTop:
////                //            case OCFPopupViewAnimationSlideTopBottom:
////                //            case OCFPopupViewAnimationSlideLeftLeft:
////                //            case OCFPopupViewAnimationSlideLeftRight:
////                //            case OCFPopupViewAnimationSlideRightLeft:
////                //            case OCFPopupViewAnimationSlideRightRight:
////                //                [self dismissPopupViewControllerWithanimationType:(OCFPopupViewAnimation)dismissButton.tag];
////                //                break;
////                //            default:
////                //                [self dismissPopupViewControllerWithanimationType:OCFPopupViewAnimationFade];
////                //                break;
////            case OCFCloseAnimationTypeFadeOut:
////                break;
////            default:
////                break;
////        }
//        [self dismissPopupViewControllerWithanimation:(id)]
//    } else {
//        // [self dismissPopupViewControllerWithanimationType:OCFPopupViewAnimationFade];
//    }
}

#pragma mark animation
- (void)showViewIn:(UIView *)popupView sourceView:(UIView *)sourceView overlayView:(UIView *)overlayView animationType:(OCFViewControllerAnimationType)animationType layout:(OCFPopupLayout)layout {
    CGSize sourceSize = sourceView.bounds.size;
    CGSize popupSize = popupView.bounds.size; // popupView.frame.size;

    CGRect containerFrame = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                       (sourceSize.height - popupSize.height) / 2,
                                       popupSize.width,
                                       popupSize.height);
    
    CGRect finalContainerFrame = containerFrame;
    UIViewAutoresizing containerAutoresizingMask = UIViewAutoresizingNone;
    
    switch (layout.horizontal) {
            
        case OCFPopupLayoutHorizontalLeft: {
            finalContainerFrame.origin.x = 0.0;
            containerAutoresizingMask = containerAutoresizingMask | UIViewAutoresizingFlexibleRightMargin;
            break;
        }
            
        case OCFPopupLayoutHorizontalLeadCenter: {
            finalContainerFrame.origin.x = floorf(CGRectGetWidth(sourceView.bounds)/3.0 - CGRectGetWidth(containerFrame)/2.0);
            containerAutoresizingMask = containerAutoresizingMask | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
            break;
        }
            
        case OCFPopupLayoutHorizontalCenter: {
            finalContainerFrame.origin.x = floorf((CGRectGetWidth(sourceView.bounds) - CGRectGetWidth(containerFrame))/2.0);
            containerAutoresizingMask = containerAutoresizingMask | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
            break;
        }
            
        case OCFPopupLayoutHorizontalTrailCenter: {
            finalContainerFrame.origin.x = floorf(CGRectGetWidth(sourceView.bounds)*2.0/3.0 - CGRectGetWidth(containerFrame)/2.0);
            containerAutoresizingMask = containerAutoresizingMask | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
            break;
        }
            
        case OCFPopupLayoutHorizontalRight: {
            finalContainerFrame.origin.x = CGRectGetWidth(sourceView.bounds) - CGRectGetWidth(containerFrame);
            containerAutoresizingMask = containerAutoresizingMask | UIViewAutoresizingFlexibleLeftMargin;
            break;
        }
            
        default:
            break;
    }
    
    // Vertical
    switch (layout.vertical) {
        case OCFPopupLayoutVerticalTop: {
            finalContainerFrame.origin.y = 0;
            containerAutoresizingMask = containerAutoresizingMask | UIViewAutoresizingFlexibleBottomMargin;
            break;
        }
            
        case OCFPopupLayoutVerticalAboveCenter: {
            finalContainerFrame.origin.y = floorf(CGRectGetHeight(sourceView.bounds)/3.0 - CGRectGetHeight(containerFrame)/2.0);
            containerAutoresizingMask = containerAutoresizingMask | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
            break;
        }
            
        case OCFPopupLayoutVerticalCenter: {
            finalContainerFrame.origin.y = floorf((CGRectGetHeight(sourceView.bounds) - CGRectGetHeight(containerFrame))/2.0);
            containerAutoresizingMask = containerAutoresizingMask | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
            break;
        }
            
        case OCFPopupLayoutVerticalBelowCenter: {
            finalContainerFrame.origin.y = floorf(CGRectGetHeight(sourceView.bounds)*2.0/3.0 - CGRectGetHeight(containerFrame)/2.0);
            containerAutoresizingMask = containerAutoresizingMask | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
            break;
        }
            
        case OCFPopupLayoutVerticalBottom: {
            finalContainerFrame.origin.y = CGRectGetHeight(sourceView.bounds) - CGRectGetHeight(containerFrame);
            containerAutoresizingMask = containerAutoresizingMask | UIViewAutoresizingFlexibleTopMargin;
            break;
        }
            
        default:
            break;
    }
    
    popupView.autoresizingMask = containerAutoresizingMask;
    void (^animationBlock)(void) = ^() {
        [self.ocf_popupViewController viewWillAppear:NO];
        self.ocf_popupBackgroundView.alpha = 0.5f;
    };
    void (^completionBlock)(BOOL) = ^(BOOL finished) {
        [self.ocf_popupViewController viewDidAppear:NO];
    };
    
//    CGFloat durationTime = self.ocf_popupDurationTime;
//    if (!durationTime) {
//        durationTime = kOCFPopupAnimationDuration;
//    }
    
    CGFloat durationTime = kOCFPopupAnimationDuration;
    
    switch (animationType) {
        case OCFViewControllerAnimationTypeNone: {
            animationBlock();
            popupView.alpha = 1.0;
            popupView.transform = CGAffineTransformIdentity;
            popupView.frame = finalContainerFrame;
            completionBlock(YES);
            break;
        }
        case OCFViewControllerAnimationTypeFade: {
            popupView.frame = finalContainerFrame;
            popupView.alpha = 0.0f;
            [UIView animateWithDuration:durationTime animations:^{
                animationBlock();
                popupView.alpha = 1.0f;
            } completion:completionBlock];
            break;
        }
        case OCFViewControllerAnimationTypeGrow: {
            popupView.alpha = 0.0;
            popupView.frame = finalContainerFrame; // set frame before transform here...
            popupView.transform = CGAffineTransformMakeScale(0.85, 0.85);
            [UIView animateWithDuration:(durationTime / 2.0) delay:0 options:kOCFPopupAnimationOptionCurveIOS7 animations:^{
                animationBlock();
                popupView.alpha = 1.0;
                popupView.transform = CGAffineTransformIdentity; // set transform before frame here...
                popupView.frame = finalContainerFrame;
            } completion:completionBlock];
            break;
        }
        case OCFViewControllerAnimationTypeShrink: {
            popupView.alpha = 0.0;
            popupView.frame = finalContainerFrame;
            popupView.transform = CGAffineTransformMakeScale(1.25, 1.25);
            [UIView animateWithDuration:(durationTime / 2.0) delay:0 options:kOCFPopupAnimationOptionCurveIOS7 animations:^{
                animationBlock();
                popupView.alpha = 1.0;
                popupView.transform = CGAffineTransformIdentity; // set transform before frame here...
                popupView.frame = finalContainerFrame;
            } completion:completionBlock];
            break;
        }
        case OCFViewControllerAnimationTypeBounce: {
            popupView.alpha = 0.0;
            // set frame before transform here...
            CGRect startFrame = finalContainerFrame;
            popupView.frame = startFrame;
            popupView.transform = CGAffineTransformMakeScale(0.1, 0.1);
                
            [UIView animateWithDuration:(durationTime * 2) delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:15.0 options:0 animations:^{
                animationBlock();
                popupView.alpha = 1.0;
                popupView.transform = CGAffineTransformIdentity;
            } completion:completionBlock];
            break;
        }
//        case OCFPopupAnimationTypeSlideInFromTop: {
//            popupView.alpha = 1.0;
//            popupView.transform = CGAffineTransformIdentity;
//
//            CGRect startFrame = finalContainerFrame;
//            startFrame.origin.y = -CGRectGetHeight(finalContainerFrame);
//            popupView.frame = startFrame;
//
//
//            [UIView animateWithDuration:durationTime delay:0.0f options:kOCFPopupAnimationOptionCurveIOS7 animations:^{
//                animationBlock();
//                popupView.frame = finalContainerFrame;
//            } completion:completionBlock];
//            break;
//        }
//        case OCFPopupAnimationTypeSlideInFromBottom: {
//            popupView.alpha = 1.0;
//            popupView.transform = CGAffineTransformIdentity;
//
//            CGRect startFrame = finalContainerFrame;
//            startFrame.origin.y = CGRectGetHeight(sourceView.bounds);
//            popupView.frame = startFrame;
//
//            [UIView animateWithDuration:durationTime delay:0 options:kOCFPopupAnimationOptionCurveIOS7 animations:^{
//                animationBlock();
//                popupView.frame = finalContainerFrame;
//            } completion:completionBlock];
//            break;
//        }
//        case OCFPopupAnimationTypeSlideInFromLeft: {
//            popupView.alpha = 1.0;
//            popupView.transform = CGAffineTransformIdentity;
//
//            CGRect startFrame = finalContainerFrame;
//            startFrame.origin.x = -CGRectGetWidth(finalContainerFrame);
//            popupView.frame = startFrame;
//
//            [UIView animateWithDuration:durationTime delay:0 options:kOCFPopupAnimationOptionCurveIOS7 animations:^{
//                animationBlock();
//                popupView.frame = finalContainerFrame;
//            } completion:completionBlock];
//            break;
//        }
//        case OCFPopupAnimationTypeSlideInFromRight: {
//            popupView.alpha = 1.0;
//            popupView.transform = CGAffineTransformIdentity;
//
//            CGRect startFrame = finalContainerFrame;
//            startFrame.origin.x = CGRectGetWidth(sourceView.bounds);
//            popupView.frame = startFrame;
//
//            [UIView animateWithDuration:durationTime delay:0 options:kOCFPopupAnimationOptionCurveIOS7 animations:^{
//                animationBlock();
//                popupView.frame = finalContainerFrame;
//            } completion:completionBlock];
//            break;
//        }
//        case OCFPopupAnimationTypeBounceInFromTop: {
//            popupView.alpha = 1.0;
//            popupView.transform = CGAffineTransformIdentity;
//
//            CGRect startFrame = finalContainerFrame;
//            startFrame.origin.y = -CGRectGetHeight(finalContainerFrame);
//            popupView.frame = startFrame;
//
//            [UIView animateWithDuration:(durationTime * 2) delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:10.0 options:0 animations:^{
//                animationBlock();
//                popupView.frame = finalContainerFrame;
//            } completion:completionBlock];
//            break;
//        }
//        case OCFPopupAnimationTypeBounceInFromBottom: {
//            popupView.alpha = 1.0;
//            popupView.transform = CGAffineTransformIdentity;
//
//            CGRect startFrame = finalContainerFrame;
//            startFrame.origin.y = CGRectGetHeight(sourceView.bounds);
//            popupView.frame = startFrame;
//
//            [UIView animateWithDuration:(durationTime * 2) delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:10.0 options:0 animations:^{
//                animationBlock();
//                popupView.frame = finalContainerFrame;
//            } completion:completionBlock];
//            break;
//        }
//        case OCFPopupAnimationTypeBounceInFromLeft: {
//            popupView.alpha = 1.0;
//            popupView.transform = CGAffineTransformIdentity;
//
//            CGRect startFrame = finalContainerFrame;
//            startFrame.origin.x = -CGRectGetWidth(finalContainerFrame);
//            popupView.frame = startFrame;
//
//            [UIView animateWithDuration:(durationTime * 2) delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:10.0 options:0 animations:^{
//                animationBlock();
//                popupView.frame = finalContainerFrame;
//            } completion:completionBlock];
//            break;
//        }
//        case OCFPopupAnimationTypeBounceInFromRight: {
//            popupView.alpha = 1.0;
//            popupView.transform = CGAffineTransformIdentity;
//
//            CGRect startFrame = finalContainerFrame;
//            startFrame.origin.x = CGRectGetWidth(sourceView.bounds);
//            popupView.frame = startFrame;
//
//            [UIView animateWithDuration:(durationTime * 2) delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:10.0 options:0 animations:^{
//                animationBlock();
//                popupView.frame = finalContainerFrame;
//            } completion:completionBlock];
//            break;
//        }
        default:
            break;
    }
}

- (void)hideViewIn:(UIView *)popupView sourceView:(UIView *)sourceView overlayView:(UIView *)overlayView animationType:(OCFViewControllerAnimationType)animationType {
//    CGFloat durationTime = self.ocf_popupDurationTime;
//    if (!durationTime) {
//        durationTime = kOCFPopupAnimationDuration;
//    }
    
    CGFloat durationTime = kOCFPopupAnimationDuration;
    
    NSTimeInterval duration1 = (durationTime / 2.0);
    NSTimeInterval duration2 = durationTime;
    void (^animationBlock)(void) = ^() {
        [self.ocf_popupViewController viewWillDisappear:NO];
        self.ocf_popupBackgroundView.alpha = 0.0f;
    };
    void (^completionBlock)(BOOL) = ^(BOOL finished) {
        [popupView removeFromSuperview];
        [overlayView removeFromSuperview];
        [self.ocf_popupViewController viewDidDisappear:NO];
        self.ocf_popupViewController = nil;
        
        id dismissed = [self dismissedCallback];
        if (dismissed != nil) {
            ((void(^)(void))dismissed)();
            [self setDismissedCallback:nil];
        }
    };
    
    switch (animationType) {
        case OCFViewControllerAnimationTypeNone: {
            animationBlock();
            popupView.alpha = 0.0f;
            completionBlock(YES);
            break;
        }
        case OCFViewControllerAnimationTypeFade: {
            [UIView animateWithDuration:duration1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                animationBlock();
                popupView.alpha = 0.0;
            } completion:completionBlock];
            break;
        }
        case OCFViewControllerAnimationTypeGrow: {
            [UIView animateWithDuration:duration1 delay:0 options:kOCFPopupAnimationOptionCurveIOS7 animations:^{
                animationBlock();
                popupView.alpha = 0.0;
                popupView.transform = CGAffineTransformMakeScale(1.1, 1.1);
            } completion:completionBlock];
            break;
        }
        case OCFViewControllerAnimationTypeShrink: {
            [UIView animateWithDuration:duration1 delay:0 options:kOCFPopupAnimationOptionCurveIOS7 animations:^{
                animationBlock();
                popupView.alpha = 0.0;
                popupView.transform = CGAffineTransformMakeScale(0.8, 0.8);
            } completion:completionBlock];
            break;
        }
        case OCFViewControllerAnimationTypeBounce: {
            [UIView animateWithDuration:duration1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                popupView.transform = CGAffineTransformMakeScale(1.1, 1.1);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:duration2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    animationBlock();
                    popupView.alpha = 0.0;
                    popupView.transform = CGAffineTransformMakeScale(0.1, 0.1);
                } completion:completionBlock];
            }];
            break;
        }
//        case OCFCloseAnimationTypeSlideOutToTop: {
//            [UIView animateWithDuration:durationTime delay:0 options:kOCFPopupAnimationOptionCurveIOS7 animations:^{
//                animationBlock();
//                CGRect finalFrame = popupView.frame;
//                finalFrame.origin.y = -CGRectGetHeight(finalFrame);
//                popupView.frame = finalFrame;
//            } completion:completionBlock];
//            break;
//        }
//        case OCFCloseAnimationTypeSlideOutToBottom: {
//            [UIView animateWithDuration:durationTime delay:0 options:kOCFPopupAnimationOptionCurveIOS7 animations:^{
//                animationBlock();
//                CGRect finalFrame = popupView.frame;
//                finalFrame.origin.y = CGRectGetHeight(sourceView.bounds);
//                popupView.frame = finalFrame;
//            } completion:completionBlock];
//            break;
//        }
//        case OCFCloseAnimationTypeSlideOutToLeft: {
//            [UIView animateWithDuration:durationTime delay:0 options:kOCFPopupAnimationOptionCurveIOS7 animations:^{
//                animationBlock();
//                CGRect finalFrame = popupView.frame;
//                finalFrame.origin.x = -CGRectGetWidth(finalFrame);
//                popupView.frame = finalFrame;
//            } completion:completionBlock];
//            break;
//        }
//        case OCFCloseAnimationTypeSlideOutToRight: {
//            [UIView animateWithDuration:durationTime delay:0 options:kOCFPopupAnimationOptionCurveIOS7 animations:^{
//                animationBlock();
//                CGRect finalFrame = popupView.frame;
//                finalFrame.origin.x = CGRectGetWidth(sourceView.bounds);
//                popupView.frame = finalFrame;
//            } completion:completionBlock];
//            break;
//        }
//        case OCFCloseAnimationTypeBounceOutToTop: {
//            [UIView animateWithDuration:duration1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//                CGRect finalFrame = popupView.frame;
//                finalFrame.origin.y += 40.0;
//                popupView.frame = finalFrame;
//            } completion:^(BOOL finished) {
//                [UIView animateWithDuration:duration2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
//                    animationBlock();
//                    CGRect finalFrame = popupView.frame;
//                    finalFrame.origin.y = -CGRectGetHeight(finalFrame);
//                    popupView.frame = finalFrame;
//                } completion:completionBlock];
//            }];
//            break;
//        }
//        case OCFCloseAnimationTypeBounceOutToBottom: {
//            [UIView animateWithDuration:duration1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//                CGRect finalFrame = popupView.frame;
//                finalFrame.origin.y -= 40.0;
//                popupView.frame = finalFrame;
//            } completion:^(BOOL finished) {
//                [UIView animateWithDuration:duration2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
//                    animationBlock();
//                    CGRect finalFrame = popupView.frame;
//                    finalFrame.origin.y = CGRectGetHeight(sourceView.bounds);
//                    popupView.frame = finalFrame;
//                } completion:completionBlock];
//            }];
//            break;
//        }
//        case OCFCloseAnimationTypeBounceOutToLeft: {
//            [UIView animateWithDuration:duration1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//                CGRect finalFrame = popupView.frame;
//                finalFrame.origin.x += 40.0;
//                popupView.frame = finalFrame;
//            } completion:^(BOOL finished) {
//                [UIView animateWithDuration:duration2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
//                    animationBlock();
//                    CGRect finalFrame = popupView.frame;
//                    finalFrame.origin.x = -CGRectGetWidth(finalFrame);
//                    popupView.frame = finalFrame;
//                } completion:completionBlock];
//            }];
//            break;
//        }
//        case OCFCloseAnimationTypeBounceOutToRight: {
//            [UIView animateWithDuration:duration1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//                CGRect finalFrame = popupView.frame;
//                finalFrame.origin.x -= 40.0;
//                popupView.frame = finalFrame;
//            } completion:^(BOOL finished) {
//                [UIView animateWithDuration:duration2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
//                    animationBlock();
//                    CGRect finalFrame = popupView.frame;
//                    finalFrame.origin.x = CGRectGetWidth(sourceView.bounds);
//                    popupView.frame = finalFrame;
//                } completion:completionBlock];
//            }];
//            break;
//        }
        default:
            break;
    }
}

#pragma mark private
- (CGRect)getEndRectWithPopupView:(UIView *)popupView popupSize:(CGSize)popupSize sourceSize:(CGSize)sourceSize animationIndex:(NSInteger)animationIndex {
    CGRect endRect = CGRectZero;
    switch (animationIndex) {
        case 0:
            break;
        case 1:
            endRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                 -popupSize.height,
                                 popupSize.width,
                                 popupSize.height);
            break;
            
        case 2:
            endRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                 sourceSize.height,
                                 popupSize.width,
                                 popupSize.height);
            break;
            
        case 3:
            endRect = CGRectMake(-popupSize.width,
                                 popupView.frame.origin.y,
                                 popupSize.width,
                                 popupSize.height);
            break;
            
        case 4:
            endRect = CGRectMake(sourceSize.width,
                                 popupView.frame.origin.y,
                                 popupSize.width,
                                 popupSize.height);
            break;
            
        default:
            OCFLogDebug(kOCFLogTagNormal, @"不支持的动画类型！");
            break;
    }
    return endRect;
}
@end

OCFViewControllerAnimationType OCFViewControllerAnimationTypeFromString(NSString *value) {
    OCFViewControllerAnimationType type = OCFViewControllerAnimationTypeNone;
    if ([value isEqualToString:kOCFAnimationFade]) {
        type = OCFViewControllerAnimationTypeFade;
    } else if ([value isEqualToString:kOCFAnimationGrow]) {
        type = OCFViewControllerAnimationTypeGrow;
    } else if ([value isEqualToString:kOCFAnimationShrink]) {
        type = OCFViewControllerAnimationTypeShrink;
    } else if ([value isEqualToString:kOCFAnimationBounce]) {
        type = OCFViewControllerAnimationTypeBounce;
    }
    return type;
}
