//
//  UIColor+OCFrame.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import <UIKit/UIKit.h>
#import <QMUIKit/QMUIKit.h>
#import <Giotto/SDThemeManager.h>

#define OCFColorRGB(r, g, b)                (UIColorMake((r), (g), (b)))
//#define OCFColorVal(value)                  ([UIColor ocf_colorWithHex:(value)])
#define OCFColorStr(string)                 ([UIColor qmui_colorWithHexString:(string)])
#define OCFColorKey(key)                    (SDThemeManagerValueForConstant(key))

@interface UIColor (OCFrame)
@property (nonatomic, assign, readonly) CGFloat ocf_red;
@property (nonatomic, assign, readonly) CGFloat ocf_green;
@property (nonatomic, assign, readonly) CGFloat ocf_blue;
@property (nonatomic, assign, readonly) CGFloat ocf_alpha;

@property(class, nonatomic, readonly) UIColor *ocf_clear;
@property(class, nonatomic, readonly) UIColor *ocf_white;
@property(class, nonatomic, readonly) UIColor *ocf_black;
@property(class, nonatomic, readonly) UIColor *ocf_primary;
@property(class, nonatomic, readonly) UIColor *ocf_secondary;
@property(class, nonatomic, readonly) UIColor *ocf_special;
@property(class, nonatomic, readonly) UIColor *ocf_border;
@property(class, nonatomic, readonly) UIColor *ocf_separator;
@property(class, nonatomic, readonly) UIColor *ocf_indicator;
@property(class, nonatomic, readonly) UIColor *ocf_background;
@property(class, nonatomic, readonly) UIColor *ocf_foreground;
@property(class, nonatomic, readonly) UIColor *ocf_bright;
@property(class, nonatomic, readonly) UIColor *ocf_dim;
@property(class, nonatomic, readonly) UIColor *ocf_title;
@property(class, nonatomic, readonly) UIColor *ocf_body;
@property(class, nonatomic, readonly) UIColor *ocf_header;
@property(class, nonatomic, readonly) UIColor *ocf_footer;
@property(class, nonatomic, readonly) UIColor *ocf_barTint;
@property(class, nonatomic, readonly) UIColor *ocf_barText;

+ (UIColor *)ocf_colorWithHex:(NSInteger)hexValue;
+ (UIColor *)ocf_colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha;

@end

