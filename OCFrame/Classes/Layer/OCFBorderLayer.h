//
//  OCFBorderLayer.h
//  OCFrame
//
//  Created by 杨建祥 on 2020/2/25.
//

#import <QuartzCore/QuartzCore.h>
//#import <SwiftTheme/SwiftTheme-Swift.h>

typedef NS_OPTIONS(NSUInteger, OCFBorderPosition) {
    OCFBorderPositionNone       = 0,
    OCFBorderPositionTop        = 1 << 0,
    OCFBorderPositionLeft       = 1 << 1,
    OCFBorderPositionBottom     = 1 << 2,
    OCFBorderPositionRight      = 1 << 3,
    OCFBorderPositionShadow     = 1 << 4
};

@interface OCFBorderLayer : CALayer
@property(nonatomic, assign) OCFBorderPosition borderPosition;
@property(nonatomic, strong) NSDictionary *borderColors;
@property(nonatomic, strong) NSDictionary *borderThicks;
@property(nonatomic, strong) NSDictionary *borderInsets;

@end

//@interface OCFBorderLayer (OCFrame)
//@property(nonatomic, strong) ThemeColorPicker *theme_defaultColor;
//
//@end
