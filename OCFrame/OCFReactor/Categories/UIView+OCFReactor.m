//
//  UIView+OCFReactor.m
//  OCFrame
//
//  Created by liaoya on 2022/1/7.
//

#import "UIView+OCFReactor.h"

@implementation UIView (OCFReactor)

- (OCFBorderLayer *)ocf_borderLayer {
    if ([self.layer isKindOfClass:OCFBorderLayer.class]) {
        return (OCFBorderLayer *)self.layer;
    }
    return nil;
}

@end
