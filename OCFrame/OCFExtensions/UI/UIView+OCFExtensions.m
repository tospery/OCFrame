//
//  UIView+OCFExtensions.m
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import "UIView+OCFExtensions.h"
#import <QMUIKit/QMUIKit.h>

@implementation UIView (OCFExtensions)

- (CGFloat)ocf_borderWidth {
    return self.layer.borderWidth;
}

- (void)setOcf_borderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = flat(borderWidth);
}

- (CGFloat)ocf_cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setOcf_cornerRadius:(CGFloat)cornerRadius {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = flat(cornerRadius);
}

- (OCFBorderLayer *)ocf_borderLayer {
    if ([self.layer isKindOfClass:OCFBorderLayer.class]) {
        return (OCFBorderLayer *)self.layer;
    }
    return nil;
}

@end
