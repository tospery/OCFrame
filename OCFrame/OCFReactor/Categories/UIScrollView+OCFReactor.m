//
//  UIScrollView+OCFReactor.m
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import "UIScrollView+OCFReactor.h"
#import <objc/runtime.h>

@implementation UIScrollView (OCFReactor)

static char kAssociatedObjectKey_contentView;
- (void)setOcf_contentView:(UIView *)ocf_contentView {
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
