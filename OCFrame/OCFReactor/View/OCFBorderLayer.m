//
//  OCFBorderLayer.m
//  OCFrame
//
//  Created by liaoya on 2022/1/7.
//

#import "OCFBorderLayer.h"
#import <QMUIKit/QMUIKit.h>
#import "NSDictionary+OCFExtensions.h"
#import "UIColor+OCFExtensions.h"

@interface OCFBorderLayer ()
@property (nonatomic, strong) CALayer *topBorder;
@property (nonatomic, strong) CALayer *bottomBorder;
@property (nonatomic, strong) CALayer *leftBorder;
@property (nonatomic, strong) CALayer *rightBorder;
@property (nonatomic, strong) NSArray *shadowLayers;

@end

@implementation OCFBorderLayer
#pragma mark - Init
- (instancetype)init {
    if (self = [super init]) {
        self.borderColor = nil;
        self.borderWidth = 0;
        
        [self addSublayer:self.topBorder];
        [self addSublayer:self.bottomBorder];
        [self addSublayer:self.leftBorder];
        [self addSublayer:self.rightBorder];
        
        for (CALayer *layer in self.shadowLayers) {
            [self addSublayer:layer];
        }
        
        [self updateBordersHidden];
        [self updateBordersColor];
    }
    return self;
}

#pragma mark - Property
- (CALayer *)topBorder {
    if (!_topBorder) {
        _topBorder = CALayer.layer;
    }
    return _topBorder;
}

- (CALayer *)bottomBorder {
    if (!_bottomBorder) {
        _bottomBorder = CALayer.layer;
    }
    return _bottomBorder;
}

- (CALayer *)leftBorder {
    if (!_leftBorder) {
        _leftBorder = CALayer.layer;
    }
    return _leftBorder;
}

- (CALayer *)rightBorder {
    if (!_rightBorder) {
        _rightBorder = CALayer.layer;
    }
    return _rightBorder;
}

- (NSArray *)shadowLayers {
    if (!_shadowLayers) {
        _shadowLayers = @[CALayer.layer, CALayer.layer, CALayer.layer];
    }
    return _shadowLayers;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self updateBordersFrame];
}

- (void)setBorderPosition:(OCFBorderPosition)borderPosition {
    _borderPosition = borderPosition;
    [self updateBordersHidden];
}

- (void)setBorderColors:(NSDictionary *)borderColors {
    _borderColors = borderColors;
    [self updateBordersColor];
}

- (void)setBorderThicks:(NSDictionary *)borderThicks {
    _borderThicks = borderThicks;
    [self updateBordersFrame];
}

- (void)setBorderInsets:(NSDictionary *)borderInsets {
    _borderInsets = borderInsets;
    [self updateBordersFrame];
}

#pragma mark - Method
- (void)layoutSublayers {
    [super layoutSublayers];
    self.topBorder.zPosition = self.sublayers.count;
    self.leftBorder.zPosition = self.topBorder.zPosition;
    self.bottomBorder.zPosition = self.topBorder.zPosition;
    self.rightBorder.zPosition = self.topBorder.zPosition;
    
    if ((self.borderPosition & OCFBorderPositionShadow) == OCFBorderPositionShadow) {
        [CATransaction begin];
        [CATransaction setValue:(id) kCFBooleanTrue forKey:kCATransactionDisableActions];
        for (NSInteger i = 0; i < self.shadowLayers.count; ++i) {
            CALayer *layer = self.shadowLayers[i];
            layer.frame = CGRectMake(0, self.bounds.size.height + ((CGFloat)i / UIScreen.mainScreen.scale), self.bottomBorder.bounds.size.width, PixelOne);
        }
        [CATransaction commit];
    }
}

- (void)updateBordersHidden {
    self.topBorder.hidden = ((self.borderPosition & OCFBorderPositionTop) != OCFBorderPositionTop);
    self.bottomBorder.hidden = ((self.borderPosition & OCFBorderPositionBottom) != OCFBorderPositionBottom);
    self.leftBorder.hidden = ((self.borderPosition & OCFBorderPositionLeft) != OCFBorderPositionLeft);
    self.rightBorder.hidden = ((self.borderPosition & OCFBorderPositionRight) != OCFBorderPositionRight);
    
    BOOL shadowHidden = ((self.borderPosition & OCFBorderPositionShadow) != OCFBorderPositionShadow);
    for (CALayer *layer in self.shadowLayers) {
        layer.hidden = shadowHidden;
    }
}

- (void)updateBordersColor {
    self.topBorder.backgroundColor = [self colorForBorder:OCFBorderPositionTop].CGColor;
    self.bottomBorder.backgroundColor = [self colorForBorder:OCFBorderPositionBottom].CGColor;
    self.leftBorder.backgroundColor = [self colorForBorder:OCFBorderPositionLeft].CGColor;
    self.rightBorder.backgroundColor = [self colorForBorder:OCFBorderPositionRight].CGColor;
    
    if ((self.borderPosition & OCFBorderPositionShadow) == OCFBorderPositionShadow) {
        UIColor *color = [self colorForBorder:OCFBorderPositionShadow];
        for (NSInteger i = 0; i < self.shadowLayers.count; ++i) {
            CGFloat alpha = ((CGFloat)(self.shadowLayers.count - i - 0.6) / (CGFloat)self.shadowLayers.count);
            CALayer *layer = self.shadowLayers[i];
            layer.backgroundColor = [color colorWithAlphaComponent:alpha].CGColor;
        }
    }
}

- (void)updateBordersFrame {
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    
    CGFloat thick = [self thickForBorder:OCFBorderPositionTop];
    UIEdgeInsets insets = [self insetsForBorder:OCFBorderPositionTop];
    self.topBorder.frame = CGRectMake(insets.left, 0, self.bounds.size.width - insets.left - insets.right, thick);
    
    thick = [self thickForBorder:OCFBorderPositionBottom];
    insets = [self insetsForBorder:OCFBorderPositionBottom];
    self.bottomBorder.frame = CGRectMake(insets.left, self.bounds.size.height - thick, self.bounds.size.width - insets.left - insets.right, thick);
    
    thick = [self thickForBorder:OCFBorderPositionLeft];
    insets = [self insetsForBorder:OCFBorderPositionLeft];
    self.leftBorder.frame = CGRectMake(0, insets.top, thick, self.bounds.size.height - insets.top - insets.bottom);
    
    thick = [self thickForBorder:OCFBorderPositionRight];
    insets = [self insetsForBorder:OCFBorderPositionRight];
    self.rightBorder.frame = CGRectMake(self.bounds.size.width - thick, insets.top, thick, self.bounds.size.height - insets.top - insets.bottom);
    
    [CATransaction commit];
}

- (UIColor *)colorForBorder:(OCFBorderPosition)position {
    UIColor *color = OCFColorMember(self.borderColors, @(position), nil);
    if (!color || ![color isKindOfClass:UIColor.class]) {
        return UIColor.ocf_border;
    }
    return color;
}

- (CGFloat)thickForBorder:(OCFBorderPosition)position {
    NSNumber *thick = OCFNumMember(self.borderThicks, @(position), nil);
    if (!thick || ![thick isKindOfClass:NSNumber.class]) {
        return PixelOne;
    }
    return thick.floatValue;
}

- (UIEdgeInsets)insetsForBorder:(OCFBorderPosition)position {
    NSString *str = OCFStrMember(self.borderInsets, @(position), nil);
    if (!str || ![str isKindOfClass:NSString.class]) {
        return UIEdgeInsetsZero;
    }
    return UIEdgeInsetsFromString(str);
}

@end
