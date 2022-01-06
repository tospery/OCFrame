//
//  UIColor+OCFrame.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "UIColor+OCFrame.h"

@implementation UIColor (OCFrame)

- (CGFloat)ocf_red {
    CGFloat r = 0, g, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return r;
}

- (CGFloat)ocf_green {
    CGFloat r, g = 0, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return g;
}

- (CGFloat)ocf_blue {
    CGFloat r, g, b = 0, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return b;
}

- (CGFloat)ocf_alpha {
    return CGColorGetAlpha(self.CGColor);
}

+ (UIColor *)ocf_colorWithHex:(NSInteger)hexValue {
    return [UIColor ocf_colorWithHex:hexValue alpha:1.0];
}

+ (UIColor *)ocf_colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha {
    CGFloat red = ((CGFloat)((hexValue & 0xFF0000) >> 16)) / 255.0;
    CGFloat green = ((CGFloat)((hexValue & 0xFF00) >> 8)) / 255.0;
    CGFloat blue = ((CGFloat)(hexValue & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)ocf_clear { return OCFColorKey(@"COLOR_CLEAR"); }
+ (UIColor *)ocf_white { return OCFColorKey(@"COLOR_WHITE"); }
+ (UIColor *)ocf_black { return OCFColorKey(@"COLOR_BLACK"); }
+ (UIColor *)ocf_primary { return OCFColorKey(@"COLOR_PRIMARY"); }
+ (UIColor *)ocf_secondary { return OCFColorKey(@"COLOR_SECONDARY"); }
+ (UIColor *)ocf_special { return OCFColorKey(@"COLOR_SPECIAL"); }
+ (UIColor *)ocf_border { return OCFColorKey(@"COLOR_BORDER"); }
+ (UIColor *)ocf_separator { return OCFColorKey(@"COLOR_SEPARATOR"); }
+ (UIColor *)ocf_indicator { return OCFColorKey(@"COLOR_INDICATOR"); }
+ (UIColor *)ocf_background { return OCFColorKey(@"COLOR_BACKGROUND"); }
+ (UIColor *)ocf_foreground { return OCFColorKey(@"COLOR_FOREGROUND"); }
+ (UIColor *)ocf_bright { return OCFColorKey(@"COLOR_BRIGHT"); }
+ (UIColor *)ocf_dim { return OCFColorKey(@"COLOR_DIM"); }
+ (UIColor *)ocf_title { return OCFColorKey(@"COLOR_TITLE"); }
+ (UIColor *)ocf_body { return OCFColorKey(@"COLOR_BODY"); }
+ (UIColor *)ocf_header { return OCFColorKey(@"COLOR_HEADER"); }
+ (UIColor *)ocf_footer { return OCFColorKey(@"COLOR_FOOTER"); }
+ (UIColor *)ocf_barTint { return OCFColorKey(@"COLOR_BARTINT"); }
+ (UIColor *)ocf_barText { return OCFColorKey(@"COLOR_BARTEXT"); }

@end
