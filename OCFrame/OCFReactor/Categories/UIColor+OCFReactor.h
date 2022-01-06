//
//  UIColor+OCFReactor.h
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import <UIKit/UIKit.h>
#import <QMUIKit/QMUIKit.h>
#import <Giotto/SDThemeManager.h>

#define OCFColorRGB(r, g, b)                (UIColorMake((r), (g), (b)))
#define OCFColorStr(string)                 ([UIColor qmui_colorWithHexString:(string)])
#define OCFColorKey(key)                    (SDThemeManagerValueForConstant(key))

@interface UIColor (OCFReactor)
@property (nonatomic, assign, readonly) CGFloat ocf_red;
@property (nonatomic, assign, readonly) CGFloat ocf_green;
@property (nonatomic, assign, readonly) CGFloat ocf_blue;
@property (nonatomic, assign, readonly) CGFloat ocf_alpha;
@property (class, nonatomic, strong, readonly) UIColor *ocf_clear;
@property (class, nonatomic, strong, readonly) UIColor *ocf_white;
@property (class, nonatomic, strong, readonly) UIColor *ocf_black;
@property (class, nonatomic, strong, readonly) UIColor *ocf_primary;
@property (class, nonatomic, strong, readonly) UIColor *ocf_secondary;
@property (class, nonatomic, strong, readonly) UIColor *ocf_special;
@property (class, nonatomic, strong, readonly) UIColor *ocf_border;
@property (class, nonatomic, strong, readonly) UIColor *ocf_separator;
@property (class, nonatomic, strong, readonly) UIColor *ocf_indicator;
@property (class, nonatomic, strong, readonly) UIColor *ocf_background;
@property (class, nonatomic, strong, readonly) UIColor *ocf_foreground;
@property (class, nonatomic, strong, readonly) UIColor *ocf_bright;
@property (class, nonatomic, strong, readonly) UIColor *ocf_dim;
@property (class, nonatomic, strong, readonly) UIColor *ocf_title;
@property (class, nonatomic, strong, readonly) UIColor *ocf_body;
@property (class, nonatomic, strong, readonly) UIColor *ocf_header;
@property (class, nonatomic, strong, readonly) UIColor *ocf_footer;
@property (class, nonatomic, strong, readonly) UIColor *ocf_barTint;
@property (class, nonatomic, strong, readonly) UIColor *ocf_barText;

+ (UIColor *)ocf_colorWithHex:(NSInteger)hexValue;
+ (UIColor *)ocf_colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha;

@end

