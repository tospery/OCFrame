//
//  OCFPageIndicatorLineView.h
//  OCFrame
//
//  Created by liaoya on 2021/12/30.
//

#import "OCFPageIndicatorComponentView.h"

typedef NS_ENUM(NSUInteger, OCFPageIndicatorLineStyle) {
    OCFPageIndicatorLineStyleNormal = 0,
    OCFPageIndicatorLineStyleJD,
    OCFPageIndicatorLineStyleIQIYI,
};

@interface OCFPageIndicatorLineView : OCFPageIndicatorComponentView
@property (nonatomic, assign) OCFPageIndicatorLineStyle lineStyle;

/**
 line滚动时x的偏移量，默认为10；
 lineStyle为JXCategoryLineStyle_IQIYI有用；
 */
@property (nonatomic, assign) CGFloat lineScrollOffsetX;

/// 默认：3
@property (nonatomic, assign) CGFloat indicatorLineViewHeight;

@property (nonatomic, assign) CGFloat indicatorLineWidth;    //默认kOCFAutomaticDimension（与cellWidth相等）

@property (nonatomic, assign) CGFloat indicatorLineViewCornerRadius;    //默认kOCFAutomaticDimension （等于self.indicatorLineViewHeight/2）

@property (nonatomic, strong) UIColor *indicatorLineViewColor;   //默认为[UIColor redColor]

@end
