//
//  OCFPageFactory.m
//  OCFrame
//
//  Created by liaoya on 2021/12/30.
//

#import "OCFPageFactory.h"
#import "UIColor+OCFrame.h"

@interface OCFPageFactory ()

@end

@implementation OCFPageFactory

+ (CGFloat)interpolationFrom:(CGFloat)from to:(CGFloat)to percent:(CGFloat)percent {
    percent = MAX(0, MIN(1, percent));
    return from + (to - from)*percent;
}

+ (UIColor *)interpolationColorFrom:(UIColor *)fromColor to:(UIColor *)toColor percent:(CGFloat)percent {
    CGFloat red = [self interpolationFrom:fromColor.ocf_red to:toColor.ocf_red percent:percent];
    CGFloat green = [self interpolationFrom:fromColor.ocf_green to:toColor.ocf_green percent:percent];
    CGFloat blue = [self interpolationFrom:fromColor.ocf_blue to:toColor.ocf_blue percent:percent];
    CGFloat alpha = [self interpolationFrom:fromColor.ocf_alpha to:toColor.ocf_alpha percent:percent];
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
