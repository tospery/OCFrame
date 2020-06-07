//
//  UIScrollView+OCFrame.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import "UIScrollView+OCFrame.h"
#import <objc/runtime.h>
#import <QMUIKit/QMUIKit.h>

@implementation UIScrollView (OCFrame)
//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        ExchangeImplementations(self.class, @selector(setFrame:), @selector(ocf_setFrame:));
//    });
//}
//
//- (void)ocf_setFrame:(CGRect)frame {
//    [self ocf_setFrame:frame];
//    self.ocf_contentView.frame = self.bounds;
//}

static char kAssociatedObjectKey_contentView;
- (void)setBzm_contentView:(UIView *)ocf_contentView {
    UIView *contentView = self.ocf_contentView;
    if (contentView) {
        [contentView removeFromSuperview];
    }
    if (ocf_contentView) {
        [self addSubview:ocf_contentView];
        ocf_contentView.frame = self.bounds;
    }
    objc_setAssociatedObject(self, &kAssociatedObjectKey_contentView, ocf_contentView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)ocf_contentView {
    return (UIView *)objc_getAssociatedObject(self, &kAssociatedObjectKey_contentView);
}

@end
