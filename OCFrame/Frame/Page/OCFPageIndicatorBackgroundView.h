//
//  OCFPageIndicatorBackgroundView.h
//  OCFrame
//
//  Created by liaoya on 2021/12/30.
//

#import "OCFPageIndicatorComponentView.h"

@interface OCFPageIndicatorBackgroundView : OCFPageIndicatorComponentView
@property (nonatomic, assign) CGFloat backgroundViewWidth;     //默认kOCFAutomaticDimension（与cellWidth相等）
@property (nonatomic, assign) CGFloat backgroundViewWidthIncrement;    //宽度增量补偿，因为backgroundEllipseLayer一般会比实际内容大一些。默认10
@property (nonatomic, assign) CGFloat backgroundViewHeight;   //默认kOCFAutomaticDimension（与cell高度相等）
@property (nonatomic, assign) CGFloat backgroundViewCornerRadius;   //默认kOCFAutomaticDimension(即backgroundViewHeight/2)
@property (nonatomic, strong) UIColor *backgroundViewColor;   //默认为[UIColor redColor]

@end
