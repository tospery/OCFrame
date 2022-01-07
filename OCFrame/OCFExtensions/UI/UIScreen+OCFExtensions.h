//
//  UIScreen+OCFExtensions.h
//  OCFrame
//
//  Created by liaoya on 2022/1/7.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import <Giotto/SDThemeManager.h>
#import <QMUIKit/QMUIKit.h>

#pragma mark Dimension
#define kOCFDimensionMargin     ([(NSNumber *)SDThemeManagerValueForConstant(@"DIMENSION_MARGIN") floatValue])
#define kOCFDimensionPadding    ([(NSNumber *)SDThemeManagerValueForConstant(@"DIMENSION_PADDING") floatValue])
#define kOCFDimensionAutomatic  (-1)

#pragma mark Screen
#define IS_SMALL_SCREEN         (DEVICE_WIDTH <= 320)
#define IS_MIDDLE_SCREEN        (DEVICE_WIDTH > 320 && DEVICE_WIDTH < 414)
#define IS_LARGE_SCREEN         (DEVICE_WIDTH >= 414)

@interface UIScreen (OCFExtensions)

@end


#pragma mark - Fit
CG_INLINE CGFloat
OCFMetric(CGFloat value) {
    return flat(value / 375.f * DEVICE_WIDTH);
}

CG_INLINE CGFloat
OCFPrefer(CGFloat small, CGFloat middle, CGFloat large) {
    return flat(IS_SMALL_SCREEN ? small : (IS_MIDDLE_SCREEN ? middle : large));
}

CG_INLINE CGFloat
OCFScale(CGFloat value) {
    return flat(value * DEVICE_WIDTH);
}
